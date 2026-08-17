using System;
using SDL2;
using wgpu_Beef;

namespace wgpu_Beef_Test;

// WebGPU triangle, native (Win64) and browser (wasm32) from one source.
//
// Per-platform bits (#if BF_PLATFORM_WASM):
//   * Surface: SDL2 + WGPUSurfaceSourceWindowsHWND (native) vs the emdawnwebgpu
//     canvas selector (web).
//   * Loop: a blocking SDL event loop (native) vs emscripten_set_main_loop (web),
//     since the browser can't be blocked.
// Everything else — adapter/device request chain, surface config, pipeline, and
// the per-frame render — is shared.
class Program
{
	const int32 WIDTH = 800;
	const int32 HEIGHT = 600;

#if BF_PLATFORM_WASM
	// emdawnwebgpu-only canvas surface source. The sType value (0x00040000) and
	// the struct layout are taken verbatim from the emdawnwebgpu webgpu.h header.
	const WGPUSType WGPUSType_EmscriptenSurfaceSourceCanvasHTMLSelector = (.)0x00040000;

	[CRepr]
	struct WGPUEmscriptenSurfaceSourceCanvasHTMLSelector
	{
		public WGPUChainedStruct chain;
		public WGPUStringView selector;
	}

	// Emscripten's frame-loop driver: hands control back to the browser.
	[LinkName("emscripten_set_main_loop")]
	static extern void emscripten_set_main_loop(function void() func, int32 fps, int32 simulateInfiniteLoop);
#endif

	const String SHADER_WGSL = """
		@vertex fn vs_main(@builtin(vertex_index) idx: u32) -> @builtin(position) vec4<f32> {
			var p = array<vec2<f32>, 3>(vec2<f32>(0.0, 0.5), vec2<f32>(-0.5, -0.5), vec2<f32>(0.5, -0.5));
			return vec4<f32>(p[idx], 0.0, 1.0);
		}
		@fragment fn fs_main() -> @location(0) vec4<f32> {
			return vec4<f32>(1.0, 0.6, 0.1, 1.0);
		}
		""";

	static WGPUInstance sInstance;
	static WGPUSurface sSurface;
	static WGPUAdapter sAdapter;
	static WGPUDevice sDevice;
	static WGPUQueue sQueue;
	static WGPURenderPipeline sPipeline;
	static WGPUTextureFormat sFormat = .WGPUTextureFormat_BGRA8Unorm;
	static WGPUSurfaceConfiguration sConfig;
	static bool sReady = false;

	static WGPUStringView SV(StringView s)
	{
		return .() { data = s.Ptr, length = (uint)s.Length };
	}

	// Adapter ready -> request the device. (Fires synchronously on native,
	// asynchronously in the browser; both end up here.)
	static void OnAdapter(WGPURequestAdapterStatus status, WGPUAdapter adapter, WGPUStringView message, void* u1, void* u2)
	{
		if (status != .WGPURequestAdapterStatus_Success)
		{
			Console.WriteLine("RequestAdapter failed: {0}", status);
			return;
		}
		sAdapter = adapter;

		WGPURequestDeviceCallbackInfo cb = .();
		cb.mode = .WGPUCallbackMode_AllowSpontaneous;
		cb.callback = => OnDevice;
		wgpuAdapterRequestDevice(sAdapter, null, cb);
	}

	// Device ready -> grab the queue, configure the surface, build the pipeline.
	static void OnDevice(WGPURequestDeviceStatus status, WGPUDevice device, WGPUStringView message, void* u1, void* u2)
	{
		if (status != .WGPURequestDeviceStatus_Success)
		{
			Console.WriteLine("RequestDevice failed: {0}", status);
			return;
		}
		sDevice = device;
		sQueue = wgpuDeviceGetQueue(sDevice);
		ConfigureAndBuildPipeline();
		sReady = true;
	}

