namespace ClockWorkEngine.Modules;

using ClockWorkEngine.Module;
using ClockWorkEngine.OpenGl;
using System;
using GLFW;
using ImGui;

using static GLFW.Glfw;
using static ImGui.ImGui;
using static ClockWorkEngine.Utils.StringUtils;


class CWindow : CModule
{
	private GlfwWindow* Window = null;
	private GlfwMonitor* MainMonitor = null;
	private bool bInitialized = false;

	public this()
	{
		bModuleTicks = true;
	}

	public override StringView GetModuleName(){return "CWindow";}

	public override void StartupModule()
	{
		String WindowHeader = scope String();
		ConcatString(WindowHeader, "Clockwork Engine Ver ", CEngine.GetEngineVersion());

		if(!Init())
		{
			//Exit with code 1 Application initialization failure
			CEngine.ForceClose(1);
		}
		SetErrorCallback(new => OnGlfwError);
		Window = CreateWindow(1280, 720, WindowHeader, null, null);
		MakeContextCurrent(Window);
		ImGui.CreateContext();
		ImGuiImplGlfw.InitForOpenGL(Window, true);
		ImGuiImplOpenGL3.Init();
		GL.Init(=> Glfw.GetProcAddress);
	}

	public override void ShutdownModule()
	{
		SetErrorCallback(null);
		ImGuiImplOpenGL3.Shutdown();
		ImGuiImplGlfw.Shutdown();
		ImGui.ImGui.DestroyContext();

		Glfw.DestroyWindow(Window);
		Glfw.Terminate();
		Window = null;
		MainMonitor = null;
	}

	public override void ModuleTick(float DeltaTime)
	{
		Draw();
	}

	private void Draw()
	{
		if(WindowShouldClose(Window))
		{
			CEngine.RequestClose();
		}
		ImGuiImplOpenGL3.NewFrame();
		ImGuiImplGlfw.NewFrame();

		//IMGui
		NewFrame();
		Begin("Hello World");
		Text("Test");
		End();
		Render();

		int DWidth = 0;
		int DHeight = 0;
		GetFramebufferSize(Window, ref DWidth, ref DHeight);
		GL.glClearColor(0.1f, 0.1f, 0.1f, 1.00f);
		GL.glClear(GL.GL_COLOR_BUFFER_BIT);

		ImGuiImplOpenGL3.RenderDrawData(GetDrawData());
		SwapBuffers(Window);
		PollEvents();
	}

	private void OnGlfwError(Error InError, StringView InDescription)
	{
		//Force close with code 3 for glfw error
		CEngine.ForceClose(3);
	}
}