	static void ConfigureAndBuildPipeline()
	{
		// Negotiate a supported surface format (formats are best-first).
		WGPUSurfaceCapabilities caps = .();
		if (wgpuSurfaceGetCapabilities(sSurface, sAdapter, &caps) == .WGPUStatus_Success)
		{
			if (caps.formatCount > 0)
				sFormat = caps.formats[0];
			wgpuSurfaceCapabilitiesFreeMembers(caps);
		}

		sConfig = .();
		sConfig.device = sDevice;
		sConfig.format = sFormat;
		sConfig.usage = WGPUTextureUsage_RenderAttachment;
		sConfig.width = (uint32)WIDTH;
		sConfig.height = (uint32)HEIGHT;
		sConfig.presentMode = .WGPUPresentMode_Fifo;
		sConfig.alphaMode = .WGPUCompositeAlphaMode_Auto;
		wgpuSurfaceConfigure(sSurface, &sConfig);

		// Shader module.
		WGPUShaderSourceWGSL wgslSource = .();
		wgslSource.chain.sType = .WGPUSType_ShaderSourceWGSL;
		wgslSource.code = SV(SHADER_WGSL);
		WGPUShaderModuleDescriptor shaderDesc = .();
		shaderDesc.nextInChain = (WGPUChainedStruct*)&wgslSource;
		let shader = wgpuDeviceCreateShaderModule(sDevice, &shaderDesc);

		// Pipeline.
		WGPUColorTargetState colorTarget = .();
		colorTarget.format = sFormat;
		colorTarget.writeMask = WGPUColorWriteMask_All;

		WGPUFragmentState fragment = .();
		fragment.module = shader;
		fragment.entryPoint = SV("fs_main");
		fragment.targetCount = 1;
		fragment.targets = &colorTarget;

		WGPURenderPipelineDescriptor pipelineDesc = .();
		pipelineDesc.vertex.module = shader;
		pipelineDesc.vertex.entryPoint = SV("vs_main");
		pipelineDesc.primitive.topology = .WGPUPrimitiveTopology_TriangleList;
		pipelineDesc.multisample.count = 1;
		pipelineDesc.multisample.mask = 0xFFFFFFFF;
		pipelineDesc.fragment = &fragment;
		sPipeline = wgpuDeviceCreateRenderPipeline(sDevice, &pipelineDesc);

		wgpuShaderModuleRelease(shader);
	}

	static void Frame()
	{
		if (!sReady)
			return; // still waiting on async adapter/device (browser)

		WGPUSurfaceTexture surfaceTex = .();
		wgpuSurfaceGetCurrentTexture(sSurface, &surfaceTex);

#if !BF_PLATFORM_WASM
		// Native: a resize can leave the surface needing reconfiguration.
		if ((surfaceTex.status == .WGPUSurfaceGetCurrentTextureStatus_Timeout) ||
			(surfaceTex.status == .WGPUSurfaceGetCurrentTextureStatus_Outdated) ||
			(surfaceTex.status == .WGPUSurfaceGetCurrentTextureStatus_Lost))
		{
			if (surfaceTex.texture != null)
				wgpuTextureRelease(surfaceTex.texture);
			wgpuSurfaceConfigure(sSurface, &sConfig);
			return;
		}
#endif

		if ((surfaceTex.status != .WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal) &&
			(surfaceTex.status != .WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal))
		{
			if (surfaceTex.texture != null)
				wgpuTextureRelease(surfaceTex.texture);
			return;
		}

		let view = wgpuTextureCreateView(surfaceTex.texture, null);
		let encoder = wgpuDeviceCreateCommandEncoder(sDevice, null);

		WGPURenderPassColorAttachment colorAttachment = .();
		colorAttachment.view = view;
		colorAttachment.depthSlice = WGPU_DEPTH_SLICE_UNDEFINED;
		colorAttachment.loadOp = .WGPULoadOp_Clear;
		colorAttachment.storeOp = .WGPUStoreOp_Store;
		colorAttachment.clearValue = .() { r = 0.1, g = 0.1, b = 0.12, a = 1.0 };

		WGPURenderPassDescriptor passDesc = .();
		passDesc.colorAttachmentCount = 1;
		passDesc.colorAttachments = &colorAttachment;

		let pass = wgpuCommandEncoderBeginRenderPass(encoder, &passDesc);
		wgpuRenderPassEncoderSetPipeline(pass, sPipeline);
		wgpuRenderPassEncoderDraw(pass, 3, 1, 0, 0);
		wgpuRenderPassEncoderEnd(pass);
		wgpuRenderPassEncoderRelease(pass);

		var cmd = wgpuCommandEncoderFinish(encoder, null);
		wgpuQueueSubmit(sQueue, 1, &cmd);
#if !BF_PLATFORM_WASM
		wgpuSurfacePresent(sSurface); // browser presents automatically
#endif

		wgpuCommandBufferRelease(cmd);
		wgpuCommandEncoderRelease(encoder);
		wgpuTextureViewRelease(view);
		wgpuTextureRelease(surfaceTex.texture);
	}

	public static void Main()
	{
		sInstance = wgpuCreateInstance(null);

#if BF_PLATFORM_WASM
		// Surface from the page's <canvas id="canvas">.
		WGPUEmscriptenSurfaceSourceCanvasHTMLSelector fromCanvas = .();
		fromCanvas.chain.sType = WGPUSType_EmscriptenSurfaceSourceCanvasHTMLSelector;
		fromCanvas.selector = .() { data = "#canvas", length = WGPU_STRLEN };
		WGPUSurfaceDescriptor surfaceDesc = .();
		surfaceDesc.nextInChain = (WGPUChainedStruct*)&fromCanvas;
		sSurface = wgpuInstanceCreateSurface(sInstance, &surfaceDesc);
#else
		// Native: SDL2 window, then a surface from its HWND.
		SDL.Init(.Video);
		let window = SDL.CreateWindow("wgpu-Beef triangle", .Centered, .Centered, WIDTH, HEIGHT, .Shown | .Resizable);

		SDL.SDL_SysWMinfo wmInfo = .();
		SDL.VERSION(out wmInfo.version);
		SDL.GetWindowWMInfo(window, ref wmInfo);

		WGPUSurfaceSourceWindowsHWND fromHwnd = .();
		fromHwnd.chain.sType = .WGPUSType_SurfaceSourceWindowsHWND;
		fromHwnd.hinstance = (void*)(int)wmInfo.info.win.hinstance;
		fromHwnd.hwnd = (void*)(int)wmInfo.info.win.window;
		WGPUSurfaceDescriptor surfaceDesc = .();
		surfaceDesc.nextInChain = (WGPUChainedStruct*)&fromHwnd;
		sSurface = wgpuInstanceCreateSurface(sInstance, &surfaceDesc);
#endif

		// Kick off adapter -> device -> configure -> pipeline.
		WGPURequestAdapterOptions adapterOpts = .();
		adapterOpts.compatibleSurface = sSurface;
		adapterOpts.powerPreference = .WGPUPowerPreference_HighPerformance;
		WGPURequestAdapterCallbackInfo adapterCb = .();
		adapterCb.mode = .WGPUCallbackMode_AllowSpontaneous;
		adapterCb.callback = => OnAdapter;
		wgpuInstanceRequestAdapter(sInstance, &adapterOpts, adapterCb);

#if BF_PLATFORM_WASM
		// Async init completes via callbacks; Frame() renders once sReady.
		emscripten_set_main_loop(=> Frame, 0, 1);
#else
		// Native: the callbacks above ran synchronously, so we're ready now.
		if (!sReady)
		{
			Console.WriteLine("WebGPU init failed");
			return;
		}

		bool running = true;
		while (running)
		{
			SDL.Event event;
			while (SDL.PollEvent(out event) != 0)
			{
				if (event.type == .Quit)
				{
					running = false;
				}
				else if ((event.type == .WindowEvent) && (event.window.windowEvent == .SizeChanged))
				{
					sConfig.width = (uint32)event.window.data1;
					sConfig.height = (uint32)event.window.data2;
					if ((sConfig.width > 0) && (sConfig.height > 0))
						wgpuSurfaceConfigure(sSurface, &sConfig);
				}
			}

			if ((sConfig.width == 0) || (sConfig.height == 0))
				continue; // minimized

			Frame();
		}

		wgpuRenderPipelineRelease(sPipeline);
		wgpuSurfaceUnconfigure(sSurface);
		wgpuQueueRelease(sQueue);
		wgpuDeviceRelease(sDevice);
		wgpuAdapterRelease(sAdapter);
		wgpuSurfaceRelease(sSurface);
		wgpuInstanceRelease(sInstance);
		SDL.DestroyWindow(window);
		SDL.Quit();
#endif
	}
}
