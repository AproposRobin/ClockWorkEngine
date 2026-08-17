using System;
namespace wgpu_Beef;

/**
 * Copyright 2019-2023 WebGPU-Native developers
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

/** @file */

/**
 * \mainpage
 *
 * **Important:** *This documentation is a Work In Progress.*
 *
 * This is the home of WebGPU C API specification. We define here the standard
 * `webgpu.h` header that all implementations should provide.
 *
 * For all details where behavior is not otherwise specified, `webgpu.h` has
 * the same behavior as the WebGPU specification for JavaScript on the Web.
 * The WebIDL-based Web specification is mapped into C as faithfully (and
 * bidirectionally) as practical/possible.
 * The working draft of WebGPU can be found at <https://www.w3.org/TR/webgpu/>.
 *
 * The standard include directive for this header is `#include <webgpu/webgpu.h>`
 * (if it is provided in a system-wide or toolchain-wide include directory).
 */


/**
 * \defgroup Constants Constants
 * \brief Constants.
 *
 * @{
 */

static
{
/**
 * 'True' value of @ref WGPUBool.
 *
 * @remark It's not usually necessary to use this, as `true` (from
 * `stdbool.h` or C++) casts to the same value.
 */
	public const uint32 WGPU_TRUE = 1;
/**
 * 'False' value of @ref WGPUBool.
 *
 * @remark It's not usually necessary to use this, as `false` (from
 * `stdbool.h` or C++) casts to the same value.
 */
	public const uint32 WGPU_FALSE = 0;
/**
 * Indicates no array layer count is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_ARRAY_LAYER_COUNT_UNDEFINED = uint32.MaxValue;
/**
 * Indicates no copy stride is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_COPY_STRIDE_UNDEFINED = uint32.MaxValue;
/**
 * Indicates no depth clear value is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const float WGPU_DEPTH_CLEAR_VALUE_UNDEFINED = float.NaN;
/**
 * Indicates no depth slice is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_DEPTH_SLICE_UNDEFINED = uint32.MaxValue;
/**
 * For `uint32_t` limits, indicates no limit value is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_LIMIT_U32_UNDEFINED = uint32.MaxValue;
/**
 * For `uint64_t` limits, indicates no limit value is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint64 WGPU_LIMIT_U64_UNDEFINED = uint64.MaxValue;
/**
 * Indicates no mip level count is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_MIP_LEVEL_COUNT_UNDEFINED = uint32.MaxValue;
/**
 * Indicates no query set index is specified. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint32 WGPU_QUERY_SET_INDEX_UNDEFINED = uint32.MaxValue;
/**
 * Sentinel value used in @ref WGPUStringView to indicate that the pointer
 * is to a null-terminated string, rather than an explicitly-sized string.
 */
	public const uint WGPU_STRLEN = uint.MaxValue;
/**
 * Indicates a size extending to the end of the buffer. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint WGPU_WHOLE_MAP_SIZE = uint.MaxValue;
/**
 * Indicates a size extending to the end of the buffer. For more info,
 * see @ref SentinelValues and the places that use this sentinel value.
 */
	public const uint64 WGPU_WHOLE_SIZE = uint64.MaxValue;

}
/** @} */

/**
 * \defgroup UtilityTypes Utility Types
 *
 * @{
 */

/**
 * Nullable value defining a pointer+length view into a UTF-8 encoded string.
 *
 * Values passed into the API may use the special length value @ref WGPU_STRLEN
 * to indicate a null-terminated string.
 * Non-null values passed out of the API (for example as callback arguments)
 * always provide an explicit length and **may or may not be null-terminated**.
 *
 * Some inputs to the API accept null values. Those which do not accept null
 * values "default" to the empty string when null values are passed.
 *
 * Values are encoded as follows:
 * - `{NULL, WGPU_STRLEN}`: the null value.
 * - `{non_null_pointer, WGPU_STRLEN}`: a null-terminated string view.
 * - `{any, 0}`: the empty string.
 * - `{NULL, non_zero_length}`: not allowed (null dereference).
 * - `{non_null_pointer, non_zero_length}`: an explictly-sized string view with
 *   size `non_zero_length` (in bytes).
 *
 * For info on how this is used in various places, see \ref Strings.
 */
[CRepr] struct WGPUStringView
{
	public char8* data;
	public uint length;
}

/**
 * Initializer for @ref WGPUStringView.
 */
/*#define WGPU_STRING_VIEW_INIT _wgpu_MAKE_INIT_STRUCT(WGPUStringView, { \
	/*.data=*/NULL _wgpu_COMMA \
	/*.length=*/WGPU_STRLEN _wgpu_COMMA \
})*/

typealias WGPUFlags = uint64;
typealias WGPUBool = uint32;

/** @} */

/**
 * \defgroup Objects Objects
 * \brief Opaque, non-dispatchable handles to WebGPU objects.
 *
 * @{
 */
/*typedef struct WGPUAdapterImpl* WGPUAdapter WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUBindGroupImpl* WGPUBindGroup WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUBindGroupLayoutImpl* WGPUBindGroupLayout WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUBufferImpl* WGPUBuffer WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUCommandBufferImpl* WGPUCommandBuffer WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUCommandEncoderImpl* WGPUCommandEncoder WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUComputePassEncoderImpl* WGPUComputePassEncoder WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUComputePipelineImpl* WGPUComputePipeline WGPU_OBJECT_ATTRIBUTE;*/

typealias WGPUAdapter = void*; // struct WGPUAdapterImpl* WGPUAdapter WGPU_OBJECT_ATTRIBUTE;
typealias WGPUBindGroup = void*; //typedef struct WGPUBindGroupImpl* WGPUBindGroup WGPU_OBJECT_ATTRIBUTE;
typealias WGPUBindGroupLayout = void*; // struct WGPUBindGroupLayoutImpl* WGPUBindGroupLayout WGPU_OBJECT_ATTRIBUTE;
typealias WGPUBuffer = void*; //typedef struct WGPUBufferImpl* WGPUBuffer WGPU_OBJECT_ATTRIBUTE;
typealias WGPUCommandBuffer = void*; //typedef struct WGPUCommandBufferImpl* WGPUCommandBuffer WGPU_OBJECT_ATTRIBUTE;
typealias WGPUCommandEncoder = void*; //typedef struct WGPUCommandEncoderImpl* WGPUCommandEncoder WGPU_OBJECT_ATTRIBUTE;
typealias WGPUComputePassEncoder = void*; //typedef struct WGPUComputePassEncoderImpl* WGPUComputePassEncoder WGPU_OBJECT_ATTRIBUTE;
typealias WGPUComputePipeline = void*; //typedef struct WGPUComputePipelineImpl* WGPUComputePipeline WGPU_OBJECT_ATTRIBUTE;
/**
 * TODO
 *
 * Releasing the last ref to a `WGPUDevice` also calls @ref wgpuDeviceDestroy.
 * For more info, see @ref DeviceRelease.
 */
//typedef struct WGPUDeviceImpl* WGPUDevice WGPU_OBJECT_ATTRIBUTE;
typealias WGPUDevice = void*; // struct WGPUDeviceImpl* WGPUDevice WGPU_OBJECT_ATTRIBUTE;
/**
 * A sampleable 2D texture that may perform 0-copy YUV sampling internally. Creation of @ref WGPUExternalTexture is extremely implementation-dependent and not defined in this header.
 */
/*typedef struct WGPUExternalTextureImpl* WGPUExternalTexture WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUInstanceImpl* WGPUInstance WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUPipelineLayoutImpl* WGPUPipelineLayout WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUQuerySetImpl* WGPUQuerySet WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUQueueImpl* WGPUQueue WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPURenderBundleImpl* WGPURenderBundle WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPURenderBundleEncoderImpl* WGPURenderBundleEncoder WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPURenderPassEncoderImpl* WGPURenderPassEncoder WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPURenderPipelineImpl* WGPURenderPipeline WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUSamplerImpl* WGPUSampler WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUShaderModuleImpl* WGPUShaderModule WGPU_OBJECT_ATTRIBUTE;*/

typealias WGPUExternalTexture = void*;
typealias WGPUInstance = void*;
typealias WGPUPipelineLayout = void*;
typealias WGPUQuerySet = void*;
typealias WGPUQueue = void*;
typealias WGPURenderBundle = void*;
typealias WGPURenderBundleEncoder = void*;
typealias WGPURenderPassEncoder = void*;
typealias WGPURenderPipeline = void*;
typealias WGPUSampler = void*;
typealias WGPUShaderModule = void*;
/**
 * An object used to continuously present image data to the user, see @ref Surfaces for more details.
 */
/*typedef struct WGPUSurfaceImpl* WGPUSurface WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUTextureImpl* WGPUTexture WGPU_OBJECT_ATTRIBUTE;
typedef struct WGPUTextureViewImpl* WGPUTextureView WGPU_OBJECT_ATTRIBUTE;*/
typealias WGPUSurface = void*;
typealias WGPUTexture = void*;
typealias WGPUTextureView = void*;

/** @} */

// Structure forward declarations
/*struct WGPUAdapterInfo;
struct WGPUBlendComponent;
struct WGPUBufferBindingLayout;
struct WGPUBufferDescriptor;
struct WGPUColor;
struct WGPUCommandBufferDescriptor;
struct WGPUCommandEncoderDescriptor;
struct WGPUCompatibilityModeLimits;
struct WGPUCompilationMessage;
struct WGPUConstantEntry;
struct WGPUExtent3D;
struct WGPUExternalTextureBindingEntry;
struct WGPUExternalTextureBindingLayout;
struct WGPUFuture;
struct WGPUInstanceLimits;
struct WGPUMultisampleState;
struct WGPUOrigin3D;
struct WGPUPassTimestampWrites;
struct WGPUPipelineLayoutDescriptor;
struct WGPUPrimitiveState;
struct WGPUQuerySetDescriptor;
struct WGPUQueueDescriptor;
struct WGPURenderBundleDescriptor;
struct WGPURenderBundleEncoderDescriptor;
struct WGPURenderPassDepthStencilAttachment;
struct WGPURenderPassMaxDrawCount;
struct WGPURequestAdapterWebXROptions;
struct WGPUSamplerBindingLayout;
struct WGPUSamplerDescriptor;
struct WGPUShaderSourceSPIRV;
struct WGPUShaderSourceWGSL;
struct WGPUStencilFaceState;
struct WGPUStorageTextureBindingLayout;
struct WGPUSupportedFeatures;
struct WGPUSupportedInstanceFeatures;
struct WGPUSupportedWGSLLanguageFeatures;
struct WGPUSurfaceCapabilities;
struct WGPUSurfaceColorManagement;
struct WGPUSurfaceConfiguration;
struct WGPUSurfaceSourceAndroidNativeWindow;
struct WGPUSurfaceSourceMetalLayer;
struct WGPUSurfaceSourceWaylandSurface;
struct WGPUSurfaceSourceWindowsHWND;
struct WGPUSurfaceSourceXCBWindow;
struct WGPUSurfaceSourceXlibWindow;
struct WGPUSurfaceTexture;
struct WGPUTexelCopyBufferLayout;
struct WGPUTextureBindingLayout;
struct WGPUTextureBindingViewDimension;
struct WGPUTextureComponentSwizzle;
struct WGPUVertexAttribute;
struct WGPUBindGroupEntry;
struct WGPUBindGroupLayoutEntry;
struct WGPUBlendState;
struct WGPUCompilationInfo;
struct WGPUComputePassDescriptor;
struct WGPUComputeState;
struct WGPUDepthStencilState;
struct WGPUFutureWaitInfo;
struct WGPUInstanceDescriptor;
struct WGPULimits;
struct WGPURenderPassColorAttachment;
struct WGPURequestAdapterOptions;
struct WGPUShaderModuleDescriptor;
struct WGPUSurfaceDescriptor;
struct WGPUTexelCopyBufferInfo;
struct WGPUTexelCopyTextureInfo;
struct WGPUTextureComponentSwizzleDescriptor;
struct WGPUTextureDescriptor;
struct WGPUVertexBufferLayout;
struct WGPUBindGroupDescriptor;
struct WGPUBindGroupLayoutDescriptor;
struct WGPUColorTargetState;
struct WGPUComputePipelineDescriptor;
struct WGPUDeviceDescriptor;
struct WGPURenderPassDescriptor;
struct WGPUTextureViewDescriptor;
struct WGPUVertexState;
struct WGPUFragmentState;
struct WGPURenderPipelineDescriptor;*/

// Callback info structure forward declarations
/*struct WGPUBufferMapCallbackInfo;
struct WGPUCompilationInfoCallbackInfo;
struct WGPUCreateComputePipelineAsyncCallbackInfo;
struct WGPUCreateRenderPipelineAsyncCallbackInfo;
struct WGPUDeviceLostCallbackInfo;
struct WGPUPopErrorScopeCallbackInfo;
struct WGPUQueueWorkDoneCallbackInfo;
struct WGPURequestAdapterCallbackInfo;
struct WGPURequestDeviceCallbackInfo;
struct WGPUUncapturedErrorCallbackInfo;*/

/**
 * \defgroup Enumerations Enumerations
 * \brief Enums.
 *
 * @{
 */

enum WGPUAdapterType : int32
{
	WGPUAdapterType_DiscreteGPU = 0x00000001,
	WGPUAdapterType_IntegratedGPU = 0x00000002,
	WGPUAdapterType_CPU = 0x00000003,
	WGPUAdapterType_Unknown = 0x00000004,
	WGPUAdapterType_Force32 = 0x7FFFFFFF
}

enum WGPUAddressMode : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUAddressMode_Undefined = 0x00000000,
	WGPUAddressMode_ClampToEdge = 0x00000001,
	WGPUAddressMode_Repeat = 0x00000002,
	WGPUAddressMode_MirrorRepeat = 0x00000003,
	WGPUAddressMode_Force32 = 0x7FFFFFFF
}

enum WGPUBackendType : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUBackendType_Undefined = 0x00000000,
	WGPUBackendType_Null = 0x00000001,
	WGPUBackendType_WebGPU = 0x00000002,
	WGPUBackendType_D3D11 = 0x00000003,
	WGPUBackendType_D3D12 = 0x00000004,
	WGPUBackendType_Metal = 0x00000005,
	WGPUBackendType_Vulkan = 0x00000006,
	WGPUBackendType_OpenGL = 0x00000007,
	WGPUBackendType_OpenGLES = 0x00000008,
	WGPUBackendType_Force32 = 0x7FFFFFFF
}

enum WGPUBlendFactor : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUBlendFactor_Undefined = 0x00000000,
	WGPUBlendFactor_Zero = 0x00000001,
	WGPUBlendFactor_One = 0x00000002,
	WGPUBlendFactor_Src = 0x00000003,
	WGPUBlendFactor_OneMinusSrc = 0x00000004,
	WGPUBlendFactor_SrcAlpha = 0x00000005,
	WGPUBlendFactor_OneMinusSrcAlpha = 0x00000006,
	WGPUBlendFactor_Dst = 0x00000007,
	WGPUBlendFactor_OneMinusDst = 0x00000008,
	WGPUBlendFactor_DstAlpha = 0x00000009,
	WGPUBlendFactor_OneMinusDstAlpha = 0x0000000A,
	WGPUBlendFactor_SrcAlphaSaturated = 0x0000000B,
	WGPUBlendFactor_Constant = 0x0000000C,
	WGPUBlendFactor_OneMinusConstant = 0x0000000D,
	WGPUBlendFactor_Src1 = 0x0000000E,
	WGPUBlendFactor_OneMinusSrc1 = 0x0000000F,
	WGPUBlendFactor_Src1Alpha = 0x00000010,
	WGPUBlendFactor_OneMinusSrc1Alpha = 0x00000011,
	WGPUBlendFactor_Force32 = 0x7FFFFFFF
}

enum WGPUBlendOperation : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUBlendOperation_Undefined = 0x00000000,
	WGPUBlendOperation_Add = 0x00000001,
	WGPUBlendOperation_Subtract = 0x00000002,
	WGPUBlendOperation_ReverseSubtract = 0x00000003,
	WGPUBlendOperation_Min = 0x00000004,
	WGPUBlendOperation_Max = 0x00000005,
	WGPUBlendOperation_Force32 = 0x7FFFFFFF
}

enum WGPUBufferBindingType : int32
{
	/**
	 * `0`. Indicates that this @ref WGPUBufferBindingLayout member of
	 * its parent @ref WGPUBindGroupLayoutEntry is not used.
	 * (See also @ref SentinelValues.)
	 */
	WGPUBufferBindingType_BindingNotUsed = 0x00000000,
	/**
	 * `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUBufferBindingType_Undefined = 0x00000001,
	WGPUBufferBindingType_Uniform = 0x00000002,
	WGPUBufferBindingType_Storage = 0x00000003,
	WGPUBufferBindingType_ReadOnlyStorage = 0x00000004,
	WGPUBufferBindingType_Force32 = 0x7FFFFFFF
}

enum WGPUBufferMapState : int32
{
	WGPUBufferMapState_Unmapped = 0x00000001,
	WGPUBufferMapState_Pending = 0x00000002,
	WGPUBufferMapState_Mapped = 0x00000003,
	WGPUBufferMapState_Force32 = 0x7FFFFFFF
}

/**
 * The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
 */
enum WGPUCallbackMode : int32
{
	/**
	 * Callbacks created with `WGPUCallbackMode_WaitAnyOnly`:
	 * - fire when the asynchronous operation's future is passed to a call to @ref wgpuInstanceWaitAny
	 *   AND the operation has already completed or it completes inside the call to @ref wgpuInstanceWaitAny.
	 */
	WGPUCallbackMode_WaitAnyOnly = 0x00000001,
	/**
	 * Callbacks created with `WGPUCallbackMode_AllowProcessEvents`:
	 * - fire for the same reasons as callbacks created with `WGPUCallbackMode_WaitAnyOnly`
	 * - fire inside a call to @ref wgpuInstanceProcessEvents if the asynchronous operation is complete.
	 */
	WGPUCallbackMode_AllowProcessEvents = 0x00000002,
	/**
	 * Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
	 * - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
	 * - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
	 *
	 *   Implementations _should_ fire spontaneous callbacks as soon as possible.
	 *
	 * @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
	 */
	WGPUCallbackMode_AllowSpontaneous = 0x00000003,
	WGPUCallbackMode_Force32 = 0x7FFFFFFF
}

enum WGPUCompareFunction : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUCompareFunction_Undefined = 0x00000000,
	WGPUCompareFunction_Never = 0x00000001,
	WGPUCompareFunction_Less = 0x00000002,
	WGPUCompareFunction_Equal = 0x00000003,
	WGPUCompareFunction_LessEqual = 0x00000004,
	WGPUCompareFunction_Greater = 0x00000005,
	WGPUCompareFunction_NotEqual = 0x00000006,
	WGPUCompareFunction_GreaterEqual = 0x00000007,
	WGPUCompareFunction_Always = 0x00000008,
	WGPUCompareFunction_Force32 = 0x7FFFFFFF
}

enum WGPUCompilationInfoRequestStatus : int32
{
	WGPUCompilationInfoRequestStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUCompilationInfoRequestStatus_CallbackCancelled = 0x00000002,
	WGPUCompilationInfoRequestStatus_Force32 = 0x7FFFFFFF
}

enum WGPUCompilationMessageType : int32
{
	WGPUCompilationMessageType_Error = 0x00000001,
	WGPUCompilationMessageType_Warning = 0x00000002,
	WGPUCompilationMessageType_Info = 0x00000003,
	WGPUCompilationMessageType_Force32 = 0x7FFFFFFF
}

enum WGPUComponentSwizzle : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUComponentSwizzle_Undefined = 0x00000000,
	/**
	 * Force its value to 0.
	 */
	WGPUComponentSwizzle_Zero = 0x00000001,
	/**
	 * Force its value to 1.
	 */
	WGPUComponentSwizzle_One = 0x00000002,
	/**
	 * Take its value from the red channel of the texture.
	 */
	WGPUComponentSwizzle_R = 0x00000003,
	/**
	 * Take its value from the green channel of the texture.
	 */
	WGPUComponentSwizzle_G = 0x00000004,
	/**
	 * Take its value from the blue channel of the texture.
	 */
	WGPUComponentSwizzle_B = 0x00000005,
	/**
	 * Take its value from the alpha channel of the texture.
	 */
	WGPUComponentSwizzle_A = 0x00000006,
	WGPUComponentSwizzle_Force32 = 0x7FFFFFFF
}

/**
 * Describes how frames are composited with other contents on the screen when @ref wgpuSurfacePresent is called.
 */
enum WGPUCompositeAlphaMode : int32
{
	/**
	 * `0`. Lets the WebGPU implementation choose the best mode (supported, and with the best performance) between @ref WGPUCompositeAlphaMode_Opaque or @ref WGPUCompositeAlphaMode_Inherit.
	 */
	WGPUCompositeAlphaMode_Auto = 0x00000000,
	/**
	 * The alpha component of the image is ignored and teated as if it is always 1.0.
	 */
	WGPUCompositeAlphaMode_Opaque = 0x00000001,
	/**
	 * The alpha component is respected and non-alpha components are assumed to be already multiplied with the alpha component. For example, (0.5, 0, 0, 0.5) is semi-transparent bright red.
	 */
	WGPUCompositeAlphaMode_Premultiplied = 0x00000002,
	/**
	 * The alpha component is respected and non-alpha components are assumed to NOT be already multiplied with the alpha component. For example, (1.0, 0, 0, 0.5) is semi-transparent bright red.
	 */
	WGPUCompositeAlphaMode_Unpremultiplied = 0x00000003,
	/**
	 * The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
	 */
	WGPUCompositeAlphaMode_Inherit = 0x00000004,
	WGPUCompositeAlphaMode_Force32 = 0x7FFFFFFF
}

enum WGPUCreatePipelineAsyncStatus : int32
{
	WGPUCreatePipelineAsyncStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUCreatePipelineAsyncStatus_CallbackCancelled = 0x00000002,
	WGPUCreatePipelineAsyncStatus_ValidationError = 0x00000003,
	WGPUCreatePipelineAsyncStatus_InternalError = 0x00000004,
	WGPUCreatePipelineAsyncStatus_Force32 = 0x7FFFFFFF
}

enum WGPUCullMode : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUCullMode_Undefined = 0x00000000,
	WGPUCullMode_None = 0x00000001,
	WGPUCullMode_Front = 0x00000002,
	WGPUCullMode_Back = 0x00000003,
	WGPUCullMode_Force32 = 0x7FFFFFFF
}

enum WGPUDeviceLostReason : int32
{
	WGPUDeviceLostReason_Unknown = 0x00000001,
	WGPUDeviceLostReason_Destroyed = 0x00000002,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUDeviceLostReason_CallbackCancelled = 0x00000003,
	WGPUDeviceLostReason_FailedCreation = 0x00000004,
	WGPUDeviceLostReason_Force32 = 0x7FFFFFFF
}

enum WGPUErrorFilter : int32
{
	WGPUErrorFilter_Validation = 0x00000001,
	WGPUErrorFilter_OutOfMemory = 0x00000002,
	WGPUErrorFilter_Internal = 0x00000003,
	WGPUErrorFilter_Force32 = 0x7FFFFFFF
}

enum WGPUErrorType : int32
{
	WGPUErrorType_NoError = 0x00000001,
	WGPUErrorType_Validation = 0x00000002,
	WGPUErrorType_OutOfMemory = 0x00000003,
	WGPUErrorType_Internal = 0x00000004,
	WGPUErrorType_Unknown = 0x00000005,
	WGPUErrorType_Force32 = 0x7FFFFFFF
}

/**
 * See @ref WGPURequestAdapterOptions::featureLevel.
 */
enum WGPUFeatureLevel : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUFeatureLevel_Undefined = 0x00000000,
	/**
	 * "Compatibility" profile which can be supported on OpenGL ES 3.1 and D3D11.
	 */
	WGPUFeatureLevel_Compatibility = 0x00000001,
	/**
	 * "Core" profile which can be supported on Vulkan/Metal/D3D12 (at least).
	 */
	WGPUFeatureLevel_Core = 0x00000002,
	WGPUFeatureLevel_Force32 = 0x7FFFFFFF
}

enum WGPUFeatureName : int32
{
	WGPUFeatureName_CoreFeaturesAndLimits = 0x00000001,
	WGPUFeatureName_DepthClipControl = 0x00000002,
	WGPUFeatureName_Depth32FloatStencil8 = 0x00000003,
	WGPUFeatureName_TextureCompressionBC = 0x00000004,
	WGPUFeatureName_TextureCompressionBCSliced3D = 0x00000005,
	WGPUFeatureName_TextureCompressionETC2 = 0x00000006,
	WGPUFeatureName_TextureCompressionASTC = 0x00000007,
	WGPUFeatureName_TextureCompressionASTCSliced3D = 0x00000008,
	WGPUFeatureName_TimestampQuery = 0x00000009,
	WGPUFeatureName_IndirectFirstInstance = 0x0000000A,
	WGPUFeatureName_ShaderF16 = 0x0000000B,
	WGPUFeatureName_RG11B10UfloatRenderable = 0x0000000C,
	WGPUFeatureName_BGRA8UnormStorage = 0x0000000D,
	WGPUFeatureName_Float32Filterable = 0x0000000E,
	WGPUFeatureName_Float32Blendable = 0x0000000F,
	WGPUFeatureName_ClipDistances = 0x00000010,
	WGPUFeatureName_DualSourceBlending = 0x00000011,
	WGPUFeatureName_Subgroups = 0x00000012,
	WGPUFeatureName_TextureFormatsTier1 = 0x00000013,
	WGPUFeatureName_TextureFormatsTier2 = 0x00000014,
	WGPUFeatureName_PrimitiveIndex = 0x00000015,
	WGPUFeatureName_TextureComponentSwizzle = 0x00000016,
	WGPUFeatureName_Force32 = 0x7FFFFFFF
}

enum WGPUFilterMode : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUFilterMode_Undefined = 0x00000000,
	WGPUFilterMode_Nearest = 0x00000001,
	WGPUFilterMode_Linear = 0x00000002,
	WGPUFilterMode_Force32 = 0x7FFFFFFF
}

enum WGPUFrontFace : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUFrontFace_Undefined = 0x00000000,
	WGPUFrontFace_CCW = 0x00000001,
	WGPUFrontFace_CW = 0x00000002,
	WGPUFrontFace_Force32 = 0x7FFFFFFF
}

enum WGPUIndexFormat : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUIndexFormat_Undefined = 0x00000000,
	WGPUIndexFormat_Uint16 = 0x00000001,
	WGPUIndexFormat_Uint32 = 0x00000002,
	WGPUIndexFormat_Force32 = 0x7FFFFFFF
}

enum WGPUInstanceFeatureName : int32
{
	/**
	 * Enable use of ::wgpuInstanceWaitAny with `timeoutNS > 0`.
	 */
	WGPUInstanceFeatureName_TimedWaitAny = 0x00000001,
	/**
	 * Enable passing SPIR-V shaders to @ref wgpuDeviceCreateShaderModule,
	 * via @ref WGPUShaderSourceSPIRV.
	 */
	WGPUInstanceFeatureName_ShaderSourceSPIRV = 0x00000002,
	/**
	 * Normally, a @ref WGPUAdapter can only create a single device. If this is
	 * available and enabled, then adapters won't immediately expire when they
	 * create a device, so can be reused to make multiple devices. They may
	 * still expire for other reasons.
	 */
	WGPUInstanceFeatureName_MultipleDevicesPerAdapter = 0x00000003,
	WGPUInstanceFeatureName_Force32 = 0x7FFFFFFF
}

enum WGPULoadOp : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPULoadOp_Undefined = 0x00000000,
	WGPULoadOp_Load = 0x00000001,
	WGPULoadOp_Clear = 0x00000002,
	WGPULoadOp_Force32 = 0x7FFFFFFF
}

enum WGPUMapAsyncStatus : int32
{
	WGPUMapAsyncStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUMapAsyncStatus_CallbackCancelled = 0x00000002,
	WGPUMapAsyncStatus_Error = 0x00000003,
	WGPUMapAsyncStatus_Aborted = 0x00000004,
	WGPUMapAsyncStatus_Force32 = 0x7FFFFFFF
}

enum WGPUMipmapFilterMode : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUMipmapFilterMode_Undefined = 0x00000000,
	WGPUMipmapFilterMode_Nearest = 0x00000001,
	WGPUMipmapFilterMode_Linear = 0x00000002,
	WGPUMipmapFilterMode_Force32 = 0x7FFFFFFF
}

enum WGPUOptionalBool : int32
{
	/**
	 * `0`.
	 */
	WGPUOptionalBool_False = 0x00000000,
	WGPUOptionalBool_True = 0x00000001,
	WGPUOptionalBool_Undefined = 0x00000002,
	WGPUOptionalBool_Force32 = 0x7FFFFFFF
}

enum WGPUPopErrorScopeStatus : int32
{
	/**
	 * The error scope stack was successfully popped and a result was reported.
	 */
	WGPUPopErrorScopeStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUPopErrorScopeStatus_CallbackCancelled = 0x00000002,
	/**
	 * The error scope stack could not be popped, because it was empty.
	 */
	WGPUPopErrorScopeStatus_Error = 0x00000003,
	WGPUPopErrorScopeStatus_Force32 = 0x7FFFFFFF
}

enum WGPUPowerPreference : int32
{
	/**
	 * `0`. No preference. (See also @ref SentinelValues.)
	 */
	WGPUPowerPreference_Undefined = 0x00000000,
	WGPUPowerPreference_LowPower = 0x00000001,
	WGPUPowerPreference_HighPerformance = 0x00000002,
	WGPUPowerPreference_Force32 = 0x7FFFFFFF
}

enum WGPUPredefinedColorSpace : int32
{
	WGPUPredefinedColorSpace_SRGB = 0x00000001,
	WGPUPredefinedColorSpace_DisplayP3 = 0x00000002,
	WGPUPredefinedColorSpace_Force32 = 0x7FFFFFFF
}

/**
 * Describes when and in which order frames are presented on the screen when @ref wgpuSurfacePresent is called.
 */
enum WGPUPresentMode : int32
{
	/**
	 * `0`. Present mode is not specified. Use the default.
	 */
	WGPUPresentMode_Undefined = 0x00000000,
	/**
	 * The presentation of the image to the user waits for the next vertical blanking period to update in a first-in, first-out manner.
	 * Tearing cannot be observed and frame-loop will be limited to the display's refresh rate.
	 * This is the only mode that's always available.
	 */
	WGPUPresentMode_Fifo = 0x00000001,
	/**
	 * The presentation of the image to the user tries to wait for the next vertical blanking period but may decide to not wait if a frame is presented late.
	 * Tearing can sometimes be observed but late-frame don't produce a full-frame stutter in the presentation.
	 * This is still a first-in, first-out mechanism so a frame-loop will be limited to the display's refresh rate.
	 */
	WGPUPresentMode_FifoRelaxed = 0x00000002,
	/**
	 * The presentation of the image to the user is updated immediately without waiting for a vertical blank.
	 * Tearing can be observed but latency is minimized.
	 */
	WGPUPresentMode_Immediate = 0x00000003,
	/**
	 * The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
	 * Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
	 */
	WGPUPresentMode_Mailbox = 0x00000004,
	WGPUPresentMode_Force32 = 0x7FFFFFFF
}

enum WGPUPrimitiveTopology : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUPrimitiveTopology_Undefined = 0x00000000,
	WGPUPrimitiveTopology_PointList = 0x00000001,
	WGPUPrimitiveTopology_LineList = 0x00000002,
	WGPUPrimitiveTopology_LineStrip = 0x00000003,
	WGPUPrimitiveTopology_TriangleList = 0x00000004,
	WGPUPrimitiveTopology_TriangleStrip = 0x00000005,
	WGPUPrimitiveTopology_Force32 = 0x7FFFFFFF
}

enum WGPUQueryType : int32
{
	WGPUQueryType_Occlusion = 0x00000001,
	WGPUQueryType_Timestamp = 0x00000002,
	WGPUQueryType_Force32 = 0x7FFFFFFF
}

enum WGPUQueueWorkDoneStatus : int32
{
	WGPUQueueWorkDoneStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPUQueueWorkDoneStatus_CallbackCancelled = 0x00000002,
	/**
	 * There was some deterministic error. (Note this is currently never used,
	 * but it will be relevant when it's possible to create a queue object.)
	 */
	WGPUQueueWorkDoneStatus_Error = 0x00000003,
	WGPUQueueWorkDoneStatus_Force32 = 0x7FFFFFFF
}

enum WGPURequestAdapterStatus : int32
{
	WGPURequestAdapterStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPURequestAdapterStatus_CallbackCancelled = 0x00000002,
	WGPURequestAdapterStatus_Unavailable = 0x00000003,
	WGPURequestAdapterStatus_Error = 0x00000004,
	WGPURequestAdapterStatus_Force32 = 0x7FFFFFFF
}

enum WGPURequestDeviceStatus : int32
{
	WGPURequestDeviceStatus_Success = 0x00000001,
	/**
	 * See @ref CallbackStatuses.
	 */
	WGPURequestDeviceStatus_CallbackCancelled = 0x00000002,
	WGPURequestDeviceStatus_Error = 0x00000003,
	WGPURequestDeviceStatus_Force32 = 0x7FFFFFFF
}

enum WGPUSamplerBindingType : int32
{
	/**
	 * `0`. Indicates that this @ref WGPUSamplerBindingLayout member of
	 * its parent @ref WGPUBindGroupLayoutEntry is not used.
	 * (See also @ref SentinelValues.)
	 */
	WGPUSamplerBindingType_BindingNotUsed = 0x00000000,
	/**
	 * `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUSamplerBindingType_Undefined = 0x00000001,
	WGPUSamplerBindingType_Filtering = 0x00000002,
	WGPUSamplerBindingType_NonFiltering = 0x00000003,
	WGPUSamplerBindingType_Comparison = 0x00000004,
	WGPUSamplerBindingType_Force32 = 0x7FFFFFFF
}

/**
 * Status code returned (synchronously) from many operations. Generally
 * indicates an invalid input like an unknown enum value or @ref OutStructChainError.
 * Read the function's documentation for specific error conditions.
 */
enum WGPUStatus : int32
{
	WGPUStatus_Success = 0x00000001,
	WGPUStatus_Error = 0x00000002,
	WGPUStatus_Force32 = 0x7FFFFFFF
}

enum WGPUStencilOperation : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUStencilOperation_Undefined = 0x00000000,
	WGPUStencilOperation_Keep = 0x00000001,
	WGPUStencilOperation_Zero = 0x00000002,
	WGPUStencilOperation_Replace = 0x00000003,
	WGPUStencilOperation_Invert = 0x00000004,
	WGPUStencilOperation_IncrementClamp = 0x00000005,
	WGPUStencilOperation_DecrementClamp = 0x00000006,
	WGPUStencilOperation_IncrementWrap = 0x00000007,
	WGPUStencilOperation_DecrementWrap = 0x00000008,
	WGPUStencilOperation_Force32 = 0x7FFFFFFF
}

enum WGPUStorageTextureAccess : int32
{
	/**
	 * `0`. Indicates that this @ref WGPUStorageTextureBindingLayout member of
	 * its parent @ref WGPUBindGroupLayoutEntry is not used.
	 * (See also @ref SentinelValues.)
	 */
	WGPUStorageTextureAccess_BindingNotUsed = 0x00000000,
	/**
	 * `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUStorageTextureAccess_Undefined = 0x00000001,
	WGPUStorageTextureAccess_WriteOnly = 0x00000002,
	WGPUStorageTextureAccess_ReadOnly = 0x00000003,
	WGPUStorageTextureAccess_ReadWrite = 0x00000004,
	WGPUStorageTextureAccess_Force32 = 0x7FFFFFFF
}

enum WGPUStoreOp : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUStoreOp_Undefined = 0x00000000,
	WGPUStoreOp_Store = 0x00000001,
	WGPUStoreOp_Discard = 0x00000002,
	WGPUStoreOp_Force32 = 0x7FFFFFFF
}

enum WGPUSType : int32
{
	WGPUSType_ShaderSourceSPIRV = 0x00000001,
	WGPUSType_ShaderSourceWGSL = 0x00000002,
	WGPUSType_RenderPassMaxDrawCount = 0x00000003,
	WGPUSType_SurfaceSourceMetalLayer = 0x00000004,
	WGPUSType_SurfaceSourceWindowsHWND = 0x00000005,
	WGPUSType_SurfaceSourceXlibWindow = 0x00000006,
	WGPUSType_SurfaceSourceWaylandSurface = 0x00000007,
	WGPUSType_SurfaceSourceAndroidNativeWindow = 0x00000008,
	WGPUSType_SurfaceSourceXCBWindow = 0x00000009,
	WGPUSType_SurfaceColorManagement = 0x0000000A,
	WGPUSType_RequestAdapterWebXROptions = 0x0000000B,
	WGPUSType_TextureComponentSwizzleDescriptor = 0x0000000C,
	WGPUSType_ExternalTextureBindingLayout = 0x0000000D,
	WGPUSType_ExternalTextureBindingEntry = 0x0000000E,
	WGPUSType_CompatibilityModeLimits = 0x0000000F,
	WGPUSType_TextureBindingViewDimension = 0x00000010,
	WGPUSType_Force32 = 0x7FFFFFFF
}

/**
 * The status enum for @ref wgpuSurfaceGetCurrentTexture.
 */
enum WGPUSurfaceGetCurrentTextureStatus : int32
{
	/**
	 * Yay! Everything is good and we can render this frame.
	 */
	WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal = 0x00000001,
	/**
	 * Still OK - the surface can present the frame, but in a suboptimal way. The surface may need reconfiguration.
	 */
	WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal = 0x00000002,
	/**
	 * Some operation timed out while trying to acquire the frame.
	 */
	WGPUSurfaceGetCurrentTextureStatus_Timeout = 0x00000003,
	/**
	 * The surface is too different to be used, compared to when it was originally created.
	 */
	WGPUSurfaceGetCurrentTextureStatus_Outdated = 0x00000004,
	/**
	 * The connection to whatever owns the surface was lost, or generally needs to be fully reinitialized.
	 */
	WGPUSurfaceGetCurrentTextureStatus_Lost = 0x00000005,
	/**
	 * There was some deterministic error (for example, the surface is not configured, or there was an @ref OutStructChainError). Should produce @ref ImplementationDefinedLogging containing details.
	 */
	WGPUSurfaceGetCurrentTextureStatus_Error = 0x00000006,
	WGPUSurfaceGetCurrentTextureStatus_Force32 = 0x7FFFFFFF
}

enum WGPUTextureAspect : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUTextureAspect_Undefined = 0x00000000,
	WGPUTextureAspect_All = 0x00000001,
	WGPUTextureAspect_StencilOnly = 0x00000002,
	WGPUTextureAspect_DepthOnly = 0x00000003,
	WGPUTextureAspect_Force32 = 0x7FFFFFFF
}

enum WGPUTextureDimension : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUTextureDimension_Undefined = 0x00000000,
	WGPUTextureDimension_1D = 0x00000001,
	WGPUTextureDimension_2D = 0x00000002,
	WGPUTextureDimension_3D = 0x00000003,
	WGPUTextureDimension_Force32 = 0x7FFFFFFF
}

enum WGPUTextureFormat : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUTextureFormat_Undefined = 0x00000000,
	WGPUTextureFormat_R8Unorm = 0x00000001,
	WGPUTextureFormat_R8Snorm = 0x00000002,
	WGPUTextureFormat_R8Uint = 0x00000003,
	WGPUTextureFormat_R8Sint = 0x00000004,
	WGPUTextureFormat_R16Unorm = 0x00000005,
	WGPUTextureFormat_R16Snorm = 0x00000006,
	WGPUTextureFormat_R16Uint = 0x00000007,
	WGPUTextureFormat_R16Sint = 0x00000008,
	WGPUTextureFormat_R16Float = 0x00000009,
	WGPUTextureFormat_RG8Unorm = 0x0000000A,
	WGPUTextureFormat_RG8Snorm = 0x0000000B,
	WGPUTextureFormat_RG8Uint = 0x0000000C,
	WGPUTextureFormat_RG8Sint = 0x0000000D,
	WGPUTextureFormat_R32Float = 0x0000000E,
	WGPUTextureFormat_R32Uint = 0x0000000F,
	WGPUTextureFormat_R32Sint = 0x00000010,
	WGPUTextureFormat_RG16Unorm = 0x00000011,
	WGPUTextureFormat_RG16Snorm = 0x00000012,
	WGPUTextureFormat_RG16Uint = 0x00000013,
	WGPUTextureFormat_RG16Sint = 0x00000014,
	WGPUTextureFormat_RG16Float = 0x00000015,
	WGPUTextureFormat_RGBA8Unorm = 0x00000016,
	WGPUTextureFormat_RGBA8UnormSrgb = 0x00000017,
	WGPUTextureFormat_RGBA8Snorm = 0x00000018,
	WGPUTextureFormat_RGBA8Uint = 0x00000019,
	WGPUTextureFormat_RGBA8Sint = 0x0000001A,
	WGPUTextureFormat_BGRA8Unorm = 0x0000001B,
	WGPUTextureFormat_BGRA8UnormSrgb = 0x0000001C,
	WGPUTextureFormat_RGB10A2Uint = 0x0000001D,
	WGPUTextureFormat_RGB10A2Unorm = 0x0000001E,
	WGPUTextureFormat_RG11B10Ufloat = 0x0000001F,
	WGPUTextureFormat_RGB9E5Ufloat = 0x00000020,
	WGPUTextureFormat_RG32Float = 0x00000021,
	WGPUTextureFormat_RG32Uint = 0x00000022,
	WGPUTextureFormat_RG32Sint = 0x00000023,
	WGPUTextureFormat_RGBA16Unorm = 0x00000024,
	WGPUTextureFormat_RGBA16Snorm = 0x00000025,
	WGPUTextureFormat_RGBA16Uint = 0x00000026,
	WGPUTextureFormat_RGBA16Sint = 0x00000027,
	WGPUTextureFormat_RGBA16Float = 0x00000028,
	WGPUTextureFormat_RGBA32Float = 0x00000029,
	WGPUTextureFormat_RGBA32Uint = 0x0000002A,
	WGPUTextureFormat_RGBA32Sint = 0x0000002B,
	WGPUTextureFormat_Stencil8 = 0x0000002C,
	WGPUTextureFormat_Depth16Unorm = 0x0000002D,
	WGPUTextureFormat_Depth24Plus = 0x0000002E,
	WGPUTextureFormat_Depth24PlusStencil8 = 0x0000002F,
	WGPUTextureFormat_Depth32Float = 0x00000030,
	WGPUTextureFormat_Depth32FloatStencil8 = 0x00000031,
	WGPUTextureFormat_BC1RGBAUnorm = 0x00000032,
	WGPUTextureFormat_BC1RGBAUnormSrgb = 0x00000033,
	WGPUTextureFormat_BC2RGBAUnorm = 0x00000034,
	WGPUTextureFormat_BC2RGBAUnormSrgb = 0x00000035,
	WGPUTextureFormat_BC3RGBAUnorm = 0x00000036,
	WGPUTextureFormat_BC3RGBAUnormSrgb = 0x00000037,
	WGPUTextureFormat_BC4RUnorm = 0x00000038,
	WGPUTextureFormat_BC4RSnorm = 0x00000039,
	WGPUTextureFormat_BC5RGUnorm = 0x0000003A,
	WGPUTextureFormat_BC5RGSnorm = 0x0000003B,
	WGPUTextureFormat_BC6HRGBUfloat = 0x0000003C,
	WGPUTextureFormat_BC6HRGBFloat = 0x0000003D,
	WGPUTextureFormat_BC7RGBAUnorm = 0x0000003E,
	WGPUTextureFormat_BC7RGBAUnormSrgb = 0x0000003F,
	WGPUTextureFormat_ETC2RGB8Unorm = 0x00000040,
	WGPUTextureFormat_ETC2RGB8UnormSrgb = 0x00000041,
	WGPUTextureFormat_ETC2RGB8A1Unorm = 0x00000042,
	WGPUTextureFormat_ETC2RGB8A1UnormSrgb = 0x00000043,
	WGPUTextureFormat_ETC2RGBA8Unorm = 0x00000044,
	WGPUTextureFormat_ETC2RGBA8UnormSrgb = 0x00000045,
	WGPUTextureFormat_EACR11Unorm = 0x00000046,
	WGPUTextureFormat_EACR11Snorm = 0x00000047,
	WGPUTextureFormat_EACRG11Unorm = 0x00000048,
	WGPUTextureFormat_EACRG11Snorm = 0x00000049,
	WGPUTextureFormat_ASTC4x4Unorm = 0x0000004A,
	WGPUTextureFormat_ASTC4x4UnormSrgb = 0x0000004B,
	WGPUTextureFormat_ASTC5x4Unorm = 0x0000004C,
	WGPUTextureFormat_ASTC5x4UnormSrgb = 0x0000004D,
	WGPUTextureFormat_ASTC5x5Unorm = 0x0000004E,
	WGPUTextureFormat_ASTC5x5UnormSrgb = 0x0000004F,
	WGPUTextureFormat_ASTC6x5Unorm = 0x00000050,
	WGPUTextureFormat_ASTC6x5UnormSrgb = 0x00000051,
	WGPUTextureFormat_ASTC6x6Unorm = 0x00000052,
	WGPUTextureFormat_ASTC6x6UnormSrgb = 0x00000053,
	WGPUTextureFormat_ASTC8x5Unorm = 0x00000054,
	WGPUTextureFormat_ASTC8x5UnormSrgb = 0x00000055,
	WGPUTextureFormat_ASTC8x6Unorm = 0x00000056,
	WGPUTextureFormat_ASTC8x6UnormSrgb = 0x00000057,
	WGPUTextureFormat_ASTC8x8Unorm = 0x00000058,
	WGPUTextureFormat_ASTC8x8UnormSrgb = 0x00000059,
	WGPUTextureFormat_ASTC10x5Unorm = 0x0000005A,
	WGPUTextureFormat_ASTC10x5UnormSrgb = 0x0000005B,
	WGPUTextureFormat_ASTC10x6Unorm = 0x0000005C,
	WGPUTextureFormat_ASTC10x6UnormSrgb = 0x0000005D,
	WGPUTextureFormat_ASTC10x8Unorm = 0x0000005E,
	WGPUTextureFormat_ASTC10x8UnormSrgb = 0x0000005F,
	WGPUTextureFormat_ASTC10x10Unorm = 0x00000060,
	WGPUTextureFormat_ASTC10x10UnormSrgb = 0x00000061,
	WGPUTextureFormat_ASTC12x10Unorm = 0x00000062,
	WGPUTextureFormat_ASTC12x10UnormSrgb = 0x00000063,
	WGPUTextureFormat_ASTC12x12Unorm = 0x00000064,
	WGPUTextureFormat_ASTC12x12UnormSrgb = 0x00000065,
	WGPUTextureFormat_Force32 = 0x7FFFFFFF
}

enum WGPUTextureSampleType : int32
{
	/**
	 * `0`. Indicates that this @ref WGPUTextureBindingLayout member of
	 * its parent @ref WGPUBindGroupLayoutEntry is not used.
	 * (See also @ref SentinelValues.)
	 */
	WGPUTextureSampleType_BindingNotUsed = 0x00000000,
	/**
	 * `1`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUTextureSampleType_Undefined = 0x00000001,
	WGPUTextureSampleType_Float = 0x00000002,
	WGPUTextureSampleType_UnfilterableFloat = 0x00000003,
	WGPUTextureSampleType_Depth = 0x00000004,
	WGPUTextureSampleType_Sint = 0x00000005,
	WGPUTextureSampleType_Uint = 0x00000006,
	WGPUTextureSampleType_Force32 = 0x7FFFFFFF
}

enum WGPUTextureViewDimension : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUTextureViewDimension_Undefined = 0x00000000,
	WGPUTextureViewDimension_1D = 0x00000001,
	WGPUTextureViewDimension_2D = 0x00000002,
	WGPUTextureViewDimension_2DArray = 0x00000003,
	WGPUTextureViewDimension_Cube = 0x00000004,
	WGPUTextureViewDimension_CubeArray = 0x00000005,
	WGPUTextureViewDimension_3D = 0x00000006,
	WGPUTextureViewDimension_Force32 = 0x7FFFFFFF
}

enum WGPUToneMappingMode : int32
{
	WGPUToneMappingMode_Standard = 0x00000001,
	WGPUToneMappingMode_Extended = 0x00000002,
	WGPUToneMappingMode_Force32 = 0x7FFFFFFF
}

enum WGPUVertexFormat : int32
{
	WGPUVertexFormat_Uint8 = 0x00000001,
	WGPUVertexFormat_Uint8x2 = 0x00000002,
	WGPUVertexFormat_Uint8x4 = 0x00000003,
	WGPUVertexFormat_Sint8 = 0x00000004,
	WGPUVertexFormat_Sint8x2 = 0x00000005,
	WGPUVertexFormat_Sint8x4 = 0x00000006,
	WGPUVertexFormat_Unorm8 = 0x00000007,
	WGPUVertexFormat_Unorm8x2 = 0x00000008,
	WGPUVertexFormat_Unorm8x4 = 0x00000009,
	WGPUVertexFormat_Snorm8 = 0x0000000A,
	WGPUVertexFormat_Snorm8x2 = 0x0000000B,
	WGPUVertexFormat_Snorm8x4 = 0x0000000C,
	WGPUVertexFormat_Uint16 = 0x0000000D,
	WGPUVertexFormat_Uint16x2 = 0x0000000E,
	WGPUVertexFormat_Uint16x4 = 0x0000000F,
	WGPUVertexFormat_Sint16 = 0x00000010,
	WGPUVertexFormat_Sint16x2 = 0x00000011,
	WGPUVertexFormat_Sint16x4 = 0x00000012,
	WGPUVertexFormat_Unorm16 = 0x00000013,
	WGPUVertexFormat_Unorm16x2 = 0x00000014,
	WGPUVertexFormat_Unorm16x4 = 0x00000015,
	WGPUVertexFormat_Snorm16 = 0x00000016,
	WGPUVertexFormat_Snorm16x2 = 0x00000017,
	WGPUVertexFormat_Snorm16x4 = 0x00000018,
	WGPUVertexFormat_Float16 = 0x00000019,
	WGPUVertexFormat_Float16x2 = 0x0000001A,
	WGPUVertexFormat_Float16x4 = 0x0000001B,
	WGPUVertexFormat_Float32 = 0x0000001C,
	WGPUVertexFormat_Float32x2 = 0x0000001D,
	WGPUVertexFormat_Float32x3 = 0x0000001E,
	WGPUVertexFormat_Float32x4 = 0x0000001F,
	WGPUVertexFormat_Uint32 = 0x00000020,
	WGPUVertexFormat_Uint32x2 = 0x00000021,
	WGPUVertexFormat_Uint32x3 = 0x00000022,
	WGPUVertexFormat_Uint32x4 = 0x00000023,
	WGPUVertexFormat_Sint32 = 0x00000024,
	WGPUVertexFormat_Sint32x2 = 0x00000025,
	WGPUVertexFormat_Sint32x3 = 0x00000026,
	WGPUVertexFormat_Sint32x4 = 0x00000027,
	WGPUVertexFormat_Unorm10_10_10_2 = 0x00000028,
	WGPUVertexFormat_Unorm8x4BGRA = 0x00000029,
	WGPUVertexFormat_Force32 = 0x7FFFFFFF
}

enum WGPUVertexStepMode : int32
{
	/**
	 * `0`. Indicates no value is passed for this argument. See @ref SentinelValues.
	 */
	WGPUVertexStepMode_Undefined = 0x00000000,
	WGPUVertexStepMode_Vertex = 0x00000001,
	WGPUVertexStepMode_Instance = 0x00000002,
	WGPUVertexStepMode_Force32 = 0x7FFFFFFF
}

/**
 * Status returned from a call to ::wgpuInstanceWaitAny.
 */
enum WGPUWaitStatus : int32
{
	/**
	 * At least one WGPUFuture completed successfully.
	 */
	WGPUWaitStatus_Success = 0x00000001,
	/**
	 * The wait operation succeeded, but no WGPUFutures completed within the timeout.
	 */
	WGPUWaitStatus_TimedOut = 0x00000002,
	/**
	 * The call was invalid for some reason (see @ref Wait-Any).
	 * Should produce @ref ImplementationDefinedLogging containing details.
	 */
	WGPUWaitStatus_Error = 0x00000003,
	WGPUWaitStatus_Force32 = 0x7FFFFFFF
}

enum WGPUWGSLLanguageFeatureName : int32
{
	WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures = 0x00000001,
	WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct = 0x00000002,
	WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters = 0x00000003,
	WGPUWGSLLanguageFeatureName_PointerCompositeAccess = 0x00000004,
	WGPUWGSLLanguageFeatureName_UniformBufferStandardLayout = 0x00000005,
	WGPUWGSLLanguageFeatureName_SubgroupId = 0x00000006,
	WGPUWGSLLanguageFeatureName_TextureAndSamplerLet = 0x00000007,
	WGPUWGSLLanguageFeatureName_SubgroupUniformity = 0x00000008,
	WGPUWGSLLanguageFeatureName_TextureFormatsTier1 = 0x00000009,
	WGPUWGSLLanguageFeatureName_Force32 = 0x7FFFFFFF
}

/** @} */

/**
 * \defgroup Bitflags Bitflags
 * \brief Type and constant definitions for bitflag types.
 *
 * @{
 */

/**
 * For reserved non-standard bitflag values, see @ref BitflagRegistry.
 */
typealias WGPUBufferUsage = WGPUFlags;
static
{
/**
 * `0`.
 */
	public const WGPUBufferUsage WGPUBufferUsage_None = 0x0000000000000000;
/**
 * The buffer can be *mapped* on the CPU side in *read* mode (using @ref WGPUMapMode_Read).
 */
	public const WGPUBufferUsage WGPUBufferUsage_MapRead = 0x0000000000000001;
/**
 * The buffer can be *mapped* on the CPU side in *write* mode (using @ref WGPUMapMode_Write).
 *
 * @note This usage is **not** required to set `mappedAtCreation` to `true` in @ref WGPUBufferDescriptor.
 */
	public const WGPUBufferUsage WGPUBufferUsage_MapWrite = 0x0000000000000002;
/**
 * The buffer can be used as the *source* of a GPU-side copy operation.
 */
	public const WGPUBufferUsage WGPUBufferUsage_CopySrc = 0x0000000000000004;
/**
 * The buffer can be used as the *destination* of a GPU-side copy operation.
 */
	public const WGPUBufferUsage WGPUBufferUsage_CopyDst = 0x0000000000000008;
/**
 * The buffer can be used as an Index buffer when doing indexed drawing in a render pipeline.
 */
	public const WGPUBufferUsage WGPUBufferUsage_Index = 0x0000000000000010;
/**
 * The buffer can be used as a Vertex buffer when using a render pipeline.
 */
	public const WGPUBufferUsage WGPUBufferUsage_Vertex = 0x0000000000000020;
/**
 * The buffer can be bound to a shader as a uniform buffer.
 */
	public const WGPUBufferUsage WGPUBufferUsage_Uniform = 0x0000000000000040;
/**
 * The buffer can be bound to a shader as a storage buffer.
 */
	public const WGPUBufferUsage WGPUBufferUsage_Storage = 0x0000000000000080;
/**
 * The buffer can store arguments for an indirect draw call.
 */
	public const WGPUBufferUsage WGPUBufferUsage_Indirect = 0x0000000000000100;
/**
 * The buffer can store the result of a timestamp or occlusion query.
 */
	public const WGPUBufferUsage WGPUBufferUsage_QueryResolve = 0x0000000000000200;
}
/**
 * For reserved non-standard bitflag values, see @ref BitflagRegistry.
 */
typealias WGPUColorWriteMask = WGPUFlags;
/**
 * `0`.
 */
static
{
	public const WGPUColorWriteMask WGPUColorWriteMask_None = 0x0000000000000000;
	public const WGPUColorWriteMask WGPUColorWriteMask_Red = 0x0000000000000001;
	public const WGPUColorWriteMask WGPUColorWriteMask_Green = 0x0000000000000002;
	public const WGPUColorWriteMask WGPUColorWriteMask_Blue = 0x0000000000000004;
	public const WGPUColorWriteMask WGPUColorWriteMask_Alpha = 0x0000000000000008;
}
	/**
	 * `Red | Green | Blue | Alpha`.
	 */
static
{
	public const WGPUColorWriteMask WGPUColorWriteMask_All = 0x000000000000000F;
}

	/**
	 * For reserved non-standard bitflag values, see @ref BitflagRegistry.
	 */
typealias WGPUMapMode = WGPUFlags;
	/**
	 * `0`.
	 */
static
{
	public const WGPUMapMode WGPUMapMode_None = 0x0000000000000000;
	public const WGPUMapMode WGPUMapMode_Read = 0x0000000000000001;
	public const WGPUMapMode WGPUMapMode_Write = 0x0000000000000002;
}

	/**
	 * For reserved non-standard bitflag values, see @ref BitflagRegistry.
	 */
typealias WGPUShaderStage = WGPUFlags;
	/**
	 * `0`.
	 */
static
{
	public const WGPUShaderStage WGPUShaderStage_None = 0x0000000000000000;
	public const WGPUShaderStage WGPUShaderStage_Vertex = 0x0000000000000001;
	public const WGPUShaderStage WGPUShaderStage_Fragment = 0x0000000000000002;
	public const WGPUShaderStage WGPUShaderStage_Compute = 0x0000000000000004;
}

	/**
	 * For reserved non-standard bitflag values, see @ref BitflagRegistry.
	 */
typealias WGPUTextureUsage =  WGPUFlags;
	/**
	 * `0`.
	 */
static
{
	public const WGPUTextureUsage WGPUTextureUsage_None = 0x0000000000000000;
	public const WGPUTextureUsage WGPUTextureUsage_CopySrc = 0x0000000000000001;
	public const WGPUTextureUsage WGPUTextureUsage_CopyDst = 0x0000000000000002;
	public const WGPUTextureUsage WGPUTextureUsage_TextureBinding = 0x0000000000000004;
	public const WGPUTextureUsage WGPUTextureUsage_StorageBinding = 0x0000000000000008;
	public const WGPUTextureUsage WGPUTextureUsage_RenderAttachment = 0x0000000000000010;
	public const WGPUTextureUsage WGPUTextureUsage_TransientAttachment = 0x0000000000000020;
}

	/** @} */

typealias WGPUProc = function void();
	//typealias WGPUProc = function void(void);

	/**
	 * \defgroup Callbacks Callbacks
	 * \brief Callbacks through which asynchronous functions return.
	 *
	 * @{
	 */

	/**
	 * See also @ref CallbackError.
	 *
	 * @param message
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUBufferMapCallback = function void(WGPUMapAsyncStatus status, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param compilationInfo
	 * This argument contains multiple @ref ImplementationAllocatedStructChain roots.
	 * Arbitrary chains must be handled gracefully by the application!
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUCompilationInfoCallback = function void(WGPUCompilationInfoRequestStatus status, WGPUCompilationInfo* compilationInfo, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param pipeline
	 * This parameter is @ref PassedWithOwnership.
	 */
typealias WGPUCreateComputePipelineAsyncCallback = function void(WGPUCreatePipelineAsyncStatus status, WGPUComputePipeline pipeline, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param pipeline
	 * This parameter is @ref PassedWithOwnership.
	 */
typealias WGPUCreateRenderPipelineAsyncCallback = function void(WGPUCreatePipelineAsyncStatus status, WGPURenderPipeline pipeline, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param device
	 * Pointer to the device which was lost. This is always a non-null pointer.
	 * The pointed-to @ref WGPUDevice will be null if, and only if, either:
	 * (1) The `reason` is @ref WGPUDeviceLostReason_FailedCreation.
	 * (2) The last ref of the device has been (or is being) released: see @ref DeviceRelease.
	 * This parameter is @ref PassedWithoutOwnership.
	 *
	 * @param reason
	 * An error code explaining why the device was lost.
	 *
	 * @param message
	 * A @ref LocalizableHumanReadableMessageString describing why the device was lost.
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUDeviceLostCallback = function void(WGPUDevice* device, WGPUDeviceLostReason reason, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param status
	 * See @ref WGPUPopErrorScopeStatus.
	 *
	 * @param type
	 * The type of the error caught by the scope, or @ref WGPUErrorType_NoError if there was none.
	 * If the `status` is not @ref WGPUPopErrorScopeStatus_Success, this is @ref WGPUErrorType_NoError.
	 *
	 * @param message
	 * If the `status` is not @ref WGPUPopErrorScopeStatus_Success **or**
	 * the `type` is not @ref WGPUErrorType_NoError, this is a non-empty
	 * @ref LocalizableHumanReadableMessageString;
	 * otherwise, this is an empty string.
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUPopErrorScopeCallback = function void(WGPUPopErrorScopeStatus status, WGPUErrorType type, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param status
	 * See @ref WGPUQueueWorkDoneStatus.
	 *
	 * @param message
	 * If the `status` is not @ref WGPUQueueWorkDoneStatus_Success,
	 * this is a non-empty @ref LocalizableHumanReadableMessageString;
	 * otherwise, this is an empty string.
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUQueueWorkDoneCallback = function void(WGPUQueueWorkDoneStatus status, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param adapter
	 * This parameter is @ref PassedWithOwnership.
	 *
	 * @param message
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPURequestAdapterCallback = function void(WGPURequestAdapterStatus status, WGPUAdapter adapter, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param device
	 * This parameter is @ref PassedWithOwnership.
	 *
	 * @param message
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPURequestDeviceCallback = function void(WGPURequestDeviceStatus status, WGPUDevice device, WGPUStringView message, void* userdata1, void* userdata2);

	/**
	 * See also @ref CallbackError.
	 *
	 * @param device
	 * This parameter is @ref PassedWithoutOwnership.
	 *
	 * @param message
	 * This parameter is @ref PassedWithoutOwnership.
	 */
typealias WGPUUncapturedErrorCallback = function void(WGPUDevice* device, WGPUErrorType type, WGPUStringView message, void* userdata1, void* userdata2);

	/** @} */
	/**
	 * \defgroup ChainedStructures Chained Structures
	 * \brief Structures used to extend descriptors.
	 *
	 * @{
	 */

[CRepr] struct WGPUChainedStruct
{
	public WGPUChainedStruct* next;
	public WGPUSType sType;
}

/** @} */


/**
 * \defgroup Structures Structures
 * \brief Descriptors and other transparent structures.
 *
 * @{
 */

/**
 * \defgroup CallbackInfoStructs Callback Info Structs
 * \brief Callback info structures that are used in asynchronous functions.
 *
 * @{
 */

[CRepr] struct WGPUBufferMapCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUBufferMapCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUBufferMapCallbackInfo.
 */
/*#define WGPU_BUFFER_MAP_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBufferMapCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUCompilationInfoCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUCompilationInfoCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUCompilationInfoCallbackInfo.
 */
/*#define WGPU_COMPILATION_INFO_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCompilationInfoCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUCreateComputePipelineAsyncCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUCreateComputePipelineAsyncCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUCreateComputePipelineAsyncCallbackInfo.
 */
/*#define WGPU_CREATE_COMPUTE_PIPELINE_ASYNC_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCreateComputePipelineAsyncCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUCreateRenderPipelineAsyncCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUCreateRenderPipelineAsyncCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUCreateRenderPipelineAsyncCallbackInfo.
 */
/*#define WGPU_CREATE_RENDER_PIPELINE_ASYNC_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCreateRenderPipelineAsyncCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUDeviceLostCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUDeviceLostCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUDeviceLostCallbackInfo.
 */
/*#define WGPU_DEVICE_LOST_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUDeviceLostCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUPopErrorScopeCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUPopErrorScopeCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUPopErrorScopeCallbackInfo.
 */
/*#define WGPU_POP_ERROR_SCOPE_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUPopErrorScopeCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUQueueWorkDoneCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPUQueueWorkDoneCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUQueueWorkDoneCallbackInfo.
 */
/*#define WGPU_QUEUE_WORK_DONE_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUQueueWorkDoneCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPURequestAdapterCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPURequestAdapterCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPURequestAdapterCallbackInfo.
 */
/*#define WGPU_REQUEST_ADAPTER_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPURequestAdapterCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPURequestDeviceCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Controls when the callback may be called.
	 *
	 * Has no default. The `INIT` macro sets this to (@ref WGPUCallbackMode)0.
	 */
	public WGPUCallbackMode mode;
	public WGPURequestDeviceCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPURequestDeviceCallbackInfo.
 */
/*#define WGPU_REQUEST_DEVICE_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPURequestDeviceCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.mode=*/_wgpu_ENUM_ZERO_INIT(WGPUCallbackMode) _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

[CRepr] struct WGPUUncapturedErrorCallbackInfo
{
	public WGPUChainedStruct* nextInChain;
	public WGPUUncapturedErrorCallback callback;
	public void* userdata1;
	public void* userdata2;
}

/**
 * Initializer for @ref WGPUUncapturedErrorCallbackInfo.
 */
/*#define WGPU_UNCAPTURED_ERROR_CALLBACK_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUUncapturedErrorCallbackInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.callback=*/NULL _wgpu_COMMA \
	/*.userdata1=*/NULL _wgpu_COMMA \
	/*.userdata2=*/NULL _wgpu_COMMA \
})*/

/** @} */

/**
 * Default values can be set using @ref WGPU_ADAPTER_INFO_INIT as initializer.
 */
[CRepr] struct WGPUAdapterInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is an \ref OutputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView vendor;
	/**
	 * This is an \ref OutputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView architecture;
	/**
	 * This is an \ref OutputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView device;
	/**
	 * This is an \ref OutputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView description;
	/**
	 * The `INIT` macro sets this to @ref WGPUBackendType_Undefined.
	 */
	public WGPUBackendType backendType;
	/**
	 * The `INIT` macro sets this to (@ref WGPUAdapterType)0.
	 */
	public WGPUAdapterType adapterType;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 vendorID;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 deviceID;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 subgroupMinSize;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 subgroupMaxSize;
}

/**
 * Initializer for @ref WGPUAdapterInfo.
 */
/*#define WGPU_ADAPTER_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUAdapterInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.vendor=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.architecture=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.device=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.description=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.backendType=*/WGPUBackendType_Undefined _wgpu_COMMA \
	/*.adapterType=*/_wgpu_ENUM_ZERO_INIT(WGPUAdapterType) _wgpu_COMMA \
	/*.vendorID=*/0 _wgpu_COMMA \
	/*.deviceID=*/0 _wgpu_COMMA \
	/*.subgroupMinSize=*/0 _wgpu_COMMA \
	/*.subgroupMaxSize=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BLEND_COMPONENT_INIT as initializer.
 */
[CRepr] struct WGPUBlendComponent
{
	/**
	 * If set to @ref WGPUBlendOperation_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUBlendOperation_Add.
	 *
	 * The `INIT` macro sets this to @ref WGPUBlendOperation_Undefined.
	 */
	public WGPUBlendOperation operation;
	/**
	 * If set to @ref WGPUBlendFactor_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUBlendFactor_One.
	 *
	 * The `INIT` macro sets this to @ref WGPUBlendFactor_Undefined.
	 */
	public WGPUBlendFactor srcFactor;
	/**
	 * If set to @ref WGPUBlendFactor_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUBlendFactor_Zero.
	 *
	 * The `INIT` macro sets this to @ref WGPUBlendFactor_Undefined.
	 */
	public WGPUBlendFactor dstFactor;
}

/**
 * Initializer for @ref WGPUBlendComponent.
 */
/*#define WGPU_BLEND_COMPONENT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBlendComponent, { \
	/*.operation=*/WGPUBlendOperation_Undefined _wgpu_COMMA \
	/*.srcFactor=*/WGPUBlendFactor_Undefined _wgpu_COMMA \
	/*.dstFactor=*/WGPUBlendFactor_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BUFFER_BINDING_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUBufferBindingLayout
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If set to @ref WGPUBufferBindingType_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUBufferBindingType_Uniform.
	 *
	 * The `INIT` macro sets this to @ref WGPUBufferBindingType_Undefined.
	 */
	public WGPUBufferBindingType type;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool hasDynamicOffset;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 minBindingSize;
}

/**
 * Initializer for @ref WGPUBufferBindingLayout.
 */
/*#define WGPU_BUFFER_BINDING_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBufferBindingLayout, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.type=*/WGPUBufferBindingType_Undefined _wgpu_COMMA \
	/*.hasDynamicOffset=*/WGPU_FALSE _wgpu_COMMA \
	/*.minBindingSize=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BUFFER_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUBufferDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to @ref WGPUBufferUsage_None.
	 */
	public WGPUBufferUsage usage;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 size;
	/**
	 * When true, the buffer is mapped in write mode at creation. It should thus be unmapped once its initial data has been written.
	 *
	 * @note Mapping at creation does **not** require the usage @ref WGPUBufferUsage_MapWrite.
	 *
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool mappedAtCreation;
}

/**
 * Initializer for @ref WGPUBufferDescriptor.
 */
/*#define WGPU_BUFFER_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBufferDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.usage=*/WGPUBufferUsage_None _wgpu_COMMA \
	/*.size=*/0 _wgpu_COMMA \
	/*.mappedAtCreation=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * An RGBA color. Represents a `f32`, `i32`, or `u32` color using @ref DoubleAsSupertype.
 *
 * If any channel is non-finite, produces a @ref NonFiniteFloatValueError.
 *
 * Default values can be set using @ref WGPU_COLOR_INIT as initializer.
 */
[CRepr] struct WGPUColor
{
	/**
	 * The `INIT` macro sets this to `0.`.
	 */
	public double r;
	/**
	 * The `INIT` macro sets this to `0.`.
	 */
	public double g;
	/**
	 * The `INIT` macro sets this to `0.`.
	 */
	public double b;
	/**
	 * The `INIT` macro sets this to `0.`.
	 */
	public double a;
}

/**
 * Initializer for @ref WGPUColor.
 */
/*#define WGPU_COLOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUColor, { \
	/*.r=*/0. _wgpu_COMMA \
	/*.g=*/0. _wgpu_COMMA \
	/*.b=*/0. _wgpu_COMMA \
	/*.a=*/0. _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COMMAND_BUFFER_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUCommandBufferDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPUCommandBufferDescriptor.
 */
/*#define WGPU_COMMAND_BUFFER_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCommandBufferDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COMMAND_ENCODER_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUCommandEncoderDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPUCommandEncoderDescriptor.
 */
/*#define WGPU_COMMAND_ENCODER_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCommandEncoderDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Note: While Compatibility Mode is optional to implement, this extension struct
 * is required to be supported (for both queries and requests) and behave as
 * defined in the WebGPU spec.
 *
 * Default values can be set using @ref WGPU_COMPATIBILITY_MODE_LIMITS_INIT as initializer.
 */
[CRepr] struct WGPUCompatibilityModeLimits
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageBuffersInVertexStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageTexturesInVertexStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageBuffersInFragmentStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageTexturesInFragmentStage;
}

/**
 * Initializer for @ref WGPUCompatibilityModeLimits.
 */
/*#define WGPU_COMPATIBILITY_MODE_LIMITS_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCompatibilityModeLimits, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_CompatibilityModeLimits _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.maxStorageBuffersInVertexStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxStorageTexturesInVertexStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxStorageBuffersInFragmentStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxStorageTexturesInFragmentStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
})*/

/**
 * This is an @ref ImplementationAllocatedStructChain root.
 * Arbitrary chains must be handled gracefully by the application!
 *
 * Default values can be set using @ref WGPU_COMPILATION_MESSAGE_INIT as initializer.
 */
[CRepr] struct WGPUCompilationMessage
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * A @ref LocalizableHumanReadableMessageString.
	 *
	 * This is an \ref OutputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView message;
	/**
	 * Severity level of the message.
	 *
	 * The `INIT` macro sets this to (@ref WGPUCompilationMessageType)0.
	 */
	public WGPUCompilationMessageType type;
	/**
	 * Line number where the message is attached, starting at 1.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 lineNum;
	/**
	 * Offset in UTF-8 code units (bytes) from the beginning of the line, starting at 1.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 linePos;
	/**
	 * Offset in UTF-8 code units (bytes) from the beginning of the shader code, starting at 0.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 offset;
	/**
	 * Length in UTF-8 code units (bytes) of the span the message corresponds to.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 length;
}

/**
 * Initializer for @ref WGPUCompilationMessage.
 */
/*#define WGPU_COMPILATION_MESSAGE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCompilationMessage, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.message=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.type=*/_wgpu_ENUM_ZERO_INIT(WGPUCompilationMessageType) _wgpu_COMMA \
	/*.lineNum=*/0 _wgpu_COMMA \
	/*.linePos=*/0 _wgpu_COMMA \
	/*.offset=*/0 _wgpu_COMMA \
	/*.length=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_CONSTANT_ENTRY_INIT as initializer.
 */
[CRepr] struct WGPUConstantEntry
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView key;
	/**
	 * Represents a WGSL numeric or boolean value using @ref DoubleAsSupertype.
	 *
	 * If non-finite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to `0.`.
	 */
	public double value;
}

/**
 * Initializer for @ref WGPUConstantEntry.
 */
/*#define WGPU_CONSTANT_ENTRY_INIT _wgpu_MAKE_INIT_STRUCT(WGPUConstantEntry, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.key=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.value=*/0. _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_EXTENT_3D_INIT as initializer.
 */
[CRepr] struct WGPUExtent3D
{
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 width;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 height;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 depthOrArrayLayers;
}

/**
 * Initializer for @ref WGPUExtent3D.
 */
/*#define WGPU_EXTENT_3D_INIT _wgpu_MAKE_INIT_STRUCT(WGPUExtent3D, { \
	/*.width=*/0 _wgpu_COMMA \
	/*.height=*/1 _wgpu_COMMA \
	/*.depthOrArrayLayers=*/1 _wgpu_COMMA \
})*/

/**
 * Chained in an @ref WGPUBindGroupEntry to set it to an @ref WGPUExternalTexture. This must have a corresponding @ref WGPUExternalTextureBindingLayout in the @ref WGPUBindGroupLayout.
 *
 * Default values can be set using @ref WGPU_EXTERNAL_TEXTURE_BINDING_ENTRY_INIT as initializer.
 */
[CRepr] struct WGPUExternalTextureBindingEntry
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUExternalTexture externalTexture;
}

/**
 * Initializer for @ref WGPUExternalTextureBindingEntry.
 */
/*#define WGPU_EXTERNAL_TEXTURE_BINDING_ENTRY_INIT _wgpu_MAKE_INIT_STRUCT(WGPUExternalTextureBindingEntry, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_ExternalTextureBindingEntry _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.externalTexture=*/NULL _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUBindGroupLayoutEntry to specify that the corresponding entries in an @ref WGPUBindGroup will contain an @ref WGPUExternalTexture.
 *
 * Default values can be set using @ref WGPU_EXTERNAL_TEXTURE_BINDING_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUExternalTextureBindingLayout
{
	public WGPUChainedStruct chain;
}

/**
 * Initializer for @ref WGPUExternalTextureBindingLayout.
 */
/*#define WGPU_EXTERNAL_TEXTURE_BINDING_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUExternalTextureBindingLayout, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_ExternalTextureBindingLayout _wgpu_COMMA \
	}) _wgpu_COMMA \
})*/

/**
 * Opaque handle to an asynchronous operation. See @ref Asynchronous-Operations for more information.
 *
 * Default values can be set using @ref WGPU_FUTURE_INIT as initializer.
 */
[CRepr] struct WGPUFuture
{
	/**
	 * Opaque id of the @ref WGPUFuture
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 id;
}

/**
 * Initializer for @ref WGPUFuture.
 */
/*#define WGPU_FUTURE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUFuture, { \
	/*.id=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_INSTANCE_LIMITS_INIT as initializer.
 */
[CRepr] struct WGPUInstanceLimits
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The maximum number @ref WGPUFutureWaitInfo supported in a call to ::wgpuInstanceWaitAny with `timeoutNS > 0`.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint timedWaitAnyMaxCount;
}

/**
 * Initializer for @ref WGPUInstanceLimits.
 */
/*#define WGPU_INSTANCE_LIMITS_INIT _wgpu_MAKE_INIT_STRUCT(WGPUInstanceLimits, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.timedWaitAnyMaxCount=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_MULTISAMPLE_STATE_INIT as initializer.
 */
[CRepr] struct WGPUMultisampleState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 count;
	/**
	 * The `INIT` macro sets this to `0xFFFFFFFF`.
	 */
	public uint32 mask;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool alphaToCoverageEnabled;
}

/**
 * Initializer for @ref WGPUMultisampleState.
 */
/*#define WGPU_MULTISAMPLE_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUMultisampleState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.count=*/1 _wgpu_COMMA \
	/*.mask=*/0xFFFFFFFF _wgpu_COMMA \
	/*.alphaToCoverageEnabled=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_ORIGIN_3D_INIT as initializer.
 */
[CRepr] struct WGPUOrigin3D
{
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 x;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 y;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 z;
}

/**
 * Initializer for @ref WGPUOrigin3D.
 */
/*#define WGPU_ORIGIN_3D_INIT _wgpu_MAKE_INIT_STRUCT(WGPUOrigin3D, { \
	/*.x=*/0 _wgpu_COMMA \
	/*.y=*/0 _wgpu_COMMA \
	/*.z=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_PASS_TIMESTAMP_WRITES_INIT as initializer.
 */
[CRepr] struct WGPUPassTimestampWrites
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Query set to write timestamps to.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUQuerySet querySet;
	/**
	 * The `INIT` macro sets this to @ref WGPU_QUERY_SET_INDEX_UNDEFINED.
	 */
	public uint32 beginningOfPassWriteIndex;
	/**
	 * The `INIT` macro sets this to @ref WGPU_QUERY_SET_INDEX_UNDEFINED.
	 */
	public uint32 endOfPassWriteIndex;
}

/**
 * Initializer for @ref WGPUPassTimestampWrites.
 */
/*#define WGPU_PASS_TIMESTAMP_WRITES_INIT _wgpu_MAKE_INIT_STRUCT(WGPUPassTimestampWrites, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.querySet=*/NULL _wgpu_COMMA \
	/*.beginningOfPassWriteIndex=*/WGPU_QUERY_SET_INDEX_UNDEFINED _wgpu_COMMA \
	/*.endOfPassWriteIndex=*/WGPU_QUERY_SET_INDEX_UNDEFINED _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_PIPELINE_LAYOUT_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUPipelineLayoutDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * Array count for `bindGroupLayouts`. The `INIT` macro sets this to 0.
	 */
	public uint bindGroupLayoutCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBindGroupLayout* bindGroupLayouts;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 immediateSize;
}

/**
 * Initializer for @ref WGPUPipelineLayoutDescriptor.
 */
/*#define WGPU_PIPELINE_LAYOUT_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUPipelineLayoutDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.bindGroupLayoutCount=*/0 _wgpu_COMMA \
	/*.bindGroupLayouts=*/NULL _wgpu_COMMA \
	/*.immediateSize=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_PRIMITIVE_STATE_INIT as initializer.
 */
[CRepr] struct WGPUPrimitiveState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If set to @ref WGPUPrimitiveTopology_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUPrimitiveTopology_TriangleList.
	 *
	 * The `INIT` macro sets this to @ref WGPUPrimitiveTopology_Undefined.
	 */
	public WGPUPrimitiveTopology topology;
	/**
	 * The `INIT` macro sets this to @ref WGPUIndexFormat_Undefined.
	 */
	public WGPUIndexFormat stripIndexFormat;
	/**
	 * If set to @ref WGPUFrontFace_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUFrontFace_CCW.
	 *
	 * The `INIT` macro sets this to @ref WGPUFrontFace_Undefined.
	 */
	public WGPUFrontFace frontFace;
	/**
	 * If set to @ref WGPUCullMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUCullMode_None.
	 *
	 * The `INIT` macro sets this to @ref WGPUCullMode_Undefined.
	 */
	public WGPUCullMode cullMode;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool unclippedDepth;
}

/**
 * Initializer for @ref WGPUPrimitiveState.
 */
/*#define WGPU_PRIMITIVE_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUPrimitiveState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.topology=*/WGPUPrimitiveTopology_Undefined _wgpu_COMMA \
	/*.stripIndexFormat=*/WGPUIndexFormat_Undefined _wgpu_COMMA \
	/*.frontFace=*/WGPUFrontFace_Undefined _wgpu_COMMA \
	/*.cullMode=*/WGPUCullMode_Undefined _wgpu_COMMA \
	/*.unclippedDepth=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_QUERY_SET_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUQuerySetDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to (@ref WGPUQueryType)0.
	 */
	public WGPUQueryType type;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 count;
}

/**
 * Initializer for @ref WGPUQuerySetDescriptor.
 */
/*#define WGPU_QUERY_SET_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUQuerySetDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.type=*/_wgpu_ENUM_ZERO_INIT(WGPUQueryType) _wgpu_COMMA \
	/*.count=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_QUEUE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUQueueDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPUQueueDescriptor.
 */
/*#define WGPU_QUEUE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUQueueDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_BUNDLE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPURenderBundleDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPURenderBundleDescriptor.
 */
/*#define WGPU_RENDER_BUNDLE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderBundleDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_BUNDLE_ENCODER_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPURenderBundleEncoderDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * Array count for `colorFormats`. The `INIT` macro sets this to 0.
	 */
	public uint colorFormatCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureFormat* colorFormats;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat depthStencilFormat;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 sampleCount;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool depthReadOnly;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool stencilReadOnly;
}

/**
 * Initializer for @ref WGPURenderBundleEncoderDescriptor.
 */
/*#define WGPU_RENDER_BUNDLE_ENCODER_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderBundleEncoderDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.colorFormatCount=*/0 _wgpu_COMMA \
	/*.colorFormats=*/NULL _wgpu_COMMA \
	/*.depthStencilFormat=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.sampleCount=*/1 _wgpu_COMMA \
	/*.depthReadOnly=*/WGPU_FALSE _wgpu_COMMA \
	/*.stencilReadOnly=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_PASS_DEPTH_STENCIL_ATTACHMENT_INIT as initializer.
 */
[CRepr] struct WGPURenderPassDepthStencilAttachment
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureView view;
	/**
	 * The `INIT` macro sets this to @ref WGPULoadOp_Undefined.
	 */
	public WGPULoadOp depthLoadOp;
	/**
	 * The `INIT` macro sets this to @ref WGPUStoreOp_Undefined.
	 */
	public WGPUStoreOp depthStoreOp;
	/**
	 * This is a @ref NullableFloatingPointType.
	 *
	 * If `NaN`, indicates an `undefined` value (as defined by the JS spec).
	 * Use @ref WGPU_DEPTH_CLEAR_VALUE_UNDEFINED to indicate this semantically.
	 *
	 * If infinite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to @ref WGPU_DEPTH_CLEAR_VALUE_UNDEFINED.
	 */
	public float depthClearValue;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool depthReadOnly;
	/**
	 * The `INIT` macro sets this to @ref WGPULoadOp_Undefined.
	 */
	public WGPULoadOp stencilLoadOp;
	/**
	 * The `INIT` macro sets this to @ref WGPUStoreOp_Undefined.
	 */
	public WGPUStoreOp stencilStoreOp;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 stencilClearValue;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool stencilReadOnly;
}

/**
 * Initializer for @ref WGPURenderPassDepthStencilAttachment.
 */
/*#define WGPU_RENDER_PASS_DEPTH_STENCIL_ATTACHMENT_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderPassDepthStencilAttachment, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.view=*/NULL _wgpu_COMMA \
	/*.depthLoadOp=*/WGPULoadOp_Undefined _wgpu_COMMA \
	/*.depthStoreOp=*/WGPUStoreOp_Undefined _wgpu_COMMA \
	/*.depthClearValue=*/WGPU_DEPTH_CLEAR_VALUE_UNDEFINED _wgpu_COMMA \
	/*.depthReadOnly=*/WGPU_FALSE _wgpu_COMMA \
	/*.stencilLoadOp=*/WGPULoadOp_Undefined _wgpu_COMMA \
	/*.stencilStoreOp=*/WGPUStoreOp_Undefined _wgpu_COMMA \
	/*.stencilClearValue=*/0 _wgpu_COMMA \
	/*.stencilReadOnly=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_PASS_MAX_DRAW_COUNT_INIT as initializer.
 */
[CRepr] struct WGPURenderPassMaxDrawCount
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to `50000000`.
	 */
	public uint64 maxDrawCount;
}

/**
 * Initializer for @ref WGPURenderPassMaxDrawCount.
 */
/*#define WGPU_RENDER_PASS_MAX_DRAW_COUNT_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderPassMaxDrawCount, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_RenderPassMaxDrawCount _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.maxDrawCount=*/50000000 _wgpu_COMMA \
})*/

/**
 * Extension providing requestAdapter options for implementations with WebXR interop (i.e. Wasm).
 *
 * Default values can be set using @ref WGPU_REQUEST_ADAPTER_WEBXR_OPTIONS_INIT as initializer.
 */
[CRepr] struct WGPURequestAdapterWebXROptions
{
	public WGPUChainedStruct chain;
	/**
	 * Sets the `xrCompatible` option in the JS API.
	 *
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool xrCompatible;
}

/**
 * Initializer for @ref WGPURequestAdapterWebXROptions.
 */
/*#define WGPU_REQUEST_ADAPTER_WEBXR_OPTIONS_INIT _wgpu_MAKE_INIT_STRUCT(WGPURequestAdapterWebXROptions, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_RequestAdapterWebXROptions _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.xrCompatible=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SAMPLER_BINDING_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUSamplerBindingLayout
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If set to @ref WGPUSamplerBindingType_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUSamplerBindingType_Filtering.
	 *
	 * The `INIT` macro sets this to @ref WGPUSamplerBindingType_Undefined.
	 */
	public WGPUSamplerBindingType type;
}

/**
 * Initializer for @ref WGPUSamplerBindingLayout.
 */
/*#define WGPU_SAMPLER_BINDING_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSamplerBindingLayout, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.type=*/WGPUSamplerBindingType_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SAMPLER_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUSamplerDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * If set to @ref WGPUAddressMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUAddressMode_ClampToEdge.
	 *
	 * The `INIT` macro sets this to @ref WGPUAddressMode_Undefined.
	 */
	public WGPUAddressMode addressModeU;
	/**
	 * If set to @ref WGPUAddressMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUAddressMode_ClampToEdge.
	 *
	 * The `INIT` macro sets this to @ref WGPUAddressMode_Undefined.
	 */
	public WGPUAddressMode addressModeV;
	/**
	 * If set to @ref WGPUAddressMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUAddressMode_ClampToEdge.
	 *
	 * The `INIT` macro sets this to @ref WGPUAddressMode_Undefined.
	 */
	public WGPUAddressMode addressModeW;
	/**
	 * If set to @ref WGPUFilterMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUFilterMode_Nearest.
	 *
	 * The `INIT` macro sets this to @ref WGPUFilterMode_Undefined.
	 */
	public WGPUFilterMode magFilter;
	/**
	 * If set to @ref WGPUFilterMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUFilterMode_Nearest.
	 *
	 * The `INIT` macro sets this to @ref WGPUFilterMode_Undefined.
	 */
	public WGPUFilterMode minFilter;
	/**
	 * If set to @ref WGPUFilterMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUMipmapFilterMode_Nearest.
	 *
	 * The `INIT` macro sets this to @ref WGPUMipmapFilterMode_Undefined.
	 */
	public WGPUMipmapFilterMode mipmapFilter;
	/**
	 * TODO
	 *
	 * If non-finite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to `0.f`.
	 */
	public float lodMinClamp;
	/**
	 * TODO
	 *
	 * If non-finite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to `32.f`.
	 */
	public float lodMaxClamp;
	/**
	 * The `INIT` macro sets this to @ref WGPUCompareFunction_Undefined.
	 */
	public WGPUCompareFunction compare;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint16 maxAnisotropy;
}

/**
 * Initializer for @ref WGPUSamplerDescriptor.
 */
/*#define WGPU_SAMPLER_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSamplerDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.addressModeU=*/WGPUAddressMode_Undefined _wgpu_COMMA \
	/*.addressModeV=*/WGPUAddressMode_Undefined _wgpu_COMMA \
	/*.addressModeW=*/WGPUAddressMode_Undefined _wgpu_COMMA \
	/*.magFilter=*/WGPUFilterMode_Undefined _wgpu_COMMA \
	/*.minFilter=*/WGPUFilterMode_Undefined _wgpu_COMMA \
	/*.mipmapFilter=*/WGPUMipmapFilterMode_Undefined _wgpu_COMMA \
	/*.lodMinClamp=*/0.f _wgpu_COMMA \
	/*.lodMaxClamp=*/32.f _wgpu_COMMA \
	/*.compare=*/WGPUCompareFunction_Undefined _wgpu_COMMA \
	/*.maxAnisotropy=*/1 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SHADER_SOURCE_SPIRV_INIT as initializer.
 */
[CRepr] struct WGPUShaderSourceSPIRV
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 codeSize;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public uint32* code;
}

/**
 * Initializer for @ref WGPUShaderSourceSPIRV.
 */
/*#define WGPU_SHADER_SOURCE_SPIRV_INIT _wgpu_MAKE_INIT_STRUCT(WGPUShaderSourceSPIRV, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_ShaderSourceSPIRV _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.codeSize=*/0 _wgpu_COMMA \
	/*.code=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SHADER_SOURCE_WGSL_INIT as initializer.
 */
[CRepr] struct WGPUShaderSourceWGSL
{
	public WGPUChainedStruct chain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView code;
}

/**
 * Initializer for @ref WGPUShaderSourceWGSL.
 */
/*#define WGPU_SHADER_SOURCE_WGSL_INIT _wgpu_MAKE_INIT_STRUCT(WGPUShaderSourceWGSL, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_ShaderSourceWGSL _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.code=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_STENCIL_FACE_STATE_INIT as initializer.
 */
[CRepr] struct WGPUStencilFaceState
{
	/**
	 * If set to @ref WGPUCompareFunction_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUCompareFunction_Always.
	 *
	 * The `INIT` macro sets this to @ref WGPUCompareFunction_Undefined.
	 */
	public WGPUCompareFunction compare;
	/**
	 * If set to @ref WGPUStencilOperation_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUStencilOperation_Keep.
	 *
	 * The `INIT` macro sets this to @ref WGPUStencilOperation_Undefined.
	 */
	public WGPUStencilOperation failOp;
	/**
	 * If set to @ref WGPUStencilOperation_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUStencilOperation_Keep.
	 *
	 * The `INIT` macro sets this to @ref WGPUStencilOperation_Undefined.
	 */
	public WGPUStencilOperation depthFailOp;
	/**
	 * If set to @ref WGPUStencilOperation_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUStencilOperation_Keep.
	 *
	 * The `INIT` macro sets this to @ref WGPUStencilOperation_Undefined.
	 */
	public WGPUStencilOperation passOp;
}

/**
 * Initializer for @ref WGPUStencilFaceState.
 */
/*#define WGPU_STENCIL_FACE_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUStencilFaceState, { \
	/*.compare=*/WGPUCompareFunction_Undefined _wgpu_COMMA \
	/*.failOp=*/WGPUStencilOperation_Undefined _wgpu_COMMA \
	/*.depthFailOp=*/WGPUStencilOperation_Undefined _wgpu_COMMA \
	/*.passOp=*/WGPUStencilOperation_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_STORAGE_TEXTURE_BINDING_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUStorageTextureBindingLayout
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If set to @ref WGPUStorageTextureAccess_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUStorageTextureAccess_WriteOnly.
	 *
	 * The `INIT` macro sets this to @ref WGPUStorageTextureAccess_Undefined.
	 */
	public WGPUStorageTextureAccess access;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * If set to @ref WGPUTextureViewDimension_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureViewDimension_2D.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureViewDimension_Undefined.
	 */
	public WGPUTextureViewDimension viewDimension;
}

/**
 * Initializer for @ref WGPUStorageTextureBindingLayout.
 */
/*#define WGPU_STORAGE_TEXTURE_BINDING_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUStorageTextureBindingLayout, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.access=*/WGPUStorageTextureAccess_Undefined _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.viewDimension=*/WGPUTextureViewDimension_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SUPPORTED_FEATURES_INIT as initializer.
 */
[CRepr] struct WGPUSupportedFeatures
{
	/**
	 * Array count for `features`. The `INIT` macro sets this to 0.
	 */
	public uint featureCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUFeatureName* features;
}

/**
 * Initializer for @ref WGPUSupportedFeatures.
 */
/*#define WGPU_SUPPORTED_FEATURES_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSupportedFeatures, { \
	/*.featureCount=*/0 _wgpu_COMMA \
	/*.features=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SUPPORTED_INSTANCE_FEATURES_INIT as initializer.
 */
[CRepr] struct WGPUSupportedInstanceFeatures
{
	/**
	 * Array count for `features`. The `INIT` macro sets this to 0.
	 */
	public uint featureCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUInstanceFeatureName* features;
}

/**
 * Initializer for @ref WGPUSupportedInstanceFeatures.
 */
/*#define WGPU_SUPPORTED_INSTANCE_FEATURES_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSupportedInstanceFeatures, { \
	/*.featureCount=*/0 _wgpu_COMMA \
	/*.features=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SUPPORTED_WGSL_LANGUAGE_FEATURES_INIT as initializer.
 */
[CRepr] struct WGPUSupportedWGSLLanguageFeatures
{
	/**
	 * Array count for `features`. The `INIT` macro sets this to 0.
	 */
	public uint featureCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUWGSLLanguageFeatureName* features;
}

/**
 * Initializer for @ref WGPUSupportedWGSLLanguageFeatures.
 */
/*#define WGPU_SUPPORTED_WGSL_LANGUAGE_FEATURES_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSupportedWGSLLanguageFeatures, { \
	/*.featureCount=*/0 _wgpu_COMMA \
	/*.features=*/NULL _wgpu_COMMA \
})*/

/**
 * Filled by @ref wgpuSurfaceGetCapabilities with what's supported for @ref wgpuSurfaceConfigure for a pair of @ref WGPUSurface and @ref WGPUAdapter.
 *
 * Default values can be set using @ref WGPU_SURFACE_CAPABILITIES_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceCapabilities
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The bit set of supported @ref WGPUTextureUsage bits.
	 * Guaranteed to contain @ref WGPUTextureUsage_RenderAttachment.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureUsage_None.
	 */
	public WGPUTextureUsage usages;
	/**
	 * Array count for `formats`. The `INIT` macro sets this to 0.
	 */
	public uint formatCount;
	/**
	 * A list of supported @ref WGPUTextureFormat values, in order of preference.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureFormat* formats;
	/**
	 * Array count for `presentModes`. The `INIT` macro sets this to 0.
	 */
	public uint presentModeCount;
	/**
	 * A list of supported @ref WGPUPresentMode values.
	 * Guaranteed to contain @ref WGPUPresentMode_Fifo.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUPresentMode* presentModes;
	/**
	 * Array count for `alphaModes`. The `INIT` macro sets this to 0.
	 */
	public uint alphaModeCount;
	/**
	 * A list of supported @ref WGPUCompositeAlphaMode values.
	 * @ref WGPUCompositeAlphaMode_Auto will be an alias for the first element and will never be present in this array.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUCompositeAlphaMode* alphaModes;
}

/**
 * Initializer for @ref WGPUSurfaceCapabilities.
 */
/*#define WGPU_SURFACE_CAPABILITIES_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceCapabilities, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.usages=*/WGPUTextureUsage_None _wgpu_COMMA \
	/*.formatCount=*/0 _wgpu_COMMA \
	/*.formats=*/NULL _wgpu_COMMA \
	/*.presentModeCount=*/0 _wgpu_COMMA \
	/*.presentModes=*/NULL _wgpu_COMMA \
	/*.alphaModeCount=*/0 _wgpu_COMMA \
	/*.alphaModes=*/NULL _wgpu_COMMA \
})*/

/**
 * Extension of @ref WGPUSurfaceConfiguration for color spaces and HDR.
 *
 * Default values can be set using @ref WGPU_SURFACE_COLOR_MANAGEMENT_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceColorManagement
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to (@ref WGPUPredefinedColorSpace)0.
	 */
	public WGPUPredefinedColorSpace colorSpace;
	/**
	 * The `INIT` macro sets this to (@ref WGPUToneMappingMode)0.
	 */
	public WGPUToneMappingMode toneMappingMode;
}

/**
 * Initializer for @ref WGPUSurfaceColorManagement.
 */
/*#define WGPU_SURFACE_COLOR_MANAGEMENT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceColorManagement, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceColorManagement _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.colorSpace=*/_wgpu_ENUM_ZERO_INIT(WGPUPredefinedColorSpace) _wgpu_COMMA \
	/*.toneMappingMode=*/_wgpu_ENUM_ZERO_INIT(WGPUToneMappingMode) _wgpu_COMMA \
})*/

/**
 * Options to @ref wgpuSurfaceConfigure for defining how a @ref WGPUSurface will be rendered to and presented to the user.
 * See @ref Surface-Configuration for more details.
 *
 * Default values can be set using @ref WGPU_SURFACE_CONFIGURATION_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceConfiguration
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The @ref WGPUDevice to use to render to surface's textures.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUDevice device;
	/**
	 * The @ref WGPUTextureFormat of the surface's textures.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * The @ref WGPUTextureUsage of the surface's textures.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureUsage_RenderAttachment.
	 */
	public WGPUTextureUsage usage;
	/**
	 * The width of the surface's textures.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 width;
	/**
	 * The height of the surface's textures.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 height;
	/**
	 * Array count for `viewFormats`. The `INIT` macro sets this to 0.
	 */
	public uint viewFormatCount;
	/**
	 * The additional @ref WGPUTextureFormat for @ref WGPUTextureView format reinterpretation of the surface's textures.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureFormat* viewFormats;
	/**
	 * How the surface's frames will be composited on the screen.
	 *
	 * If set to @ref WGPUCompositeAlphaMode_Auto,
	 * [defaults] to @ref WGPUCompositeAlphaMode_Inherit in native (allowing the mode
	 * to be configured externally), and to @ref WGPUCompositeAlphaMode_Opaque in Wasm.
	 *
	 * The `INIT` macro sets this to @ref WGPUCompositeAlphaMode_Auto.
	 */
	public WGPUCompositeAlphaMode alphaMode;
	/**
	 * When and in which order the surface's frames will be shown on the screen.
	 *
	 * If set to @ref WGPUPresentMode_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUPresentMode_Fifo.
	 *
	 * The `INIT` macro sets this to @ref WGPUPresentMode_Undefined.
	 */
	public WGPUPresentMode presentMode;
}

/**
 * Initializer for @ref WGPUSurfaceConfiguration.
 */
/*#define WGPU_SURFACE_CONFIGURATION_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceConfiguration, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.device=*/NULL _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.usage=*/WGPUTextureUsage_RenderAttachment _wgpu_COMMA \
	/*.width=*/0 _wgpu_COMMA \
	/*.height=*/0 _wgpu_COMMA \
	/*.viewFormatCount=*/0 _wgpu_COMMA \
	/*.viewFormats=*/NULL _wgpu_COMMA \
	/*.alphaMode=*/WGPUCompositeAlphaMode_Auto _wgpu_COMMA \
	/*.presentMode=*/WGPUPresentMode_Undefined _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an Android [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window).
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_ANDROID_NATIVE_WINDOW_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceAndroidNativeWindow
{
	public WGPUChainedStruct chain;
	/**
	 * The pointer to the [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window) that will be wrapped by the @ref WGPUSurface.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* window;
}

/**
 * Initializer for @ref WGPUSurfaceSourceAndroidNativeWindow.
 */
/*#define WGPU_SURFACE_SOURCE_ANDROID_NATIVE_WINDOW_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceAndroidNativeWindow, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceAndroidNativeWindow _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.window=*/NULL _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc).
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_METAL_LAYER_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceMetalLayer
{
	public WGPUChainedStruct chain;
	/**
	 * The pointer to the [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc) that will be wrapped by the @ref WGPUSurface.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* layer;
}

/**
 * Initializer for @ref WGPUSurfaceSourceMetalLayer.
 */
/*#define WGPU_SURFACE_SOURCE_METAL_LAYER_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceMetalLayer, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceMetalLayer _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.layer=*/NULL _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [Wayland](https://wayland.freedesktop.org/) [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface).
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_WAYLAND_SURFACE_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceWaylandSurface
{
	public WGPUChainedStruct chain;
	/**
	 * A [`wl_display`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_display) for this Wayland instance.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* display;
	/**
	 * A [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface) that will be wrapped by the @ref WGPUSurface
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* surface;
}

/**
 * Initializer for @ref WGPUSurfaceSourceWaylandSurface.
 */
/*#define WGPU_SURFACE_SOURCE_WAYLAND_SURFACE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceWaylandSurface, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceWaylandSurface _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.display=*/NULL _wgpu_COMMA \
	/*.surface=*/NULL _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a Windows [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd).
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_WINDOWS_HWND_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceWindowsHWND
{
	public WGPUChainedStruct chain;
	/**
	 * The [`HINSTANCE`](https://learn.microsoft.com/en-us/windows/win32/learnwin32/winmain--the-application-entry-point) for this application.
	 * Most commonly `GetModuleHandle(nullptr)`.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* hinstance;
	/**
	 * The [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd) that will be wrapped by the @ref WGPUSurface.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* hwnd;
}

/**
 * Initializer for @ref WGPUSurfaceSourceWindowsHWND.
 */
/*#define WGPU_SURFACE_SOURCE_WINDOWS_HWND_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceWindowsHWND, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceWindowsHWND _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.hinstance=*/NULL _wgpu_COMMA \
	/*.hwnd=*/NULL _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [XCB](https://xcb.freedesktop.org/) `xcb_window_t`.
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_XCB_WINDOW_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceXCBWindow
{
	public WGPUChainedStruct chain;
	/**
	 * The `xcb_connection_t` for the connection to the X server.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* connection;
	/**
	 * The `xcb_window_t` for the window that will be wrapped by the @ref WGPUSurface.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 window;
}

/**
 * Initializer for @ref WGPUSurfaceSourceXCBWindow.
 */
/*#define WGPU_SURFACE_SOURCE_XCB_WINDOW_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceXCBWindow, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceXCBWindow _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.connection=*/NULL _wgpu_COMMA \
	/*.window=*/0 _wgpu_COMMA \
})*/

/**
 * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [Xlib](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html) `Window`.
 *
 * Default values can be set using @ref WGPU_SURFACE_SOURCE_XLIB_WINDOW_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceSourceXlibWindow
{
	public WGPUChainedStruct chain;
	/**
	 * A pointer to the [`Display`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Opening_the_Display) connected to the X server.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public void* display;
	/**
	 * The [`Window`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Creating_Windows) that will be wrapped by the @ref WGPUSurface.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 window;
}

/**
 * Initializer for @ref WGPUSurfaceSourceXlibWindow.
 */
/*#define WGPU_SURFACE_SOURCE_XLIB_WINDOW_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceSourceXlibWindow, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_SurfaceSourceXlibWindow _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.display=*/NULL _wgpu_COMMA \
	/*.window=*/0 _wgpu_COMMA \
})*/

/**
 * Queried each frame from a @ref WGPUSurface to get a @ref WGPUTexture to render to along with some metadata.
 * See @ref Surface-Presenting for more details.
 *
 * Default values can be set using @ref WGPU_SURFACE_TEXTURE_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceTexture
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The @ref WGPUTexture representing the frame that will be shown on the surface.
	 * It is @ref ReturnedWithOwnership from @ref wgpuSurfaceGetCurrentTexture.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTexture texture;
	/**
	 * Whether the call to @ref wgpuSurfaceGetCurrentTexture succeeded and a hint as to why it might not have.
	 *
	 * The `INIT` macro sets this to (@ref WGPUSurfaceGetCurrentTextureStatus)0.
	 */
	public WGPUSurfaceGetCurrentTextureStatus status;
}

/**
 * Initializer for @ref WGPUSurfaceTexture.
 */
/*#define WGPU_SURFACE_TEXTURE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceTexture, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.texture=*/NULL _wgpu_COMMA \
	/*.status=*/_wgpu_ENUM_ZERO_INIT(WGPUSurfaceGetCurrentTextureStatus) _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXEL_COPY_BUFFER_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUTexelCopyBufferLayout
{
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 offset;
	/**
	 * The `INIT` macro sets this to @ref WGPU_COPY_STRIDE_UNDEFINED.
	 */
	public uint32 bytesPerRow;
	/**
	 * The `INIT` macro sets this to @ref WGPU_COPY_STRIDE_UNDEFINED.
	 */
	public uint32 rowsPerImage;
}

/**
 * Initializer for @ref WGPUTexelCopyBufferLayout.
 */
/*#define WGPU_TEXEL_COPY_BUFFER_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTexelCopyBufferLayout, { \
	/*.offset=*/0 _wgpu_COMMA \
	/*.bytesPerRow=*/WGPU_COPY_STRIDE_UNDEFINED _wgpu_COMMA \
	/*.rowsPerImage=*/WGPU_COPY_STRIDE_UNDEFINED _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXTURE_BINDING_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUTextureBindingLayout
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If set to @ref WGPUTextureSampleType_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureSampleType_Float.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureSampleType_Undefined.
	 */
	public WGPUTextureSampleType sampleType;
	/**
	 * If set to @ref WGPUTextureViewDimension_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureViewDimension_2D.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureViewDimension_Undefined.
	 */
	public WGPUTextureViewDimension viewDimension;
	/**
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool multisampled;
}

/**
 * Initializer for @ref WGPUTextureBindingLayout.
 */
/*#define WGPU_TEXTURE_BINDING_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureBindingLayout, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.sampleType=*/WGPUTextureSampleType_Undefined _wgpu_COMMA \
	/*.viewDimension=*/WGPUTextureViewDimension_Undefined _wgpu_COMMA \
	/*.multisampled=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Note: While Compatibility Mode is optional to implement, this extension struct
 * is required to be accepted (but per the WebGPU spec, its contents are ignored
 * on devices that have the @ref WGPUFeatureName_CoreFeaturesAndLimits feature).
 *
 * Default values can be set using @ref WGPU_TEXTURE_BINDING_VIEW_DIMENSION_INIT as initializer.
 */
[CRepr] struct WGPUTextureBindingViewDimension
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureViewDimension_Undefined.
	 */
	public WGPUTextureViewDimension textureBindingViewDimension;
}

/**
 * Initializer for @ref WGPUTextureBindingViewDimension.
 */
/*#define WGPU_TEXTURE_BINDING_VIEW_DIMENSION_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureBindingViewDimension, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_TextureBindingViewDimension _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.textureBindingViewDimension=*/WGPUTextureViewDimension_Undefined _wgpu_COMMA \
})*/

/**
 * When accessed by a shader, the red/green/blue/alpha channels are replaced
 * by the value corresponding to the component specified in r, g, b, and a,
 * respectively unlike the JS API which uses a string of length four, with
 * each character mapping to the texture view's red/green/blue/alpha channels.
 *
 * Default values can be set using @ref WGPU_TEXTURE_COMPONENT_SWIZZLE_INIT as initializer.
 */
[CRepr] struct WGPUTextureComponentSwizzle
{
	/**
	 * The value that replaces the red channel in the shader.
	 *
	 * If set to @ref WGPUComponentSwizzle_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUComponentSwizzle_R.
	 *
	 * The `INIT` macro sets this to @ref WGPUComponentSwizzle_Undefined.
	 */
	public WGPUComponentSwizzle r;
	/**
	 * The value that replaces the green channel in the shader.
	 *
	 * If set to @ref WGPUComponentSwizzle_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUComponentSwizzle_G.
	 *
	 * The `INIT` macro sets this to @ref WGPUComponentSwizzle_Undefined.
	 */
	public WGPUComponentSwizzle g;
	/**
	 * The value that replaces the blue channel in the shader.
	 *
	 * If set to @ref WGPUComponentSwizzle_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUComponentSwizzle_B.
	 *
	 * The `INIT` macro sets this to @ref WGPUComponentSwizzle_Undefined.
	 */
	public WGPUComponentSwizzle b;
	/**
	 * The value that replaces the alpha channel in the shader.
	 *
	 * If set to @ref WGPUComponentSwizzle_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUComponentSwizzle_A.
	 *
	 * The `INIT` macro sets this to @ref WGPUComponentSwizzle_Undefined.
	 */
	public WGPUComponentSwizzle a;
}

/**
 * Initializer for @ref WGPUTextureComponentSwizzle.
 */
/*#define WGPU_TEXTURE_COMPONENT_SWIZZLE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureComponentSwizzle, { \
	/*.r=*/WGPUComponentSwizzle_Undefined _wgpu_COMMA \
	/*.g=*/WGPUComponentSwizzle_Undefined _wgpu_COMMA \
	/*.b=*/WGPUComponentSwizzle_Undefined _wgpu_COMMA \
	/*.a=*/WGPUComponentSwizzle_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_VERTEX_ATTRIBUTE_INIT as initializer.
 */
[CRepr] struct WGPUVertexAttribute
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to (@ref WGPUVertexFormat)0.
	 */
	public WGPUVertexFormat format;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 offset;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 shaderLocation;
}

/**
 * Initializer for @ref WGPUVertexAttribute.
 */
/*#define WGPU_VERTEX_ATTRIBUTE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUVertexAttribute, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.format=*/_wgpu_ENUM_ZERO_INIT(WGPUVertexFormat) _wgpu_COMMA \
	/*.offset=*/0 _wgpu_COMMA \
	/*.shaderLocation=*/0 _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BIND_GROUP_ENTRY_INIT as initializer.
 */
[CRepr] struct WGPUBindGroupEntry
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Binding index in the bind group.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 binding;
	/**
	 * Set this if the binding is a buffer object.
	 * Otherwise must be null.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBuffer buffer;
	/**
	 * If the binding is a buffer, this is the byte offset of the binding range.
	 * Otherwise ignored.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 offset;
	/**
	 * If the binding is a buffer, this is the byte size of the binding range
	 * (@ref WGPU_WHOLE_SIZE means the binding ends at the end of the buffer).
	 * Otherwise ignored.
	 *
	 * The `INIT` macro sets this to @ref WGPU_WHOLE_SIZE.
	 */
	public uint64 size;
	/**
	 * Set this if the binding is a sampler object.
	 * Otherwise must be null.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUSampler sampler;
	/**
	 * Set this if the binding is a texture view object.
	 * Otherwise must be null.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureView textureView;
}

/**
 * Initializer for @ref WGPUBindGroupEntry.
 */
/*#define WGPU_BIND_GROUP_ENTRY_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBindGroupEntry, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.binding=*/0 _wgpu_COMMA \
	/*.buffer=*/NULL _wgpu_COMMA \
	/*.offset=*/0 _wgpu_COMMA \
	/*.size=*/WGPU_WHOLE_SIZE _wgpu_COMMA \
	/*.sampler=*/NULL _wgpu_COMMA \
	/*.textureView=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BIND_GROUP_LAYOUT_ENTRY_INIT as initializer.
 */
[CRepr] struct WGPUBindGroupLayoutEntry
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 binding;
	/**
	 * The `INIT` macro sets this to @ref WGPUShaderStage_None.
	 */
	public WGPUShaderStage visibility;
	/**
	 * If non-zero, this entry defines a binding array with this size.
	 *
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 bindingArraySize;
	/**
	 * The `INIT` macro sets this to zero (which sets the entry to `BindingNotUsed`).
	 */
	public WGPUBufferBindingLayout buffer;
	/**
	 * The `INIT` macro sets this to zero (which sets the entry to `BindingNotUsed`).
	 */
	public WGPUSamplerBindingLayout sampler;
	/**
	 * The `INIT` macro sets this to zero (which sets the entry to `BindingNotUsed`).
	 */
	public WGPUTextureBindingLayout texture;
	/**
	 * The `INIT` macro sets this to zero (which sets the entry to `BindingNotUsed`).
	 */
	public WGPUStorageTextureBindingLayout storageTexture;
}

/**
 * Initializer for @ref WGPUBindGroupLayoutEntry.
 */
/*#define WGPU_BIND_GROUP_LAYOUT_ENTRY_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBindGroupLayoutEntry, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.binding=*/0 _wgpu_COMMA \
	/*.visibility=*/WGPUShaderStage_None _wgpu_COMMA \
	/*.bindingArraySize=*/0 _wgpu_COMMA \
	/*.buffer=*/_wgpu_STRUCT_ZERO_INIT _wgpu_COMMA \
	/*.sampler=*/_wgpu_STRUCT_ZERO_INIT _wgpu_COMMA \
	/*.texture=*/_wgpu_STRUCT_ZERO_INIT _wgpu_COMMA \
	/*.storageTexture=*/_wgpu_STRUCT_ZERO_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BLEND_STATE_INIT as initializer.
 */
[CRepr] struct WGPUBlendState
{
	/**
	 * The `INIT` macro sets this to @ref WGPU_BLEND_COMPONENT_INIT.
	 */
	public WGPUBlendComponent color;
	/**
	 * The `INIT` macro sets this to @ref WGPU_BLEND_COMPONENT_INIT.
	 */
	public WGPUBlendComponent alpha;
}

/**
 * Initializer for @ref WGPUBlendState.
 */
/*#define WGPU_BLEND_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBlendState, { \
	/*.color=*/WGPU_BLEND_COMPONENT_INIT _wgpu_COMMA \
	/*.alpha=*/WGPU_BLEND_COMPONENT_INIT _wgpu_COMMA \
})*/

/**
 * This is an @ref ImplementationAllocatedStructChain root.
 * Arbitrary chains must be handled gracefully by the application!
 *
 * Default values can be set using @ref WGPU_COMPILATION_INFO_INIT as initializer.
 */
[CRepr] struct WGPUCompilationInfo
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Array count for `messages`. The `INIT` macro sets this to 0.
	 */
	public uint messageCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUCompilationMessage* messages;
}

/**
 * Initializer for @ref WGPUCompilationInfo.
 */
/*#define WGPU_COMPILATION_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUCompilationInfo, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.messageCount=*/0 _wgpu_COMMA \
	/*.messages=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COMPUTE_PASS_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUComputePassDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUPassTimestampWrites* timestampWrites;
}

/**
 * Initializer for @ref WGPUComputePassDescriptor.
 */
/*#define WGPU_COMPUTE_PASS_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUComputePassDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.timestampWrites=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COMPUTE_STATE_INIT as initializer.
 */
[CRepr] struct WGPUComputeState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUShaderModule module;
	/**
	 * This is a \ref NullableInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView entryPoint;
	/**
	 * Array count for `constants`. The `INIT` macro sets this to 0.
	 */
	public uint constantCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUConstantEntry* constants;
}

/**
 * Initializer for @ref WGPUComputeState.
 */
/*#define WGPU_COMPUTE_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUComputeState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.module=*/NULL _wgpu_COMMA \
	/*.entryPoint=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.constantCount=*/0 _wgpu_COMMA \
	/*.constants=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_DEPTH_STENCIL_STATE_INIT as initializer.
 */
[CRepr] struct WGPUDepthStencilState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * The `INIT` macro sets this to @ref WGPUOptionalBool_Undefined.
	 */
	public WGPUOptionalBool depthWriteEnabled;
	/**
	 * The `INIT` macro sets this to @ref WGPUCompareFunction_Undefined.
	 */
	public WGPUCompareFunction depthCompare;
	/**
	 * The `INIT` macro sets this to @ref WGPU_STENCIL_FACE_STATE_INIT.
	 */
	public WGPUStencilFaceState stencilFront;
	/**
	 * The `INIT` macro sets this to @ref WGPU_STENCIL_FACE_STATE_INIT.
	 */
	public WGPUStencilFaceState stencilBack;
	/**
	 * The `INIT` macro sets this to `0xFFFFFFFF`.
	 */
	public uint32 stencilReadMask;
	/**
	 * The `INIT` macro sets this to `0xFFFFFFFF`.
	 */
	public uint32 stencilWriteMask;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public int32 depthBias;
	/**
	 * TODO
	 *
	 * If non-finite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to `0.f`.
	 */
	public float depthBiasSlopeScale;
	/**
	 * TODO
	 *
	 * If non-finite, produces a @ref NonFiniteFloatValueError.
	 *
	 * The `INIT` macro sets this to `0.f`.
	 */
	public float depthBiasClamp;
}

/**
 * Initializer for @ref WGPUDepthStencilState.
 */
/*#define WGPU_DEPTH_STENCIL_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUDepthStencilState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.depthWriteEnabled=*/WGPUOptionalBool_Undefined _wgpu_COMMA \
	/*.depthCompare=*/WGPUCompareFunction_Undefined _wgpu_COMMA \
	/*.stencilFront=*/WGPU_STENCIL_FACE_STATE_INIT _wgpu_COMMA \
	/*.stencilBack=*/WGPU_STENCIL_FACE_STATE_INIT _wgpu_COMMA \
	/*.stencilReadMask=*/0xFFFFFFFF _wgpu_COMMA \
	/*.stencilWriteMask=*/0xFFFFFFFF _wgpu_COMMA \
	/*.depthBias=*/0 _wgpu_COMMA \
	/*.depthBiasSlopeScale=*/0.f _wgpu_COMMA \
	/*.depthBiasClamp=*/0.f _wgpu_COMMA \
})*/

/**
 * Struct holding a future to wait on, and a `completed` boolean flag.
 *
 * Default values can be set using @ref WGPU_FUTURE_WAIT_INFO_INIT as initializer.
 */
[CRepr] struct WGPUFutureWaitInfo
{
	/**
	 * The future to wait on.
	 *
	 * The `INIT` macro sets this to @ref WGPU_FUTURE_INIT.
	 */
	public WGPUFuture future;
	/**
	 * Whether or not the future completed.
	 *
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool completed;
}

/**
 * Initializer for @ref WGPUFutureWaitInfo.
 */
/*#define WGPU_FUTURE_WAIT_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUFutureWaitInfo, { \
	/*.future=*/WGPU_FUTURE_INIT _wgpu_COMMA \
	/*.completed=*/WGPU_FALSE _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_INSTANCE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUInstanceDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Array count for `requiredFeatures`. The `INIT` macro sets this to 0.
	 */
	public uint requiredFeatureCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUInstanceFeatureName* requiredFeatures;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUInstanceLimits* requiredLimits;
}

/**
 * Initializer for @ref WGPUInstanceDescriptor.
 */
/*#define WGPU_INSTANCE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUInstanceDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.requiredFeatureCount=*/0 _wgpu_COMMA \
	/*.requiredFeatures=*/NULL _wgpu_COMMA \
	/*.requiredLimits=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_LIMITS_INIT as initializer.
 */
[CRepr] struct WGPULimits
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxTextureDimension1D;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxTextureDimension2D;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxTextureDimension3D;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxTextureArrayLayers;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxBindGroups;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxBindGroupsPlusVertexBuffers;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxBindingsPerBindGroup;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxDynamicUniformBuffersPerPipelineLayout;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxDynamicStorageBuffersPerPipelineLayout;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxSampledTexturesPerShaderStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxSamplersPerShaderStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageBuffersPerShaderStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxStorageTexturesPerShaderStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxUniformBuffersPerShaderStage;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U64_UNDEFINED.
	 */
	public uint64 maxUniformBufferBindingSize;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U64_UNDEFINED.
	 */
	public uint64 maxStorageBufferBindingSize;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 minUniformBufferOffsetAlignment;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 minStorageBufferOffsetAlignment;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxVertexBuffers;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U64_UNDEFINED.
	 */
	public uint64 maxBufferSize;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxVertexAttributes;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxVertexBufferArrayStride;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxInterStageShaderVariables;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxColorAttachments;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxColorAttachmentBytesPerSample;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeWorkgroupStorageSize;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeInvocationsPerWorkgroup;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeWorkgroupSizeX;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeWorkgroupSizeY;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeWorkgroupSizeZ;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxComputeWorkgroupsPerDimension;
	/**
	 * The `INIT` macro sets this to @ref WGPU_LIMIT_U32_UNDEFINED.
	 */
	public uint32 maxImmediateSize;
}

/**
 * Initializer for @ref WGPULimits.
 */
/*#define WGPU_LIMITS_INIT _wgpu_MAKE_INIT_STRUCT(WGPULimits, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.maxTextureDimension1D=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxTextureDimension2D=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxTextureDimension3D=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxTextureArrayLayers=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxBindGroups=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxBindGroupsPlusVertexBuffers=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxBindingsPerBindGroup=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxDynamicUniformBuffersPerPipelineLayout=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxDynamicStorageBuffersPerPipelineLayout=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxSampledTexturesPerShaderStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxSamplersPerShaderStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxStorageBuffersPerShaderStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxStorageTexturesPerShaderStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxUniformBuffersPerShaderStage=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxUniformBufferBindingSize=*/WGPU_LIMIT_U64_UNDEFINED _wgpu_COMMA \
	/*.maxStorageBufferBindingSize=*/WGPU_LIMIT_U64_UNDEFINED _wgpu_COMMA \
	/*.minUniformBufferOffsetAlignment=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.minStorageBufferOffsetAlignment=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxVertexBuffers=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxBufferSize=*/WGPU_LIMIT_U64_UNDEFINED _wgpu_COMMA \
	/*.maxVertexAttributes=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxVertexBufferArrayStride=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxInterStageShaderVariables=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxColorAttachments=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxColorAttachmentBytesPerSample=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeWorkgroupStorageSize=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeInvocationsPerWorkgroup=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeWorkgroupSizeX=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeWorkgroupSizeY=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeWorkgroupSizeZ=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxComputeWorkgroupsPerDimension=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
	/*.maxImmediateSize=*/WGPU_LIMIT_U32_UNDEFINED _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_PASS_COLOR_ATTACHMENT_INIT as initializer.
 */
[CRepr] struct WGPURenderPassColorAttachment
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * If `NULL`, indicates a hole in the parent
	 * @ref WGPURenderPassDescriptor::colorAttachments array.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureView view;
	/**
	 * The `INIT` macro sets this to @ref WGPU_DEPTH_SLICE_UNDEFINED.
	 */
	public uint32 depthSlice;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureView resolveTarget;
	/**
	 * The `INIT` macro sets this to @ref WGPULoadOp_Undefined.
	 */
	public WGPULoadOp loadOp;
	/**
	 * The `INIT` macro sets this to @ref WGPUStoreOp_Undefined.
	 */
	public WGPUStoreOp storeOp;
	/**
	 * The `INIT` macro sets this to @ref WGPU_COLOR_INIT.
	 */
	public WGPUColor clearValue;
}

/**
 * Initializer for @ref WGPURenderPassColorAttachment.
 */
/*#define WGPU_RENDER_PASS_COLOR_ATTACHMENT_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderPassColorAttachment, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.view=*/NULL _wgpu_COMMA \
	/*.depthSlice=*/WGPU_DEPTH_SLICE_UNDEFINED _wgpu_COMMA \
	/*.resolveTarget=*/NULL _wgpu_COMMA \
	/*.loadOp=*/WGPULoadOp_Undefined _wgpu_COMMA \
	/*.storeOp=*/WGPUStoreOp_Undefined _wgpu_COMMA \
	/*.clearValue=*/WGPU_COLOR_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_REQUEST_ADAPTER_OPTIONS_INIT as initializer.
 */
[CRepr] struct WGPURequestAdapterOptions
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * "Feature level" for the adapter request. If an adapter is returned, it must support the features and limits in the requested feature level.
	 *
	 * If set to @ref WGPUFeatureLevel_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUFeatureLevel_Core.
	 * Additionally, implementations may ignore @ref WGPUFeatureLevel_Compatibility
	 * and provide @ref WGPUFeatureLevel_Core instead.
	 *
	 * The `INIT` macro sets this to @ref WGPUFeatureLevel_Undefined.
	 */
	public WGPUFeatureLevel featureLevel;
	/**
	 * The `INIT` macro sets this to @ref WGPUPowerPreference_Undefined.
	 */
	public WGPUPowerPreference powerPreference;
	/**
	 * If true, requires the adapter to be a "fallback" adapter as defined by the JS spec.
	 * If this is not possible, the request returns null.
	 *
	 * The `INIT` macro sets this to `WGPU_FALSE`.
	 */
	public WGPUBool forceFallbackAdapter;
	/**
	 * If set, requires the adapter to have a particular backend type.
	 * If this is not possible, the request returns null.
	 *
	 * The `INIT` macro sets this to @ref WGPUBackendType_Undefined.
	 */
	public WGPUBackendType backendType;
	/**
	 * If set, requires the adapter to be able to output to a particular surface.
	 * If this is not possible, the request returns null.
	 *
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUSurface compatibleSurface;
}

/**
 * Initializer for @ref WGPURequestAdapterOptions.
 */
/*#define WGPU_REQUEST_ADAPTER_OPTIONS_INIT _wgpu_MAKE_INIT_STRUCT(WGPURequestAdapterOptions, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.featureLevel=*/WGPUFeatureLevel_Undefined _wgpu_COMMA \
	/*.powerPreference=*/WGPUPowerPreference_Undefined _wgpu_COMMA \
	/*.forceFallbackAdapter=*/WGPU_FALSE _wgpu_COMMA \
	/*.backendType=*/WGPUBackendType_Undefined _wgpu_COMMA \
	/*.compatibleSurface=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_SHADER_MODULE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUShaderModuleDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPUShaderModuleDescriptor.
 */
/*#define WGPU_SHADER_MODULE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUShaderModuleDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * The root descriptor for the creation of an @ref WGPUSurface with @ref wgpuInstanceCreateSurface.
 * It isn't sufficient by itself and must have one of the `WGPUSurfaceSource*` in its chain.
 * See @ref Surface-Creation for more details.
 *
 * Default values can be set using @ref WGPU_SURFACE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUSurfaceDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * Label used to refer to the object.
	 *
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
}

/**
 * Initializer for @ref WGPUSurfaceDescriptor.
 */
/*#define WGPU_SURFACE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUSurfaceDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXEL_COPY_BUFFER_INFO_INIT as initializer.
 */
[CRepr] struct WGPUTexelCopyBufferInfo
{
	/**
	 * The `INIT` macro sets this to @ref WGPU_TEXEL_COPY_BUFFER_LAYOUT_INIT.
	 */
	public WGPUTexelCopyBufferLayout layout;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBuffer buffer;
}

/**
 * Initializer for @ref WGPUTexelCopyBufferInfo.
 */
/*#define WGPU_TEXEL_COPY_BUFFER_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTexelCopyBufferInfo, { \
	/*.layout=*/WGPU_TEXEL_COPY_BUFFER_LAYOUT_INIT _wgpu_COMMA \
	/*.buffer=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXEL_COPY_TEXTURE_INFO_INIT as initializer.
 */
[CRepr] struct WGPUTexelCopyTextureInfo
{
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTexture texture;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 mipLevel;
	/**
	 * The `INIT` macro sets this to @ref WGPU_ORIGIN_3D_INIT.
	 */
	public WGPUOrigin3D origin;
	/**
	 * If set to @ref WGPUTextureAspect_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureAspect_All.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureAspect_Undefined.
	 */
	public WGPUTextureAspect aspect;
}

/**
 * Initializer for @ref WGPUTexelCopyTextureInfo.
 */
/*#define WGPU_TEXEL_COPY_TEXTURE_INFO_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTexelCopyTextureInfo, { \
	/*.texture=*/NULL _wgpu_COMMA \
	/*.mipLevel=*/0 _wgpu_COMMA \
	/*.origin=*/WGPU_ORIGIN_3D_INIT _wgpu_COMMA \
	/*.aspect=*/WGPUTextureAspect_Undefined _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXTURE_COMPONENT_SWIZZLE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUTextureComponentSwizzleDescriptor
{
	public WGPUChainedStruct chain;
	/**
	 * The `INIT` macro sets this to @ref WGPU_TEXTURE_COMPONENT_SWIZZLE_INIT.
	 */
	public WGPUTextureComponentSwizzle swizzle;
}

/**
 * Initializer for @ref WGPUTextureComponentSwizzleDescriptor.
 */
/*#define WGPU_TEXTURE_COMPONENT_SWIZZLE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureComponentSwizzleDescriptor, { \
	/*.chain=*/_wgpu_MAKE_INIT_STRUCT(WGPUChainedStruct, { \
		/*.next=*/NULL _wgpu_COMMA \
		/*.sType=*/WGPUSType_TextureComponentSwizzleDescriptor _wgpu_COMMA \
	}) _wgpu_COMMA \
	/*.swizzle=*/WGPU_TEXTURE_COMPONENT_SWIZZLE_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXTURE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUTextureDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureUsage_None.
	 */
	public WGPUTextureUsage usage;
	/**
	 * If set to @ref WGPUTextureDimension_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureDimension_2D.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureDimension_Undefined.
	 */
	public WGPUTextureDimension dimension;
	/**
	 * The `INIT` macro sets this to @ref WGPU_EXTENT_3D_INIT.
	 */
	public WGPUExtent3D size;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 mipLevelCount;
	/**
	 * The `INIT` macro sets this to `1`.
	 */
	public uint32 sampleCount;
	/**
	 * Array count for `viewFormats`. The `INIT` macro sets this to 0.
	 */
	public uint viewFormatCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUTextureFormat* viewFormats;
}

/**
 * Initializer for @ref WGPUTextureDescriptor.
 */
/*#define WGPU_TEXTURE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.usage=*/WGPUTextureUsage_None _wgpu_COMMA \
	/*.dimension=*/WGPUTextureDimension_Undefined _wgpu_COMMA \
	/*.size=*/WGPU_EXTENT_3D_INIT _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.mipLevelCount=*/1 _wgpu_COMMA \
	/*.sampleCount=*/1 _wgpu_COMMA \
	/*.viewFormatCount=*/0 _wgpu_COMMA \
	/*.viewFormats=*/NULL _wgpu_COMMA \
})*/

/**
 * If `attributes` is empty *and* `stepMode` is @ref WGPUVertexStepMode_Undefined,
 * indicates a "hole" in the parent @ref WGPUVertexState `buffers` array,
 * with behavior equivalent to `null` in the JS API.
 *
 * If `attributes` is empty but `stepMode` is *not* @ref WGPUVertexStepMode_Undefined,
 * indicates a vertex buffer with no attributes, with behavior equivalent to
 * `{ attributes: [] }` in the JS API. (TODO: If the JS API changes not to
 * distinguish these cases, then this distinction doesn't matter and we can
 * remove this documentation.)
 *
 * If `stepMode` is @ref WGPUVertexStepMode_Undefined but `attributes` is *not* empty,
 * `stepMode` [defaults](@ref SentinelValues) to @ref WGPUVertexStepMode_Vertex.
 *
 * Default values can be set using @ref WGPU_VERTEX_BUFFER_LAYOUT_INIT as initializer.
 */
[CRepr] struct WGPUVertexBufferLayout
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to @ref WGPUVertexStepMode_Undefined.
	 */
	public WGPUVertexStepMode stepMode;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint64 arrayStride;
	/**
	 * Array count for `attributes`. The `INIT` macro sets this to 0.
	 */
	public uint attributeCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUVertexAttribute* attributes;
}

/**
 * Initializer for @ref WGPUVertexBufferLayout.
 */
/*#define WGPU_VERTEX_BUFFER_LAYOUT_INIT _wgpu_MAKE_INIT_STRUCT(WGPUVertexBufferLayout, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.stepMode=*/WGPUVertexStepMode_Undefined _wgpu_COMMA \
	/*.arrayStride=*/0 _wgpu_COMMA \
	/*.attributeCount=*/0 _wgpu_COMMA \
	/*.attributes=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BIND_GROUP_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUBindGroupDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBindGroupLayout layout;
	/**
	 * Array count for `entries`. The `INIT` macro sets this to 0.
	 */
	public uint entryCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBindGroupEntry* entries;
}

/**
 * Initializer for @ref WGPUBindGroupDescriptor.
 */
/*#define WGPU_BIND_GROUP_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBindGroupDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.layout=*/NULL _wgpu_COMMA \
	/*.entryCount=*/0 _wgpu_COMMA \
	/*.entries=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_BIND_GROUP_LAYOUT_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUBindGroupLayoutDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * Array count for `entries`. The `INIT` macro sets this to 0.
	 */
	public uint entryCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBindGroupLayoutEntry* entries;
}

/**
 * Initializer for @ref WGPUBindGroupLayoutDescriptor.
 */
/*#define WGPU_BIND_GROUP_LAYOUT_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUBindGroupLayoutDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.entryCount=*/0 _wgpu_COMMA \
	/*.entries=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COLOR_TARGET_STATE_INIT as initializer.
 */
[CRepr] struct WGPUColorTargetState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The texture format of the target. If @ref WGPUTextureFormat_Undefined,
	 * indicates a "hole" in the parent @ref WGPUFragmentState `targets` array:
	 * the pipeline does not output a value at this `location`.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUBlendState* blend;
	/**
	 * The `INIT` macro sets this to @ref WGPUColorWriteMask_All.
	 */
	public WGPUColorWriteMask writeMask;
}

/**
 * Initializer for @ref WGPUColorTargetState.
 */
/*#define WGPU_COLOR_TARGET_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUColorTargetState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.blend=*/NULL _wgpu_COMMA \
	/*.writeMask=*/WGPUColorWriteMask_All _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_COMPUTE_PIPELINE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUComputePipelineDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUPipelineLayout layout;
	/**
	 * The `INIT` macro sets this to @ref WGPU_COMPUTE_STATE_INIT.
	 */
	public WGPUComputeState compute;
}

/**
 * Initializer for @ref WGPUComputePipelineDescriptor.
 */
/*#define WGPU_COMPUTE_PIPELINE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUComputePipelineDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.layout=*/NULL _wgpu_COMMA \
	/*.compute=*/WGPU_COMPUTE_STATE_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_DEVICE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUDeviceDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * Array count for `requiredFeatures`. The `INIT` macro sets this to 0.
	 */
	public uint requiredFeatureCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUFeatureName* requiredFeatures;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPULimits* requiredLimits;
	/**
	 * The `INIT` macro sets this to @ref WGPU_QUEUE_DESCRIPTOR_INIT.
	 */
	public WGPUQueueDescriptor defaultQueue;
	/**
	 * The `INIT` macro sets this to @ref WGPU_DEVICE_LOST_CALLBACK_INFO_INIT.
	 */
	public WGPUDeviceLostCallbackInfo deviceLostCallbackInfo;
	/**
	 * Called when there is an uncaptured error on this device, from any thread.
	 * See @ref ErrorScopes.
	 *
	 * **Important:** This callback does not have a configurable @ref WGPUCallbackMode; it may be called at any time (like @ref WGPUCallbackMode_AllowSpontaneous). As such, calls into the `webgpu.h` API from this callback are unsafe. See @ref CallbackReentrancy.
	 *
	 * The `INIT` macro sets this to @ref WGPU_UNCAPTURED_ERROR_CALLBACK_INFO_INIT.
	 */
	public WGPUUncapturedErrorCallbackInfo uncapturedErrorCallbackInfo;
}

/**
 * Initializer for @ref WGPUDeviceDescriptor.
 */
/*#define WGPU_DEVICE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUDeviceDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.requiredFeatureCount=*/0 _wgpu_COMMA \
	/*.requiredFeatures=*/NULL _wgpu_COMMA \
	/*.requiredLimits=*/NULL _wgpu_COMMA \
	/*.defaultQueue=*/WGPU_QUEUE_DESCRIPTOR_INIT _wgpu_COMMA \
	/*.deviceLostCallbackInfo=*/WGPU_DEVICE_LOST_CALLBACK_INFO_INIT _wgpu_COMMA \
	/*.uncapturedErrorCallbackInfo=*/WGPU_UNCAPTURED_ERROR_CALLBACK_INFO_INIT _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_PASS_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPURenderPassDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * Array count for `colorAttachments`. The `INIT` macro sets this to 0.
	 */
	public uint colorAttachmentCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPURenderPassColorAttachment* colorAttachments;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPURenderPassDepthStencilAttachment* depthStencilAttachment;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUQuerySet occlusionQuerySet;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUPassTimestampWrites* timestampWrites;
}

/**
 * Initializer for @ref WGPURenderPassDescriptor.
 */
/*#define WGPU_RENDER_PASS_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderPassDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.colorAttachmentCount=*/0 _wgpu_COMMA \
	/*.colorAttachments=*/NULL _wgpu_COMMA \
	/*.depthStencilAttachment=*/NULL _wgpu_COMMA \
	/*.occlusionQuerySet=*/NULL _wgpu_COMMA \
	/*.timestampWrites=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_TEXTURE_VIEW_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPUTextureViewDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureFormat_Undefined.
	 */
	public WGPUTextureFormat format;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureViewDimension_Undefined.
	 */
	public WGPUTextureViewDimension dimension;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 baseMipLevel;
	/**
	 * The `INIT` macro sets this to @ref WGPU_MIP_LEVEL_COUNT_UNDEFINED.
	 */
	public uint32 mipLevelCount;
	/**
	 * The `INIT` macro sets this to `0`.
	 */
	public uint32 baseArrayLayer;
	/**
	 * The `INIT` macro sets this to @ref WGPU_ARRAY_LAYER_COUNT_UNDEFINED.
	 */
	public uint32 arrayLayerCount;
	/**
	 * If set to @ref WGPUTextureAspect_Undefined,
	 * [defaults](@ref SentinelValues) to @ref WGPUTextureAspect_All.
	 *
	 * The `INIT` macro sets this to @ref WGPUTextureAspect_Undefined.
	 */
	public WGPUTextureAspect aspect;
	/**
	 * The `INIT` macro sets this to @ref WGPUTextureUsage_None.
	 */
	public WGPUTextureUsage usage;
}

/**
 * Initializer for @ref WGPUTextureViewDescriptor.
 */
/*#define WGPU_TEXTURE_VIEW_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPUTextureViewDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.format=*/WGPUTextureFormat_Undefined _wgpu_COMMA \
	/*.dimension=*/WGPUTextureViewDimension_Undefined _wgpu_COMMA \
	/*.baseMipLevel=*/0 _wgpu_COMMA \
	/*.mipLevelCount=*/WGPU_MIP_LEVEL_COUNT_UNDEFINED _wgpu_COMMA \
	/*.baseArrayLayer=*/0 _wgpu_COMMA \
	/*.arrayLayerCount=*/WGPU_ARRAY_LAYER_COUNT_UNDEFINED _wgpu_COMMA \
	/*.aspect=*/WGPUTextureAspect_Undefined _wgpu_COMMA \
	/*.usage=*/WGPUTextureUsage_None _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_VERTEX_STATE_INIT as initializer.
 */
[CRepr] struct WGPUVertexState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUShaderModule module;
	/**
	 * This is a \ref NullableInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView entryPoint;
	/**
	 * Array count for `constants`. The `INIT` macro sets this to 0.
	 */
	public uint constantCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUConstantEntry* constants;
	/**
	 * Array count for `buffers`. The `INIT` macro sets this to 0.
	 */
	public uint bufferCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUVertexBufferLayout* buffers;
}

/**
 * Initializer for @ref WGPUVertexState.
 */
/*#define WGPU_VERTEX_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUVertexState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.module=*/NULL _wgpu_COMMA \
	/*.entryPoint=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.constantCount=*/0 _wgpu_COMMA \
	/*.constants=*/NULL _wgpu_COMMA \
	/*.bufferCount=*/0 _wgpu_COMMA \
	/*.buffers=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_FRAGMENT_STATE_INIT as initializer.
 */
[CRepr] struct WGPUFragmentState
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUShaderModule module;
	/**
	 * This is a \ref NullableInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView entryPoint;
	/**
	 * Array count for `constants`. The `INIT` macro sets this to 0.
	 */
	public uint constantCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUConstantEntry* constants;
	/**
	 * Array count for `targets`. The `INIT` macro sets this to 0.
	 */
	public uint targetCount;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUColorTargetState* targets;
}

/**
 * Initializer for @ref WGPUFragmentState.
 */
/*#define WGPU_FRAGMENT_STATE_INIT _wgpu_MAKE_INIT_STRUCT(WGPUFragmentState, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.module=*/NULL _wgpu_COMMA \
	/*.entryPoint=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.constantCount=*/0 _wgpu_COMMA \
	/*.constants=*/NULL _wgpu_COMMA \
	/*.targetCount=*/0 _wgpu_COMMA \
	/*.targets=*/NULL _wgpu_COMMA \
})*/

/**
 * Default values can be set using @ref WGPU_RENDER_PIPELINE_DESCRIPTOR_INIT as initializer.
 */
[CRepr] struct WGPURenderPipelineDescriptor
{
	public WGPUChainedStruct* nextInChain;
	/**
	 * This is a \ref NonNullInputString.
	 *
	 * The `INIT` macro sets this to @ref WGPU_STRING_VIEW_INIT.
	 */
	public WGPUStringView label;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUPipelineLayout layout;
	/**
	 * The `INIT` macro sets this to @ref WGPU_VERTEX_STATE_INIT.
	 */
	public WGPUVertexState vertex;
	/**
	 * The `INIT` macro sets this to @ref WGPU_PRIMITIVE_STATE_INIT.
	 */
	public WGPUPrimitiveState primitive;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUDepthStencilState* depthStencil;
	/**
	 * The `INIT` macro sets this to @ref WGPU_MULTISAMPLE_STATE_INIT.
	 */
	public WGPUMultisampleState multisample;
	/**
	 * The `INIT` macro sets this to `NULL`.
	 */
	public WGPUFragmentState* fragment;
}

/**
 * Initializer for @ref WGPURenderPipelineDescriptor.
 */
/*#define WGPU_RENDER_PIPELINE_DESCRIPTOR_INIT _wgpu_MAKE_INIT_STRUCT(WGPURenderPipelineDescriptor, { \
	/*.nextInChain=*/NULL _wgpu_COMMA \
	/*.label=*/WGPU_STRING_VIEW_INIT _wgpu_COMMA \
	/*.layout=*/NULL _wgpu_COMMA \
	/*.vertex=*/WGPU_VERTEX_STATE_INIT _wgpu_COMMA \
	/*.primitive=*/WGPU_PRIMITIVE_STATE_INIT _wgpu_COMMA \
	/*.depthStencil=*/NULL _wgpu_COMMA \
	/*.multisample=*/WGPU_MULTISAMPLE_STATE_INIT _wgpu_COMMA \
	/*.fragment=*/NULL _wgpu_COMMA \
})*/

/** @} */

// Global procs
/**
 * Proc pointer type for @ref wgpuCreateInstance:
 * > @copydoc wgpuCreateInstance
 */
typealias WGPUProcCreateInstance = function WGPUInstance(WGPUInstanceDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuGetInstanceFeatures:
 * > @copydoc wgpuGetInstanceFeatures
 */
typealias WGPUProcGetInstanceFeatures = function void(WGPUSupportedInstanceFeatures* features);
/**
 * Proc pointer type for @ref wgpuGetInstanceLimits:
 * > @copydoc wgpuGetInstanceLimits
 */
typealias WGPUProcGetInstanceLimits = function WGPUStatus(WGPUInstanceLimits* limits);
/**
 * Proc pointer type for @ref wgpuHasInstanceFeature:
 * > @copydoc wgpuHasInstanceFeature
 */
typealias WGPUProcHasInstanceFeature = function WGPUBool(WGPUInstanceFeatureName feature);
/**
 * Proc pointer type for @ref wgpuGetProcAddress:
 * > @copydoc wgpuGetProcAddress
 */
typealias WGPUProcGetProcAddress = function WGPUProc(WGPUStringView procName);


// Procs of Adapter
/**
 * Proc pointer type for @ref wgpuAdapterGetFeatures:
 * > @copydoc wgpuAdapterGetFeatures
 */
typealias WGPUProcAdapterGetFeatures = function void(WGPUAdapter adapter, WGPUSupportedFeatures* features);
/**
 * Proc pointer type for @ref wgpuAdapterGetInfo:
 * > @copydoc wgpuAdapterGetInfo
 */
typealias WGPUProcAdapterGetInfo = function WGPUStatus(WGPUAdapter adapter, WGPUAdapterInfo* info);
/**
 * Proc pointer type for @ref wgpuAdapterGetLimits:
 * > @copydoc wgpuAdapterGetLimits
 */
typealias WGPUProcAdapterGetLimits = function WGPUStatus(WGPUAdapter adapter, WGPULimits* limits);
/**
 * Proc pointer type for @ref wgpuAdapterHasFeature:
 * > @copydoc wgpuAdapterHasFeature
 */
typealias WGPUProcAdapterHasFeature = function WGPUBool(WGPUAdapter adapter, WGPUFeatureName feature);
/**
 * Proc pointer type for @ref wgpuAdapterRequestDevice:
 * > @copydoc wgpuAdapterRequestDevice
 */
typealias WGPUProcAdapterRequestDevice = function WGPUFuture(WGPUAdapter adapter, WGPUDeviceDescriptor* descriptor, WGPURequestDeviceCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuAdapterAddRef:
 * > @copydoc wgpuAdapterAddRef
 */
typealias WGPUProcAdapterAddRef = function void(WGPUAdapter adapter);
/**
 * Proc pointer type for @ref wgpuAdapterRelease:
 * > @copydoc wgpuAdapterRelease
 */
typealias WGPUProcAdapterRelease = function void(WGPUAdapter adapter);

// Procs of AdapterInfo
/**
 * Proc pointer type for @ref wgpuAdapterInfoFreeMembers:
 * > @copydoc wgpuAdapterInfoFreeMembers
 */
typealias WGPUProcAdapterInfoFreeMembers = function void(WGPUAdapterInfo adapterInfo);

// Procs of BindGroup
/**
 * Proc pointer type for @ref wgpuBindGroupSetLabel:
 * > @copydoc wgpuBindGroupSetLabel
 */
typealias WGPUProcBindGroupSetLabel = function void(WGPUBindGroup bindGroup, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuBindGroupAddRef:
 * > @copydoc wgpuBindGroupAddRef
 */
typealias WGPUProcBindGroupAddRef = function void(WGPUBindGroup bindGroup);
/**
 * Proc pointer type for @ref wgpuBindGroupRelease:
 * > @copydoc wgpuBindGroupRelease
 */
typealias WGPUProcBindGroupRelease = function void(WGPUBindGroup bindGroup);

// Procs of BindGroupLayout
/**
 * Proc pointer type for @ref wgpuBindGroupLayoutSetLabel:
 * > @copydoc wgpuBindGroupLayoutSetLabel
 */
typealias WGPUProcBindGroupLayoutSetLabel = function void(WGPUBindGroupLayout bindGroupLayout, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuBindGroupLayoutAddRef:
 * > @copydoc wgpuBindGroupLayoutAddRef
 */
typealias WGPUProcBindGroupLayoutAddRef = function void(WGPUBindGroupLayout bindGroupLayout);
/**
 * Proc pointer type for @ref wgpuBindGroupLayoutRelease:
 * > @copydoc wgpuBindGroupLayoutRelease
 */
typealias WGPUProcBindGroupLayoutRelease = function void(WGPUBindGroupLayout bindGroupLayout);

// Procs of Buffer
/**
 * Proc pointer type for @ref wgpuBufferDestroy:
 * > @copydoc wgpuBufferDestroy
 */
typealias WGPUProcBufferDestroy = function void(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferGetConstMappedRange:
 * > @copydoc wgpuBufferGetConstMappedRange
 */
typealias WGPUProcBufferGetConstMappedRange = function void*(WGPUBuffer buffer, uint offset, uint size);
/**
 * Proc pointer type for @ref wgpuBufferGetMappedRange:
 * > @copydoc wgpuBufferGetMappedRange
 */
typealias WGPUProcBufferGetMappedRange = function void*(WGPUBuffer buffer, uint offset, uint size);
/**
 * Proc pointer type for @ref wgpuBufferGetMapState:
 * > @copydoc wgpuBufferGetMapState
 */
typealias WGPUProcBufferGetMapState = function WGPUBufferMapState(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferGetSize:
 * > @copydoc wgpuBufferGetSize
 */
typealias WGPUProcBufferGetSize = function uint64(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferGetUsage:
 * > @copydoc wgpuBufferGetUsage
 */
typealias WGPUProcBufferGetUsage = function WGPUBufferUsage(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferMapAsync:
 * > @copydoc wgpuBufferMapAsync
 */
typealias WGPUProcBufferMapAsync = function WGPUFuture(WGPUBuffer buffer, WGPUMapMode mode, uint offset, uint size, WGPUBufferMapCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuBufferReadMappedRange:
 * > @copydoc wgpuBufferReadMappedRange
 */
typealias WGPUProcBufferReadMappedRange = function WGPUStatus(WGPUBuffer buffer, uint offset, void* data, uint size);
/**
 * Proc pointer type for @ref wgpuBufferSetLabel:
 * > @copydoc wgpuBufferSetLabel
 */
typealias WGPUProcBufferSetLabel = function void(WGPUBuffer buffer, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuBufferUnmap:
 * > @copydoc wgpuBufferUnmap
 */
typealias WGPUProcBufferUnmap = function void(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferWriteMappedRange:
 * > @copydoc wgpuBufferWriteMappedRange
 */
typealias WGPUProcBufferWriteMappedRange = function WGPUStatus(WGPUBuffer buffer, uint offset, void* data, uint size);
/**
 * Proc pointer type for @ref wgpuBufferAddRef:
 * > @copydoc wgpuBufferAddRef
 */
typealias WGPUProcBufferAddRef = function void(WGPUBuffer buffer);
/**
 * Proc pointer type for @ref wgpuBufferRelease:
 * > @copydoc wgpuBufferRelease
 */
typealias WGPUProcBufferRelease = function void(WGPUBuffer buffer);

// Procs of CommandBuffer
/**
 * Proc pointer type for @ref wgpuCommandBufferSetLabel:
 * > @copydoc wgpuCommandBufferSetLabel
 */
typealias WGPUProcCommandBufferSetLabel = function void(WGPUCommandBuffer commandBuffer, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuCommandBufferAddRef:
 * > @copydoc wgpuCommandBufferAddRef
 */
typealias WGPUProcCommandBufferAddRef = function void(WGPUCommandBuffer commandBuffer);
/**
 * Proc pointer type for @ref wgpuCommandBufferRelease:
 * > @copydoc wgpuCommandBufferRelease
 */
typealias WGPUProcCommandBufferRelease = function void(WGPUCommandBuffer commandBuffer);

// Procs of CommandEncoder
/**
 * Proc pointer type for @ref wgpuCommandEncoderBeginComputePass:
 * > @copydoc wgpuCommandEncoderBeginComputePass
 */
typealias WGPUProcCommandEncoderBeginComputePass = function WGPUComputePassEncoder(WGPUCommandEncoder commandEncoder, WGPUComputePassDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuCommandEncoderBeginRenderPass:
 * > @copydoc wgpuCommandEncoderBeginRenderPass
 */
typealias WGPUProcCommandEncoderBeginRenderPass = function WGPURenderPassEncoder(WGPUCommandEncoder commandEncoder, WGPURenderPassDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuCommandEncoderClearBuffer:
 * > @copydoc wgpuCommandEncoderClearBuffer
 */
typealias WGPUProcCommandEncoderClearBuffer = function void(WGPUCommandEncoder commandEncoder, WGPUBuffer buffer, uint64 offset, uint64 size);
/**
 * Proc pointer type for @ref wgpuCommandEncoderCopyBufferToBuffer:
 * > @copydoc wgpuCommandEncoderCopyBufferToBuffer
 */
typealias WGPUProcCommandEncoderCopyBufferToBuffer = function void(WGPUCommandEncoder commandEncoder, WGPUBuffer source, uint64 sourceOffset, WGPUBuffer destination, uint64 destinationOffset, uint64 size);
/**
 * Proc pointer type for @ref wgpuCommandEncoderCopyBufferToTexture:
 * > @copydoc wgpuCommandEncoderCopyBufferToTexture
 */
typealias WGPUProcCommandEncoderCopyBufferToTexture = function void(WGPUCommandEncoder commandEncoder, WGPUTexelCopyBufferInfo* source, WGPUTexelCopyTextureInfo* destination, WGPUExtent3D* copySize);
/**
 * Proc pointer type for @ref wgpuCommandEncoderCopyTextureToBuffer:
 * > @copydoc wgpuCommandEncoderCopyTextureToBuffer
 */
typealias WGPUProcCommandEncoderCopyTextureToBuffer = function void(WGPUCommandEncoder commandEncoder, WGPUTexelCopyTextureInfo* source, WGPUTexelCopyBufferInfo* destination, WGPUExtent3D* copySize);
/**
 * Proc pointer type for @ref wgpuCommandEncoderCopyTextureToTexture:
 * > @copydoc wgpuCommandEncoderCopyTextureToTexture
 */
typealias WGPUProcCommandEncoderCopyTextureToTexture = function void(WGPUCommandEncoder commandEncoder, WGPUTexelCopyTextureInfo* source, WGPUTexelCopyTextureInfo* destination, WGPUExtent3D* copySize);
/**
 * Proc pointer type for @ref wgpuCommandEncoderFinish:
 * > @copydoc wgpuCommandEncoderFinish
 */
typealias WGPUProcCommandEncoderFinish = function WGPUCommandBuffer(WGPUCommandEncoder commandEncoder, WGPUCommandBufferDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuCommandEncoderInsertDebugMarker:
 * > @copydoc wgpuCommandEncoderInsertDebugMarker
 */
typealias WGPUProcCommandEncoderInsertDebugMarker = function void(WGPUCommandEncoder commandEncoder, WGPUStringView markerLabel);
/**
 * Proc pointer type for @ref wgpuCommandEncoderPopDebugGroup:
 * > @copydoc wgpuCommandEncoderPopDebugGroup
 */
typealias WGPUProcCommandEncoderPopDebugGroup = function void(WGPUCommandEncoder commandEncoder);
/**
 * Proc pointer type for @ref wgpuCommandEncoderPushDebugGroup:
 * > @copydoc wgpuCommandEncoderPushDebugGroup
 */
typealias WGPUProcCommandEncoderPushDebugGroup = function void(WGPUCommandEncoder commandEncoder, WGPUStringView groupLabel);
/**
 * Proc pointer type for @ref wgpuCommandEncoderResolveQuerySet:
 * > @copydoc wgpuCommandEncoderResolveQuerySet
 */
typealias WGPUProcCommandEncoderResolveQuerySet = function void(WGPUCommandEncoder commandEncoder, WGPUQuerySet querySet, uint32 firstQuery, uint32 queryCount, WGPUBuffer destination, uint64 destinationOffset);
/**
 * Proc pointer type for @ref wgpuCommandEncoderSetLabel:
 * > @copydoc wgpuCommandEncoderSetLabel
 */
typealias WGPUProcCommandEncoderSetLabel = function void(WGPUCommandEncoder commandEncoder, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuCommandEncoderWriteTimestamp:
 * > @copydoc wgpuCommandEncoderWriteTimestamp
 */
typealias WGPUProcCommandEncoderWriteTimestamp = function void(WGPUCommandEncoder commandEncoder, WGPUQuerySet querySet, uint32 queryIndex);
/**
 * Proc pointer type for @ref wgpuCommandEncoderAddRef:
 * > @copydoc wgpuCommandEncoderAddRef
 */
typealias WGPUProcCommandEncoderAddRef = function void(WGPUCommandEncoder commandEncoder);
/**
 * Proc pointer type for @ref wgpuCommandEncoderRelease:
 * > @copydoc wgpuCommandEncoderRelease
 */
typealias WGPUProcCommandEncoderRelease = function void(WGPUCommandEncoder commandEncoder);

// Procs of ComputePassEncoder
/**
 * Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroups:
 * > @copydoc wgpuComputePassEncoderDispatchWorkgroups
 */
typealias WGPUProcComputePassEncoderDispatchWorkgroups = function void(WGPUComputePassEncoder computePassEncoder, uint32 workgroupCountX, uint32 workgroupCountY, uint32 workgroupCountZ);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroupsIndirect:
 * > @copydoc wgpuComputePassEncoderDispatchWorkgroupsIndirect
 */
typealias WGPUProcComputePassEncoderDispatchWorkgroupsIndirect = function void(WGPUComputePassEncoder computePassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderEnd:
 * > @copydoc wgpuComputePassEncoderEnd
 */
typealias WGPUProcComputePassEncoderEnd = function void(WGPUComputePassEncoder computePassEncoder);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderInsertDebugMarker:
 * > @copydoc wgpuComputePassEncoderInsertDebugMarker
 */
typealias WGPUProcComputePassEncoderInsertDebugMarker = function void(WGPUComputePassEncoder computePassEncoder, WGPUStringView markerLabel);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderPopDebugGroup:
 * > @copydoc wgpuComputePassEncoderPopDebugGroup
 */
typealias WGPUProcComputePassEncoderPopDebugGroup = function void(WGPUComputePassEncoder computePassEncoder);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderPushDebugGroup:
 * > @copydoc wgpuComputePassEncoderPushDebugGroup
 */
typealias WGPUProcComputePassEncoderPushDebugGroup = function void(WGPUComputePassEncoder computePassEncoder, WGPUStringView groupLabel);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderSetBindGroup:
 * > @copydoc wgpuComputePassEncoderSetBindGroup
 */
typealias WGPUProcComputePassEncoderSetBindGroup = function void(WGPUComputePassEncoder computePassEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderSetLabel:
 * > @copydoc wgpuComputePassEncoderSetLabel
 */
typealias WGPUProcComputePassEncoderSetLabel = function void(WGPUComputePassEncoder computePassEncoder, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderSetPipeline:
 * > @copydoc wgpuComputePassEncoderSetPipeline
 */
typealias WGPUProcComputePassEncoderSetPipeline = function void(WGPUComputePassEncoder computePassEncoder, WGPUComputePipeline pipeline);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderAddRef:
 * > @copydoc wgpuComputePassEncoderAddRef
 */
typealias WGPUProcComputePassEncoderAddRef = function void(WGPUComputePassEncoder computePassEncoder);
/**
 * Proc pointer type for @ref wgpuComputePassEncoderRelease:
 * > @copydoc wgpuComputePassEncoderRelease
 */
typealias WGPUProcComputePassEncoderRelease = function void(WGPUComputePassEncoder computePassEncoder);

// Procs of ComputePipeline
/**
 * Proc pointer type for @ref wgpuComputePipelineGetBindGroupLayout:
 * > @copydoc wgpuComputePipelineGetBindGroupLayout
 */
typealias WGPUProcComputePipelineGetBindGroupLayout = function WGPUBindGroupLayout(WGPUComputePipeline computePipeline, uint32 groupIndex);
/**
 * Proc pointer type for @ref wgpuComputePipelineSetLabel:
 * > @copydoc wgpuComputePipelineSetLabel
 */
typealias WGPUProcComputePipelineSetLabel = function void(WGPUComputePipeline computePipeline, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuComputePipelineAddRef:
 * > @copydoc wgpuComputePipelineAddRef
 */
typealias WGPUProcComputePipelineAddRef = function void(WGPUComputePipeline computePipeline);
/**
 * Proc pointer type for @ref wgpuComputePipelineRelease:
 * > @copydoc wgpuComputePipelineRelease
 */
typealias WGPUProcComputePipelineRelease = function void(WGPUComputePipeline computePipeline);

// Procs of Device
/**
 * Proc pointer type for @ref wgpuDeviceCreateBindGroup:
 * > @copydoc wgpuDeviceCreateBindGroup
 */
typealias WGPUProcDeviceCreateBindGroup = function WGPUBindGroup(WGPUDevice device, WGPUBindGroupDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateBindGroupLayout:
 * > @copydoc wgpuDeviceCreateBindGroupLayout
 */
typealias WGPUProcDeviceCreateBindGroupLayout = function WGPUBindGroupLayout(WGPUDevice device, WGPUBindGroupLayoutDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateBuffer:
 * > @copydoc wgpuDeviceCreateBuffer
 */
typealias WGPUProcDeviceCreateBuffer = function WGPUBuffer(WGPUDevice device, WGPUBufferDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateCommandEncoder:
 * > @copydoc wgpuDeviceCreateCommandEncoder
 */
typealias WGPUProcDeviceCreateCommandEncoder = function WGPUCommandEncoder(WGPUDevice device, WGPUCommandEncoderDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateComputePipeline:
 * > @copydoc wgpuDeviceCreateComputePipeline
 */
typealias WGPUProcDeviceCreateComputePipeline = function WGPUComputePipeline(WGPUDevice device, WGPUComputePipelineDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateComputePipelineAsync:
 * > @copydoc wgpuDeviceCreateComputePipelineAsync
 */
typealias WGPUProcDeviceCreateComputePipelineAsync = function WGPUFuture(WGPUDevice device, WGPUComputePipelineDescriptor* descriptor, WGPUCreateComputePipelineAsyncCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuDeviceCreatePipelineLayout:
 * > @copydoc wgpuDeviceCreatePipelineLayout
 */
typealias WGPUProcDeviceCreatePipelineLayout = function WGPUPipelineLayout(WGPUDevice device, WGPUPipelineLayoutDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateQuerySet:
 * > @copydoc wgpuDeviceCreateQuerySet
 */
typealias WGPUProcDeviceCreateQuerySet = function WGPUQuerySet(WGPUDevice device, WGPUQuerySetDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateRenderBundleEncoder:
 * > @copydoc wgpuDeviceCreateRenderBundleEncoder
 */
typealias WGPUProcDeviceCreateRenderBundleEncoder = function WGPURenderBundleEncoder(WGPUDevice device, WGPURenderBundleEncoderDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateRenderPipeline:
 * > @copydoc wgpuDeviceCreateRenderPipeline
 */
typealias WGPUProcDeviceCreateRenderPipeline = function WGPURenderPipeline(WGPUDevice device, WGPURenderPipelineDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateRenderPipelineAsync:
 * > @copydoc wgpuDeviceCreateRenderPipelineAsync
 */
typealias WGPUProcDeviceCreateRenderPipelineAsync = function WGPUFuture(WGPUDevice device, WGPURenderPipelineDescriptor* descriptor, WGPUCreateRenderPipelineAsyncCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuDeviceCreateSampler:
 * > @copydoc wgpuDeviceCreateSampler
 */
typealias WGPUProcDeviceCreateSampler = function WGPUSampler(WGPUDevice device, WGPUSamplerDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateShaderModule:
 * > @copydoc wgpuDeviceCreateShaderModule
 */
typealias WGPUProcDeviceCreateShaderModule = function WGPUShaderModule(WGPUDevice device, WGPUShaderModuleDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceCreateTexture:
 * > @copydoc wgpuDeviceCreateTexture
 */
typealias WGPUProcDeviceCreateTexture = function WGPUTexture(WGPUDevice device, WGPUTextureDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuDeviceDestroy:
 * > @copydoc wgpuDeviceDestroy
 */
typealias WGPUProcDeviceDestroy = function void(WGPUDevice device);
/**
 * Proc pointer type for @ref wgpuDeviceGetAdapterInfo:
 * > @copydoc wgpuDeviceGetAdapterInfo
 */
typealias WGPUProcDeviceGetAdapterInfo = function WGPUStatus(WGPUDevice device, WGPUAdapterInfo* adapterInfo);
/**
 * Proc pointer type for @ref wgpuDeviceGetFeatures:
 * > @copydoc wgpuDeviceGetFeatures
 */
typealias WGPUProcDeviceGetFeatures = function void(WGPUDevice device, WGPUSupportedFeatures* features);
/**
 * Proc pointer type for @ref wgpuDeviceGetLimits:
 * > @copydoc wgpuDeviceGetLimits
 */
typealias WGPUProcDeviceGetLimits = function WGPUStatus(WGPUDevice device, WGPULimits* limits);
/**
 * Proc pointer type for @ref wgpuDeviceGetLostFuture:
 * > @copydoc wgpuDeviceGetLostFuture
 */
typealias WGPUProcDeviceGetLostFuture = function WGPUFuture(WGPUDevice device);
/**
 * Proc pointer type for @ref wgpuDeviceGetQueue:
 * > @copydoc wgpuDeviceGetQueue
 */
typealias WGPUProcDeviceGetQueue = function WGPUQueue(WGPUDevice device);
/**
 * Proc pointer type for @ref wgpuDeviceHasFeature:
 * > @copydoc wgpuDeviceHasFeature
 */
typealias WGPUProcDeviceHasFeature = function WGPUBool(WGPUDevice device, WGPUFeatureName feature);
/**
 * Proc pointer type for @ref wgpuDevicePopErrorScope:
 * > @copydoc wgpuDevicePopErrorScope
 */
typealias WGPUProcDevicePopErrorScope = function WGPUFuture(WGPUDevice device, WGPUPopErrorScopeCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuDevicePushErrorScope:
 * > @copydoc wgpuDevicePushErrorScope
 */
typealias WGPUProcDevicePushErrorScope = function void(WGPUDevice device, WGPUErrorFilter filter);
/**
 * Proc pointer type for @ref wgpuDeviceSetLabel:
 * > @copydoc wgpuDeviceSetLabel
 */
typealias WGPUProcDeviceSetLabel = function void(WGPUDevice device, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuDeviceAddRef:
 * > @copydoc wgpuDeviceAddRef
 */
typealias WGPUProcDeviceAddRef = function void(WGPUDevice device);
/**
 * Proc pointer type for @ref wgpuDeviceRelease:
 * > @copydoc wgpuDeviceRelease
 */
typealias WGPUProcDeviceRelease = function void(WGPUDevice device);

// Procs of ExternalTexture
/**
 * Proc pointer type for @ref wgpuExternalTextureSetLabel:
 * > @copydoc wgpuExternalTextureSetLabel
 */
typealias WGPUProcExternalTextureSetLabel = function void(WGPUExternalTexture externalTexture, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuExternalTextureAddRef:
 * > @copydoc wgpuExternalTextureAddRef
 */
typealias WGPUProcExternalTextureAddRef = function void(WGPUExternalTexture externalTexture);
/**
 * Proc pointer type for @ref wgpuExternalTextureRelease:
 * > @copydoc wgpuExternalTextureRelease
 */
typealias WGPUProcExternalTextureRelease = function void(WGPUExternalTexture externalTexture);

// Procs of Instance
/**
 * Proc pointer type for @ref wgpuInstanceCreateSurface:
 * > @copydoc wgpuInstanceCreateSurface
 */
typealias WGPUProcInstanceCreateSurface = function WGPUSurface(WGPUInstance instance, WGPUSurfaceDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuInstanceGetWGSLLanguageFeatures:
 * > @copydoc wgpuInstanceGetWGSLLanguageFeatures
 */
typealias WGPUProcInstanceGetWGSLLanguageFeatures = function void(WGPUInstance instance, WGPUSupportedWGSLLanguageFeatures* features);
/**
 * Proc pointer type for @ref wgpuInstanceHasWGSLLanguageFeature:
 * > @copydoc wgpuInstanceHasWGSLLanguageFeature
 */
typealias WGPUProcInstanceHasWGSLLanguageFeature = function WGPUBool(WGPUInstance instance, WGPUWGSLLanguageFeatureName feature);
/**
 * Proc pointer type for @ref wgpuInstanceProcessEvents:
 * > @copydoc wgpuInstanceProcessEvents
 */
typealias WGPUProcInstanceProcessEvents = function void(WGPUInstance instance);
/**
 * Proc pointer type for @ref wgpuInstanceRequestAdapter:
 * > @copydoc wgpuInstanceRequestAdapter
 */
typealias WGPUProcInstanceRequestAdapter = function WGPUFuture(WGPUInstance instance, WGPURequestAdapterOptions* options, WGPURequestAdapterCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuInstanceWaitAny:
 * > @copydoc wgpuInstanceWaitAny
 */
typealias WGPUProcInstanceWaitAny = function WGPUWaitStatus(WGPUInstance instance, uint futureCount, WGPUFutureWaitInfo* futures, uint64 timeoutNS);
/**
 * Proc pointer type for @ref wgpuInstanceAddRef:
 * > @copydoc wgpuInstanceAddRef
 */
typealias WGPUProcInstanceAddRef = function void(WGPUInstance instance);
/**
 * Proc pointer type for @ref wgpuInstanceRelease:
 * > @copydoc wgpuInstanceRelease
 */
typealias WGPUProcInstanceRelease = function void(WGPUInstance instance);

// Procs of PipelineLayout
/**
 * Proc pointer type for @ref wgpuPipelineLayoutSetLabel:
 * > @copydoc wgpuPipelineLayoutSetLabel
 */
typealias WGPUProcPipelineLayoutSetLabel = function void(WGPUPipelineLayout pipelineLayout, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuPipelineLayoutAddRef:
 * > @copydoc wgpuPipelineLayoutAddRef
 */
typealias WGPUProcPipelineLayoutAddRef = function void(WGPUPipelineLayout pipelineLayout);
/**
 * Proc pointer type for @ref wgpuPipelineLayoutRelease:
 * > @copydoc wgpuPipelineLayoutRelease
 */
typealias WGPUProcPipelineLayoutRelease = function void(WGPUPipelineLayout pipelineLayout);

// Procs of QuerySet
/**
 * Proc pointer type for @ref wgpuQuerySetDestroy:
 * > @copydoc wgpuQuerySetDestroy
 */
typealias WGPUProcQuerySetDestroy = function void(WGPUQuerySet querySet);
/**
 * Proc pointer type for @ref wgpuQuerySetGetCount:
 * > @copydoc wgpuQuerySetGetCount
 */
typealias WGPUProcQuerySetGetCount = function uint32(WGPUQuerySet querySet);
/**
 * Proc pointer type for @ref wgpuQuerySetGetType:
 * > @copydoc wgpuQuerySetGetType
 */
typealias WGPUProcQuerySetGetType = function WGPUQueryType(WGPUQuerySet querySet);
/**
 * Proc pointer type for @ref wgpuQuerySetSetLabel:
 * > @copydoc wgpuQuerySetSetLabel
 */
typealias WGPUProcQuerySetSetLabel = function void(WGPUQuerySet querySet, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuQuerySetAddRef:
 * > @copydoc wgpuQuerySetAddRef
 */
typealias WGPUProcQuerySetAddRef = function void(WGPUQuerySet querySet);
/**
 * Proc pointer type for @ref wgpuQuerySetRelease:
 * > @copydoc wgpuQuerySetRelease
 */
typealias WGPUProcQuerySetRelease = function void(WGPUQuerySet querySet);

// Procs of Queue
/**
 * Proc pointer type for @ref wgpuQueueOnSubmittedWorkDone:
 * > @copydoc wgpuQueueOnSubmittedWorkDone
 */
typealias WGPUProcQueueOnSubmittedWorkDone = function WGPUFuture(WGPUQueue queue, WGPUQueueWorkDoneCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuQueueSetLabel:
 * > @copydoc wgpuQueueSetLabel
 */
typealias WGPUProcQueueSetLabel = function void(WGPUQueue queue, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuQueueSubmit:
 * > @copydoc wgpuQueueSubmit
 */
typealias WGPUProcQueueSubmit = function void(WGPUQueue queue, uint commandCount, WGPUCommandBuffer* commands);
/**
 * Proc pointer type for @ref wgpuQueueWriteBuffer:
 * > @copydoc wgpuQueueWriteBuffer
 */
typealias WGPUProcQueueWriteBuffer = function void(WGPUQueue queue, WGPUBuffer buffer, uint64 bufferOffset, void* data, uint size);
/**
 * Proc pointer type for @ref wgpuQueueWriteTexture:
 * > @copydoc wgpuQueueWriteTexture
 */
typealias WGPUProcQueueWriteTexture = function void(WGPUQueue queue, WGPUTexelCopyTextureInfo* destination, void* data, uint dataSize, WGPUTexelCopyBufferLayout* dataLayout, WGPUExtent3D* writeSize);
/**
 * Proc pointer type for @ref wgpuQueueAddRef:
 * > @copydoc wgpuQueueAddRef
 */
typealias WGPUProcQueueAddRef = function void(WGPUQueue queue);
/**
 * Proc pointer type for @ref wgpuQueueRelease:
 * > @copydoc wgpuQueueRelease
 */
typealias WGPUProcQueueRelease = function void(WGPUQueue queue);

// Procs of RenderBundle
/**
 * Proc pointer type for @ref wgpuRenderBundleSetLabel:
 * > @copydoc wgpuRenderBundleSetLabel
 */
typealias WGPUProcRenderBundleSetLabel = function void(WGPURenderBundle renderBundle, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuRenderBundleAddRef:
 * > @copydoc wgpuRenderBundleAddRef
 */
typealias WGPUProcRenderBundleAddRef = function void(WGPURenderBundle renderBundle);
/**
 * Proc pointer type for @ref wgpuRenderBundleRelease:
 * > @copydoc wgpuRenderBundleRelease
 */
typealias WGPUProcRenderBundleRelease = function void(WGPURenderBundle renderBundle);

// Procs of RenderBundleEncoder
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderDraw:
 * > @copydoc wgpuRenderBundleEncoderDraw
 */
typealias WGPUProcRenderBundleEncoderDraw = function void(WGPURenderBundleEncoder renderBundleEncoder, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexed:
 * > @copydoc wgpuRenderBundleEncoderDrawIndexed
 */
typealias WGPUProcRenderBundleEncoderDrawIndexed = function void(WGPURenderBundleEncoder renderBundleEncoder, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 baseVertex, uint32 firstInstance);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexedIndirect:
 * > @copydoc wgpuRenderBundleEncoderDrawIndexedIndirect
 */
typealias WGPUProcRenderBundleEncoderDrawIndexedIndirect = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndirect:
 * > @copydoc wgpuRenderBundleEncoderDrawIndirect
 */
typealias WGPUProcRenderBundleEncoderDrawIndirect = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderFinish:
 * > @copydoc wgpuRenderBundleEncoderFinish
 */
typealias WGPUProcRenderBundleEncoderFinish = function WGPURenderBundle(WGPURenderBundleEncoder renderBundleEncoder, WGPURenderBundleDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderInsertDebugMarker:
 * > @copydoc wgpuRenderBundleEncoderInsertDebugMarker
 */
typealias WGPUProcRenderBundleEncoderInsertDebugMarker = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView markerLabel);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderPopDebugGroup:
 * > @copydoc wgpuRenderBundleEncoderPopDebugGroup
 */
typealias WGPUProcRenderBundleEncoderPopDebugGroup = function void(WGPURenderBundleEncoder renderBundleEncoder);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderPushDebugGroup:
 * > @copydoc wgpuRenderBundleEncoderPushDebugGroup
 */
typealias WGPUProcRenderBundleEncoderPushDebugGroup = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView groupLabel);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderSetBindGroup:
 * > @copydoc wgpuRenderBundleEncoderSetBindGroup
 */
typealias WGPUProcRenderBundleEncoderSetBindGroup = function void(WGPURenderBundleEncoder renderBundleEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderSetIndexBuffer:
 * > @copydoc wgpuRenderBundleEncoderSetIndexBuffer
 */
typealias WGPUProcRenderBundleEncoderSetIndexBuffer = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer buffer, WGPUIndexFormat format, uint64 offset, uint64 size);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderSetLabel:
 * > @copydoc wgpuRenderBundleEncoderSetLabel
 */
typealias WGPUProcRenderBundleEncoderSetLabel = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderSetPipeline:
 * > @copydoc wgpuRenderBundleEncoderSetPipeline
 */
typealias WGPUProcRenderBundleEncoderSetPipeline = function void(WGPURenderBundleEncoder renderBundleEncoder, WGPURenderPipeline pipeline);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderSetVertexBuffer:
 * > @copydoc wgpuRenderBundleEncoderSetVertexBuffer
 */
typealias WGPUProcRenderBundleEncoderSetVertexBuffer = function void(WGPURenderBundleEncoder renderBundleEncoder, uint32 slot, WGPUBuffer buffer, uint64 offset, uint64 size);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderAddRef:
 * > @copydoc wgpuRenderBundleEncoderAddRef
 */
typealias WGPUProcRenderBundleEncoderAddRef = function void(WGPURenderBundleEncoder renderBundleEncoder);
/**
 * Proc pointer type for @ref wgpuRenderBundleEncoderRelease:
 * > @copydoc wgpuRenderBundleEncoderRelease
 */
typealias WGPUProcRenderBundleEncoderRelease = function void(WGPURenderBundleEncoder renderBundleEncoder);

// Procs of RenderPassEncoder
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderBeginOcclusionQuery:
 * > @copydoc wgpuRenderPassEncoderBeginOcclusionQuery
 */
typealias WGPUProcRenderPassEncoderBeginOcclusionQuery = function void(WGPURenderPassEncoder renderPassEncoder, uint32 queryIndex);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderDraw:
 * > @copydoc wgpuRenderPassEncoderDraw
 */
typealias WGPUProcRenderPassEncoderDraw = function void(WGPURenderPassEncoder renderPassEncoder, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexed:
 * > @copydoc wgpuRenderPassEncoderDrawIndexed
 */
typealias WGPUProcRenderPassEncoderDrawIndexed = function void(WGPURenderPassEncoder renderPassEncoder, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 baseVertex, uint32 firstInstance);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexedIndirect:
 * > @copydoc wgpuRenderPassEncoderDrawIndexedIndirect
 */
typealias WGPUProcRenderPassEncoderDrawIndexedIndirect = function void(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndirect:
 * > @copydoc wgpuRenderPassEncoderDrawIndirect
 */
typealias WGPUProcRenderPassEncoderDrawIndirect = function void(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderEnd:
 * > @copydoc wgpuRenderPassEncoderEnd
 */
typealias WGPUProcRenderPassEncoderEnd = function void(WGPURenderPassEncoder renderPassEncoder);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderEndOcclusionQuery:
 * > @copydoc wgpuRenderPassEncoderEndOcclusionQuery
 */
typealias WGPUProcRenderPassEncoderEndOcclusionQuery = function void(WGPURenderPassEncoder renderPassEncoder);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderExecuteBundles:
 * > @copydoc wgpuRenderPassEncoderExecuteBundles
 */
typealias WGPUProcRenderPassEncoderExecuteBundles = function void(WGPURenderPassEncoder renderPassEncoder, uint bundleCount, WGPURenderBundle* bundles);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderInsertDebugMarker:
 * > @copydoc wgpuRenderPassEncoderInsertDebugMarker
 */
typealias WGPUProcRenderPassEncoderInsertDebugMarker = function void(WGPURenderPassEncoder renderPassEncoder, WGPUStringView markerLabel);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderPopDebugGroup:
 * > @copydoc wgpuRenderPassEncoderPopDebugGroup
 */
typealias WGPUProcRenderPassEncoderPopDebugGroup = function void(WGPURenderPassEncoder renderPassEncoder);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderPushDebugGroup:
 * > @copydoc wgpuRenderPassEncoderPushDebugGroup
 */
typealias WGPUProcRenderPassEncoderPushDebugGroup = function void(WGPURenderPassEncoder renderPassEncoder, WGPUStringView groupLabel);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetBindGroup:
 * > @copydoc wgpuRenderPassEncoderSetBindGroup
 */
typealias WGPUProcRenderPassEncoderSetBindGroup = function void(WGPURenderPassEncoder renderPassEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetBlendConstant:
 * > @copydoc wgpuRenderPassEncoderSetBlendConstant
 */
typealias WGPUProcRenderPassEncoderSetBlendConstant = function void(WGPURenderPassEncoder renderPassEncoder, WGPUColor* color);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetIndexBuffer:
 * > @copydoc wgpuRenderPassEncoderSetIndexBuffer
 */
typealias WGPUProcRenderPassEncoderSetIndexBuffer = function void(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer buffer, WGPUIndexFormat format, uint64 offset, uint64 size);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetLabel:
 * > @copydoc wgpuRenderPassEncoderSetLabel
 */
typealias WGPUProcRenderPassEncoderSetLabel = function void(WGPURenderPassEncoder renderPassEncoder, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetPipeline:
 * > @copydoc wgpuRenderPassEncoderSetPipeline
 */
typealias WGPUProcRenderPassEncoderSetPipeline = function void(WGPURenderPassEncoder renderPassEncoder, WGPURenderPipeline pipeline);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetScissorRect:
 * > @copydoc wgpuRenderPassEncoderSetScissorRect
 */
typealias WGPUProcRenderPassEncoderSetScissorRect = function void(WGPURenderPassEncoder renderPassEncoder, uint32 x, uint32 y, uint32 width, uint32 height);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetStencilReference:
 * > @copydoc wgpuRenderPassEncoderSetStencilReference
 */
typealias WGPUProcRenderPassEncoderSetStencilReference = function void(WGPURenderPassEncoder renderPassEncoder, uint32 reference);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetVertexBuffer:
 * > @copydoc wgpuRenderPassEncoderSetVertexBuffer
 */
typealias WGPUProcRenderPassEncoderSetVertexBuffer = function void(WGPURenderPassEncoder renderPassEncoder, uint32 slot, WGPUBuffer buffer, uint64 offset, uint64 size);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderSetViewport:
 * > @copydoc wgpuRenderPassEncoderSetViewport
 */
typealias WGPUProcRenderPassEncoderSetViewport = function void(WGPURenderPassEncoder renderPassEncoder, float x, float y, float width, float height, float minDepth, float maxDepth);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderAddRef:
 * > @copydoc wgpuRenderPassEncoderAddRef
 */
typealias WGPUProcRenderPassEncoderAddRef = function void(WGPURenderPassEncoder renderPassEncoder);
/**
 * Proc pointer type for @ref wgpuRenderPassEncoderRelease:
 * > @copydoc wgpuRenderPassEncoderRelease
 */
typealias WGPUProcRenderPassEncoderRelease = function void(WGPURenderPassEncoder renderPassEncoder);

// Procs of RenderPipeline
/**
 * Proc pointer type for @ref wgpuRenderPipelineGetBindGroupLayout:
 * > @copydoc wgpuRenderPipelineGetBindGroupLayout
 */
typealias WGPUProcRenderPipelineGetBindGroupLayout = function WGPUBindGroupLayout(WGPURenderPipeline renderPipeline, uint32 groupIndex);
/**
 * Proc pointer type for @ref wgpuRenderPipelineSetLabel:
 * > @copydoc wgpuRenderPipelineSetLabel
 */
typealias WGPUProcRenderPipelineSetLabel = function void(WGPURenderPipeline renderPipeline, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuRenderPipelineAddRef:
 * > @copydoc wgpuRenderPipelineAddRef
 */
typealias WGPUProcRenderPipelineAddRef = function void(WGPURenderPipeline renderPipeline);
/**
 * Proc pointer type for @ref wgpuRenderPipelineRelease:
 * > @copydoc wgpuRenderPipelineRelease
 */
typealias WGPUProcRenderPipelineRelease = function void(WGPURenderPipeline renderPipeline);

// Procs of Sampler
/**
 * Proc pointer type for @ref wgpuSamplerSetLabel:
 * > @copydoc wgpuSamplerSetLabel
 */
typealias WGPUProcSamplerSetLabel = function void(WGPUSampler sampler, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuSamplerAddRef:
 * > @copydoc wgpuSamplerAddRef
 */
typealias WGPUProcSamplerAddRef = function void(WGPUSampler sampler);
/**
 * Proc pointer type for @ref wgpuSamplerRelease:
 * > @copydoc wgpuSamplerRelease
 */
typealias WGPUProcSamplerRelease = function void(WGPUSampler sampler);

// Procs of ShaderModule
/**
 * Proc pointer type for @ref wgpuShaderModuleGetCompilationInfo:
 * > @copydoc wgpuShaderModuleGetCompilationInfo
 */
typealias WGPUProcShaderModuleGetCompilationInfo = function WGPUFuture(WGPUShaderModule shaderModule, WGPUCompilationInfoCallbackInfo callbackInfo);
/**
 * Proc pointer type for @ref wgpuShaderModuleSetLabel:
 * > @copydoc wgpuShaderModuleSetLabel
 */
typealias WGPUProcShaderModuleSetLabel = function void(WGPUShaderModule shaderModule, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuShaderModuleAddRef:
 * > @copydoc wgpuShaderModuleAddRef
 */
typealias WGPUProcShaderModuleAddRef = function void(WGPUShaderModule shaderModule);
/**
 * Proc pointer type for @ref wgpuShaderModuleRelease:
 * > @copydoc wgpuShaderModuleRelease
 */
typealias WGPUProcShaderModuleRelease = function void(WGPUShaderModule shaderModule);

// Procs of SupportedFeatures
/**
 * Proc pointer type for @ref wgpuSupportedFeaturesFreeMembers:
 * > @copydoc wgpuSupportedFeaturesFreeMembers
 */
typealias WGPUProcSupportedFeaturesFreeMembers = function void(WGPUSupportedFeatures supportedFeatures);

// Procs of SupportedInstanceFeatures
/**
 * Proc pointer type for @ref wgpuSupportedInstanceFeaturesFreeMembers:
 * > @copydoc wgpuSupportedInstanceFeaturesFreeMembers
 */
typealias WGPUProcSupportedInstanceFeaturesFreeMembers = function void(WGPUSupportedInstanceFeatures supportedInstanceFeatures);

// Procs of SupportedWGSLLanguageFeatures
/**
 * Proc pointer type for @ref wgpuSupportedWGSLLanguageFeaturesFreeMembers:
 * > @copydoc wgpuSupportedWGSLLanguageFeaturesFreeMembers
 */
typealias WGPUProcSupportedWGSLLanguageFeaturesFreeMembers = function void(WGPUSupportedWGSLLanguageFeatures supportedWGSLLanguageFeatures);

// Procs of Surface
/**
 * Proc pointer type for @ref wgpuSurfaceConfigure:
 * > @copydoc wgpuSurfaceConfigure
 */
typealias WGPUProcSurfaceConfigure = function void(WGPUSurface surface, WGPUSurfaceConfiguration* config);
/**
 * Proc pointer type for @ref wgpuSurfaceGetCapabilities:
 * > @copydoc wgpuSurfaceGetCapabilities
 */
typealias WGPUProcSurfaceGetCapabilities = function WGPUStatus(WGPUSurface surface, WGPUAdapter adapter, WGPUSurfaceCapabilities* capabilities);
/**
 * Proc pointer type for @ref wgpuSurfaceGetCurrentTexture:
 * > @copydoc wgpuSurfaceGetCurrentTexture
 */
typealias WGPUProcSurfaceGetCurrentTexture = function void(WGPUSurface surface, WGPUSurfaceTexture* surfaceTexture);
/**
 * Proc pointer type for @ref wgpuSurfacePresent:
 * > @copydoc wgpuSurfacePresent
 */
typealias WGPUProcSurfacePresent = function WGPUStatus(WGPUSurface surface);
/**
 * Proc pointer type for @ref wgpuSurfaceSetLabel:
 * > @copydoc wgpuSurfaceSetLabel
 */
typealias WGPUProcSurfaceSetLabel = function void(WGPUSurface surface, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuSurfaceUnconfigure:
 * > @copydoc wgpuSurfaceUnconfigure
 */
typealias WGPUProcSurfaceUnconfigure = function void(WGPUSurface surface);
/**
 * Proc pointer type for @ref wgpuSurfaceAddRef:
 * > @copydoc wgpuSurfaceAddRef
 */
typealias WGPUProcSurfaceAddRef = function void(WGPUSurface surface);
/**
 * Proc pointer type for @ref wgpuSurfaceRelease:
 * > @copydoc wgpuSurfaceRelease
 */
typealias WGPUProcSurfaceRelease = function void(WGPUSurface surface);

// Procs of SurfaceCapabilities
/**
 * Proc pointer type for @ref wgpuSurfaceCapabilitiesFreeMembers:
 * > @copydoc wgpuSurfaceCapabilitiesFreeMembers
 */
typealias WGPUProcSurfaceCapabilitiesFreeMembers = function void(WGPUSurfaceCapabilities surfaceCapabilities);

// Procs of Texture
/**
 * Proc pointer type for @ref wgpuTextureCreateView:
 * > @copydoc wgpuTextureCreateView
 */
typealias WGPUProcTextureCreateView = function WGPUTextureView(WGPUTexture texture, WGPUTextureViewDescriptor* descriptor);
/**
 * Proc pointer type for @ref wgpuTextureDestroy:
 * > @copydoc wgpuTextureDestroy
 */
typealias WGPUProcTextureDestroy = function void(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetDepthOrArrayLayers:
 * > @copydoc wgpuTextureGetDepthOrArrayLayers
 */
typealias WGPUProcTextureGetDepthOrArrayLayers = function uint32(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetDimension:
 * > @copydoc wgpuTextureGetDimension
 */
typealias WGPUProcTextureGetDimension = function WGPUTextureDimension(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetFormat:
 * > @copydoc wgpuTextureGetFormat
 */
typealias WGPUProcTextureGetFormat = function WGPUTextureFormat(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetHeight:
 * > @copydoc wgpuTextureGetHeight
 */
typealias WGPUProcTextureGetHeight = function uint32(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetMipLevelCount:
 * > @copydoc wgpuTextureGetMipLevelCount
 */
typealias WGPUProcTextureGetMipLevelCount = function uint32(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetSampleCount:
 * > @copydoc wgpuTextureGetSampleCount
 */
typealias WGPUProcTextureGetSampleCount = function uint32(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetTextureBindingViewDimension:
 * > @copydoc wgpuTextureGetTextureBindingViewDimension
 */
typealias WGPUProcTextureGetTextureBindingViewDimension = function WGPUTextureViewDimension(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetUsage:
 * > @copydoc wgpuTextureGetUsage
 */
typealias WGPUProcTextureGetUsage = function WGPUTextureUsage(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureGetWidth:
 * > @copydoc wgpuTextureGetWidth
 */
typealias WGPUProcTextureGetWidth = function uint32(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureSetLabel:
 * > @copydoc wgpuTextureSetLabel
 */
typealias WGPUProcTextureSetLabel = function void(WGPUTexture texture, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuTextureAddRef:
 * > @copydoc wgpuTextureAddRef
 */
typealias WGPUProcTextureAddRef = function void(WGPUTexture texture);
/**
 * Proc pointer type for @ref wgpuTextureRelease:
 * > @copydoc wgpuTextureRelease
 */
typealias WGPUProcTextureRelease = function void(WGPUTexture texture);

// Procs of TextureView
/**
 * Proc pointer type for @ref wgpuTextureViewSetLabel:
 * > @copydoc wgpuTextureViewSetLabel
 */
typealias WGPUProcTextureViewSetLabel = function void(WGPUTextureView textureView, WGPUStringView label);
/**
 * Proc pointer type for @ref wgpuTextureViewAddRef:
 * > @copydoc wgpuTextureViewAddRef
 */
typealias WGPUProcTextureViewAddRef = function void(WGPUTextureView textureView);
/**
 * Proc pointer type for @ref wgpuTextureViewRelease:
 * > @copydoc wgpuTextureViewRelease
 */
typealias WGPUProcTextureViewRelease = function void(WGPUTextureView textureView);

/**
 * \defgroup GlobalFunctions Global Functions
 * \brief Functions that are not specific to an object.
 *
 * @{
 */

static
{

/**
 * Create a WGPUInstance
 *
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUInstance wgpuCreateInstance(WGPUInstanceDescriptor* descriptor);
/**
 * Get the list of @ref WGPUInstanceFeatureName values supported by the instance.
 *
 * @param features
 * This parameter is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern void wgpuGetInstanceFeatures(WGPUSupportedInstanceFeatures* features);
/**
 * Get the limits supported by the instance.
 *
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuGetInstanceLimits(WGPUInstanceLimits* limits);
/**
 * Check whether a particular @ref WGPUInstanceFeatureName is supported by the instance.
 */
	[CLink] public static extern WGPUBool wgpuHasInstanceFeature(WGPUInstanceFeatureName feature);
/**
 * Returns the "procedure address" (function pointer) of the named function.
 * The result must be cast to the appropriate proc pointer type.
 */
	[CLink] public static extern WGPUProc wgpuGetProcAddress(WGPUStringView procName);

/** @} */

/**
 * \defgroup Methods Methods
 * \brief Functions that are relative to a specific object.
 *
 * @{
 */

/**
 * \defgroup WGPUAdapterMethods WGPUAdapter methods
 * \brief Functions whose first argument has type WGPUAdapter.
 *
 * @{
 */
/**
 * Get the list of @ref WGPUFeatureName values supported by the adapter.
 *
 * @param features
 * This parameter is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern void wgpuAdapterGetFeatures(WGPUAdapter adapter, WGPUSupportedFeatures* features);
/**
 * @param info
 * This parameter is @ref ReturnedWithOwnership.
 *
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuAdapterGetInfo(WGPUAdapter adapter, WGPUAdapterInfo* info);
/**
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuAdapterGetLimits(WGPUAdapter adapter, WGPULimits* limits);
	[CLink] public static extern WGPUBool wgpuAdapterHasFeature(WGPUAdapter adapter, WGPUFeatureName feature);
	[CLink] public static extern WGPUFuture wgpuAdapterRequestDevice(WGPUAdapter adapter, WGPUDeviceDescriptor* descriptor, WGPURequestDeviceCallbackInfo callbackInfo);
	[CLink] public static extern void wgpuAdapterAddRef(WGPUAdapter adapter);
	[CLink] public static extern void wgpuAdapterRelease(WGPUAdapter adapter);

/** @} */

/**
 * \defgroup WGPUAdapterInfoMethods WGPUAdapterInfo methods
 * \brief Functions whose first argument has type WGPUAdapterInfo.
 *
 * @{
 */
/**
 * Frees members which were allocated by the API.
 */
	[CLink] public static extern void wgpuAdapterInfoFreeMembers(WGPUAdapterInfo adapterInfo);

/** @} */

/**
 * \defgroup WGPUBindGroupMethods WGPUBindGroup methods
 * \brief Functions whose first argument has type WGPUBindGroup.
 *
 * @{
 */
	[CLink] public static extern void wgpuBindGroupSetLabel(WGPUBindGroup bindGroup, WGPUStringView label);
	[CLink] public static extern void wgpuBindGroupAddRef(WGPUBindGroup bindGroup);
	[CLink] public static extern void wgpuBindGroupRelease(WGPUBindGroup bindGroup);

/** @} */

/**
 * \defgroup WGPUBindGroupLayoutMethods WGPUBindGroupLayout methods
 * \brief Functions whose first argument has type WGPUBindGroupLayout.
 *
 * @{
 */
	[CLink] public static extern void wgpuBindGroupLayoutSetLabel(WGPUBindGroupLayout bindGroupLayout, WGPUStringView label);
	[CLink] public static extern void wgpuBindGroupLayoutAddRef(WGPUBindGroupLayout bindGroupLayout);
	[CLink] public static extern void wgpuBindGroupLayoutRelease(WGPUBindGroupLayout bindGroupLayout);

/** @} */

/**
 * \defgroup WGPUBufferMethods WGPUBuffer methods
 * \brief Functions whose first argument has type WGPUBuffer.
 *
 * @{
 */
	[CLink] public static extern void wgpuBufferDestroy(WGPUBuffer buffer);
/**
 * Returns a const pointer to beginning of the mapped range.
 * It must not be written; writing to this range causes undefined behavior.
 * See @ref MappedRangeBehavior for error conditions and guarantees.
 * This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
 *
 * In Wasm, if `memcpy`ing from this range, prefer using @ref wgpuBufferReadMappedRange
 * instead for better performance.
 *
 * @param offset
 * Byte offset relative to the beginning of the buffer.
 *
 * @param size
 * Byte size of the range to get.
 * If this is @ref WGPU_WHOLE_MAP_SIZE, it defaults to `buffer.size - offset`.
 * The returned pointer is valid for exactly this many bytes.
 */
	[CLink] public static extern void* wgpuBufferGetConstMappedRange(WGPUBuffer buffer, uint offset, uint size);
/**
 * Returns a mutable pointer to beginning of the mapped range.
 * See @ref MappedRangeBehavior for error conditions and guarantees.
 * This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
 *
 * In Wasm, if `memcpy`ing into this range, prefer using @ref wgpuBufferWriteMappedRange
 * instead for better performance.
 *
 * @param offset
 * Byte offset relative to the beginning of the buffer.
 *
 * @param size
 * Byte size of the range to get.
 * If this is @ref WGPU_WHOLE_MAP_SIZE, it defaults to `buffer.size - offset`.
 * The returned pointer is valid for exactly this many bytes.
 */
	[CLink] public static extern void* wgpuBufferGetMappedRange(WGPUBuffer buffer, uint offset, uint size);
	[CLink] public static extern WGPUBufferMapState wgpuBufferGetMapState(WGPUBuffer buffer);
	[CLink] public static extern uint64 wgpuBufferGetSize(WGPUBuffer buffer);
	[CLink] public static extern WGPUBufferUsage wgpuBufferGetUsage(WGPUBuffer buffer);
/**
 * @param mode
 * The mapping mode (read or write).
 *
 * @param offset
 * Byte offset relative to beginning of the buffer.
 *
 * @param size
 * Byte size of the region to map.
 * If this is @ref WGPU_WHOLE_MAP_SIZE, it defaults to `buffer.size - offset`.
 */
	[CLink] public static extern WGPUFuture wgpuBufferMapAsync(WGPUBuffer buffer, WGPUMapMode mode, uint offset, uint size, WGPUBufferMapCallbackInfo callbackInfo);
/**
 * Copies a range of data from the buffer mapping into the provided destination pointer.
 * See @ref MappedRangeBehavior for error conditions and guarantees.
 * This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
 *
 * In Wasm, this is more efficient than copying from a mapped range into a `malloc`'d range.
 *
 * @param offset
 * Byte offset relative to the beginning of the buffer.
 *
 * @param data
 * Destination, to read buffer data into.
 *
 * @param size
 * Number of bytes of data to read from the buffer.
 * (Note @ref WGPU_WHOLE_MAP_SIZE is *not* accepted here.)
 *
 * @returns
 * @ref WGPUStatus_Error if the copy did not occur.
 */
	[CLink] public static extern WGPUStatus wgpuBufferReadMappedRange(WGPUBuffer buffer, uint offset, void* data, uint size);
	[CLink] public static extern void wgpuBufferSetLabel(WGPUBuffer buffer, WGPUStringView label);
	[CLink] public static extern void wgpuBufferUnmap(WGPUBuffer buffer);
/**
 * Copies a range of data from the provided source pointer into the buffer mapping.
 * See @ref MappedRangeBehavior for error conditions and guarantees.
 * This function is safe to call inside spontaneous callbacks (see @ref CallbackReentrancy).
 *
 * In Wasm, this is more efficient than copying from a `malloc`'d range into a mapped range.
 *
 * @param offset
 * Byte offset relative to the beginning of the buffer.
 *
 * @param data
 * Source, to write buffer data from.
 *
 * @param size
 * Number of bytes of data to write to the buffer.
 * (Note @ref WGPU_WHOLE_MAP_SIZE is *not* accepted here.)
 *
 * @returns
 * @ref WGPUStatus_Error if the copy did not occur.
 */
	[CLink] public static extern WGPUStatus wgpuBufferWriteMappedRange(WGPUBuffer buffer, uint offset, void* data, uint size);
	[CLink] public static extern void wgpuBufferAddRef(WGPUBuffer buffer);
	[CLink] public static extern void wgpuBufferRelease(WGPUBuffer buffer);

/** @} */

/**
 * \defgroup WGPUCommandBufferMethods WGPUCommandBuffer methods
 * \brief Functions whose first argument has type WGPUCommandBuffer.
 *
 * @{
 */
	[CLink] public static extern void wgpuCommandBufferSetLabel(WGPUCommandBuffer commandBuffer, WGPUStringView label);
	[CLink] public static extern void wgpuCommandBufferAddRef(WGPUCommandBuffer commandBuffer);
	[CLink] public static extern void wgpuCommandBufferRelease(WGPUCommandBuffer commandBuffer);

/** @} */

/**
 * \defgroup WGPUCommandEncoderMethods WGPUCommandEncoder methods
 * \brief Functions whose first argument has type WGPUCommandEncoder.
 *
 * @{
 */
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUComputePassEncoder wgpuCommandEncoderBeginComputePass(WGPUCommandEncoder commandEncoder, WGPUComputePassDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPURenderPassEncoder wgpuCommandEncoderBeginRenderPass(WGPUCommandEncoder commandEncoder, WGPURenderPassDescriptor* descriptor);
	[CLink] public static extern void wgpuCommandEncoderClearBuffer(WGPUCommandEncoder commandEncoder, WGPUBuffer buffer, uint64 offset, uint64 size);
	[CLink] public static extern void wgpuCommandEncoderCopyBufferToBuffer(WGPUCommandEncoder commandEncoder, WGPUBuffer source, uint64 sourceOffset, WGPUBuffer destination, uint64 destinationOffset, uint64 size);
	[CLink] public static extern void wgpuCommandEncoderCopyBufferToTexture(WGPUCommandEncoder commandEncoder, WGPUTexelCopyBufferInfo* source, WGPUTexelCopyTextureInfo* destination, WGPUExtent3D* copySize);
	[CLink] public static extern void wgpuCommandEncoderCopyTextureToBuffer(WGPUCommandEncoder commandEncoder, WGPUTexelCopyTextureInfo* source, WGPUTexelCopyBufferInfo* destination, WGPUExtent3D* copySize);
	[CLink] public static extern void wgpuCommandEncoderCopyTextureToTexture(WGPUCommandEncoder commandEncoder, WGPUTexelCopyTextureInfo* source, WGPUTexelCopyTextureInfo* destination, WGPUExtent3D* copySize);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUCommandBuffer wgpuCommandEncoderFinish(WGPUCommandEncoder commandEncoder, WGPUCommandBufferDescriptor* descriptor);
	[CLink] public static extern void wgpuCommandEncoderInsertDebugMarker(WGPUCommandEncoder commandEncoder, WGPUStringView markerLabel);
	[CLink] public static extern void wgpuCommandEncoderPopDebugGroup(WGPUCommandEncoder commandEncoder);
	[CLink] public static extern void wgpuCommandEncoderPushDebugGroup(WGPUCommandEncoder commandEncoder, WGPUStringView groupLabel);
	[CLink] public static extern void wgpuCommandEncoderResolveQuerySet(WGPUCommandEncoder commandEncoder, WGPUQuerySet querySet, uint32 firstQuery, uint32 queryCount, WGPUBuffer destination, uint64 destinationOffset);
	[CLink] public static extern void wgpuCommandEncoderSetLabel(WGPUCommandEncoder commandEncoder, WGPUStringView label);
	[CLink] public static extern void wgpuCommandEncoderWriteTimestamp(WGPUCommandEncoder commandEncoder, WGPUQuerySet querySet, uint32 queryIndex);
	[CLink] public static extern void wgpuCommandEncoderAddRef(WGPUCommandEncoder commandEncoder);
	[CLink] public static extern void wgpuCommandEncoderRelease(WGPUCommandEncoder commandEncoder);

/** @} */

/**
 * \defgroup WGPUComputePassEncoderMethods WGPUComputePassEncoder methods
 * \brief Functions whose first argument has type WGPUComputePassEncoder.
 *
 * @{
 */
	[CLink] public static extern void wgpuComputePassEncoderDispatchWorkgroups(WGPUComputePassEncoder computePassEncoder, uint32 workgroupCountX, uint32 workgroupCountY, uint32 workgroupCountZ);
	[CLink] public static extern void wgpuComputePassEncoderDispatchWorkgroupsIndirect(WGPUComputePassEncoder computePassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
	[CLink] public static extern void wgpuComputePassEncoderEnd(WGPUComputePassEncoder computePassEncoder);
	[CLink] public static extern void wgpuComputePassEncoderInsertDebugMarker(WGPUComputePassEncoder computePassEncoder, WGPUStringView markerLabel);
	[CLink] public static extern void wgpuComputePassEncoderPopDebugGroup(WGPUComputePassEncoder computePassEncoder);
	[CLink] public static extern void wgpuComputePassEncoderPushDebugGroup(WGPUComputePassEncoder computePassEncoder, WGPUStringView groupLabel);
	[CLink] public static extern void wgpuComputePassEncoderSetBindGroup(WGPUComputePassEncoder computePassEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
	[CLink] public static extern void wgpuComputePassEncoderSetLabel(WGPUComputePassEncoder computePassEncoder, WGPUStringView label);
	[CLink] public static extern void wgpuComputePassEncoderSetPipeline(WGPUComputePassEncoder computePassEncoder, WGPUComputePipeline pipeline);
	[CLink] public static extern void wgpuComputePassEncoderAddRef(WGPUComputePassEncoder computePassEncoder);
	[CLink] public static extern void wgpuComputePassEncoderRelease(WGPUComputePassEncoder computePassEncoder);

/** @} */

/**
 * \defgroup WGPUComputePipelineMethods WGPUComputePipeline methods
 * \brief Functions whose first argument has type WGPUComputePipeline.
 *
 * @{
 */
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUBindGroupLayout wgpuComputePipelineGetBindGroupLayout(WGPUComputePipeline computePipeline, uint32 groupIndex);
	[CLink] public static extern void wgpuComputePipelineSetLabel(WGPUComputePipeline computePipeline, WGPUStringView label);
	[CLink] public static extern void wgpuComputePipelineAddRef(WGPUComputePipeline computePipeline);
	[CLink] public static extern void wgpuComputePipelineRelease(WGPUComputePipeline computePipeline);

/** @} */

/**
 * \defgroup WGPUDeviceMethods WGPUDevice methods
 * \brief Functions whose first argument has type WGPUDevice.
 *
 * @{
 */
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUBindGroup wgpuDeviceCreateBindGroup(WGPUDevice device, WGPUBindGroupDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUBindGroupLayout wgpuDeviceCreateBindGroupLayout(WGPUDevice device, WGPUBindGroupLayoutDescriptor* descriptor);
/**
 * TODO
 *
 * If @ref WGPUBufferDescriptor::mappedAtCreation is `true` and the mapping allocation fails,
 * returns `NULL`.
 *
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUBuffer wgpuDeviceCreateBuffer(WGPUDevice device, WGPUBufferDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUCommandEncoder wgpuDeviceCreateCommandEncoder(WGPUDevice device, WGPUCommandEncoderDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUComputePipeline wgpuDeviceCreateComputePipeline(WGPUDevice device, WGPUComputePipelineDescriptor* descriptor);
	[CLink] public static extern WGPUFuture wgpuDeviceCreateComputePipelineAsync(WGPUDevice device, WGPUComputePipelineDescriptor* descriptor, WGPUCreateComputePipelineAsyncCallbackInfo callbackInfo);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUPipelineLayout wgpuDeviceCreatePipelineLayout(WGPUDevice device, WGPUPipelineLayoutDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUQuerySet wgpuDeviceCreateQuerySet(WGPUDevice device, WGPUQuerySetDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPURenderBundleEncoder wgpuDeviceCreateRenderBundleEncoder(WGPUDevice device, WGPURenderBundleEncoderDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPURenderPipeline wgpuDeviceCreateRenderPipeline(WGPUDevice device, WGPURenderPipelineDescriptor* descriptor);
	[CLink] public static extern WGPUFuture wgpuDeviceCreateRenderPipelineAsync(WGPUDevice device, WGPURenderPipelineDescriptor* descriptor, WGPUCreateRenderPipelineAsyncCallbackInfo callbackInfo);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUSampler wgpuDeviceCreateSampler(WGPUDevice device, WGPUSamplerDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUShaderModule wgpuDeviceCreateShaderModule(WGPUDevice device, WGPUShaderModuleDescriptor* descriptor);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUTexture wgpuDeviceCreateTexture(WGPUDevice device, WGPUTextureDescriptor* descriptor);
	[CLink] public static extern void wgpuDeviceDestroy(WGPUDevice device);
/**
 * @param adapterInfo
 * This parameter is @ref ReturnedWithOwnership.
 *
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuDeviceGetAdapterInfo(WGPUDevice device, WGPUAdapterInfo* adapterInfo);
/**
 * Get the list of @ref WGPUFeatureName values supported by the device.
 *
 * @param features
 * This parameter is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern void wgpuDeviceGetFeatures(WGPUDevice device, WGPUSupportedFeatures* features);
/**
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuDeviceGetLimits(WGPUDevice device, WGPULimits* limits);
/**
 * @returns
 * The @ref WGPUFuture for the device-lost event of the device.
 */
	[CLink] public static extern WGPUFuture wgpuDeviceGetLostFuture(WGPUDevice device);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUQueue wgpuDeviceGetQueue(WGPUDevice device);
	[CLink] public static extern WGPUBool wgpuDeviceHasFeature(WGPUDevice device, WGPUFeatureName feature);
/**
 * Pops an error scope to the current thread's error scope stack,
 * asynchronously returning the result. See @ref ErrorScopes.
 */
	[CLink] public static extern WGPUFuture wgpuDevicePopErrorScope(WGPUDevice device, WGPUPopErrorScopeCallbackInfo callbackInfo);
/**
 * Pushes an error scope to the current thread's error scope stack.
 * See @ref ErrorScopes.
 */
	[CLink] public static extern void wgpuDevicePushErrorScope(WGPUDevice device, WGPUErrorFilter filter);
	[CLink] public static extern void wgpuDeviceSetLabel(WGPUDevice device, WGPUStringView label);
	[CLink] public static extern void wgpuDeviceAddRef(WGPUDevice device);
	[CLink] public static extern void wgpuDeviceRelease(WGPUDevice device);

/** @} */

/**
 * \defgroup WGPUExternalTextureMethods WGPUExternalTexture methods
 * \brief Functions whose first argument has type WGPUExternalTexture.
 *
 * @{
 */
	[CLink] public static extern void wgpuExternalTextureSetLabel(WGPUExternalTexture externalTexture, WGPUStringView label);
	[CLink] public static extern void wgpuExternalTextureAddRef(WGPUExternalTexture externalTexture);
	[CLink] public static extern void wgpuExternalTextureRelease(WGPUExternalTexture externalTexture);

/** @} */

/**
 * \defgroup WGPUInstanceMethods WGPUInstance methods
 * \brief Functions whose first argument has type WGPUInstance.
 *
 * @{
 */
/**
 * Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
 *
 * @param descriptor
 * The description of the @ref WGPUSurface to create.
 *
 * @returns
 * A new @ref WGPUSurface for this descriptor (or an error @ref WGPUSurface).
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUSurface wgpuInstanceCreateSurface(WGPUInstance instance, WGPUSurfaceDescriptor* descriptor);
/**
 * Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
 */
	[CLink] public static extern void wgpuInstanceGetWGSLLanguageFeatures(WGPUInstance instance, WGPUSupportedWGSLLanguageFeatures* features);
	[CLink] public static extern WGPUBool wgpuInstanceHasWGSLLanguageFeature(WGPUInstance instance, WGPUWGSLLanguageFeatureName feature);
/**
 * Processes asynchronous events on this `WGPUInstance`, calling any callbacks for asynchronous operations created with @ref WGPUCallbackMode_AllowProcessEvents.
 *
 * See @ref Process-Events for more information.
 */
	[CLink] public static extern void wgpuInstanceProcessEvents(WGPUInstance instance);
	[CLink] public static extern WGPUFuture wgpuInstanceRequestAdapter(WGPUInstance instance, WGPURequestAdapterOptions* options, WGPURequestAdapterCallbackInfo callbackInfo);
/**
 * Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
 *
 * See @ref Wait-Any for more information.
 */
	[CLink] public static extern WGPUWaitStatus wgpuInstanceWaitAny(WGPUInstance instance, uint futureCount, WGPUFutureWaitInfo* futures, uint64 timeoutNS);
	[CLink] public static extern void wgpuInstanceAddRef(WGPUInstance instance);
	[CLink] public static extern void wgpuInstanceRelease(WGPUInstance instance);

/** @} */

/**
 * \defgroup WGPUPipelineLayoutMethods WGPUPipelineLayout methods
 * \brief Functions whose first argument has type WGPUPipelineLayout.
 *
 * @{
 */
	[CLink] public static extern void wgpuPipelineLayoutSetLabel(WGPUPipelineLayout pipelineLayout, WGPUStringView label);
	[CLink] public static extern void wgpuPipelineLayoutAddRef(WGPUPipelineLayout pipelineLayout);
	[CLink] public static extern void wgpuPipelineLayoutRelease(WGPUPipelineLayout pipelineLayout);

/** @} */

/**
 * \defgroup WGPUQuerySetMethods WGPUQuerySet methods
 * \brief Functions whose first argument has type WGPUQuerySet.
 *
 * @{
 */
	[CLink] public static extern void wgpuQuerySetDestroy(WGPUQuerySet querySet);
	[CLink] public static extern uint32 wgpuQuerySetGetCount(WGPUQuerySet querySet);
	[CLink] public static extern WGPUQueryType wgpuQuerySetGetType(WGPUQuerySet querySet);
	[CLink] public static extern void wgpuQuerySetSetLabel(WGPUQuerySet querySet, WGPUStringView label);
	[CLink] public static extern void wgpuQuerySetAddRef(WGPUQuerySet querySet);
	[CLink] public static extern void wgpuQuerySetRelease(WGPUQuerySet querySet);

/** @} */

/**
 * \defgroup WGPUQueueMethods WGPUQueue methods
 * \brief Functions whose first argument has type WGPUQueue.
 *
 * @{
 */
	[CLink] public static extern WGPUFuture wgpuQueueOnSubmittedWorkDone(WGPUQueue queue, WGPUQueueWorkDoneCallbackInfo callbackInfo);
	[CLink] public static extern void wgpuQueueSetLabel(WGPUQueue queue, WGPUStringView label);
	[CLink] public static extern void wgpuQueueSubmit(WGPUQueue queue, uint commandCount, WGPUCommandBuffer* commands);
/**
 * Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
 * errors defined by the WebGPU specification.
 */
	[CLink] public static extern void wgpuQueueWriteBuffer(WGPUQueue queue, WGPUBuffer buffer, uint64 bufferOffset, void* data, uint size);
	[CLink] public static extern void wgpuQueueWriteTexture(WGPUQueue queue, WGPUTexelCopyTextureInfo* destination, void* data, uint dataSize, WGPUTexelCopyBufferLayout* dataLayout, WGPUExtent3D* writeSize);
	[CLink] public static extern void wgpuQueueAddRef(WGPUQueue queue);
	[CLink] public static extern void wgpuQueueRelease(WGPUQueue queue);

/** @} */

/**
 * \defgroup WGPURenderBundleMethods WGPURenderBundle methods
 * \brief Functions whose first argument has type WGPURenderBundle.
 *
 * @{
 */
	[CLink] public static extern void wgpuRenderBundleSetLabel(WGPURenderBundle renderBundle, WGPUStringView label);
	[CLink] public static extern void wgpuRenderBundleAddRef(WGPURenderBundle renderBundle);
	[CLink] public static extern void wgpuRenderBundleRelease(WGPURenderBundle renderBundle);

/** @} */

/**
 * \defgroup WGPURenderBundleEncoderMethods WGPURenderBundleEncoder methods
 * \brief Functions whose first argument has type WGPURenderBundleEncoder.
 *
 * @{
 */
	[CLink] public static extern void wgpuRenderBundleEncoderDraw(WGPURenderBundleEncoder renderBundleEncoder, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance);
	[CLink] public static extern void wgpuRenderBundleEncoderDrawIndexed(WGPURenderBundleEncoder renderBundleEncoder, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 baseVertex, uint32 firstInstance);
	[CLink] public static extern void wgpuRenderBundleEncoderDrawIndexedIndirect(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
	[CLink] public static extern void wgpuRenderBundleEncoderDrawIndirect(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPURenderBundle wgpuRenderBundleEncoderFinish(WGPURenderBundleEncoder renderBundleEncoder, WGPURenderBundleDescriptor* descriptor);
	[CLink] public static extern void wgpuRenderBundleEncoderInsertDebugMarker(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView markerLabel);
	[CLink] public static extern void wgpuRenderBundleEncoderPopDebugGroup(WGPURenderBundleEncoder renderBundleEncoder);
	[CLink] public static extern void wgpuRenderBundleEncoderPushDebugGroup(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView groupLabel);
	[CLink] public static extern void wgpuRenderBundleEncoderSetBindGroup(WGPURenderBundleEncoder renderBundleEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
	[CLink] public static extern void wgpuRenderBundleEncoderSetIndexBuffer(WGPURenderBundleEncoder renderBundleEncoder, WGPUBuffer buffer, WGPUIndexFormat format, uint64 offset, uint64 size);
	[CLink] public static extern void wgpuRenderBundleEncoderSetLabel(WGPURenderBundleEncoder renderBundleEncoder, WGPUStringView label);
	[CLink] public static extern void wgpuRenderBundleEncoderSetPipeline(WGPURenderBundleEncoder renderBundleEncoder, WGPURenderPipeline pipeline);
	[CLink] public static extern void wgpuRenderBundleEncoderSetVertexBuffer(WGPURenderBundleEncoder renderBundleEncoder, uint32 slot, WGPUBuffer buffer, uint64 offset, uint64 size);
	[CLink] public static extern void wgpuRenderBundleEncoderAddRef(WGPURenderBundleEncoder renderBundleEncoder);
	[CLink] public static extern void wgpuRenderBundleEncoderRelease(WGPURenderBundleEncoder renderBundleEncoder);

/** @} */

/**
 * \defgroup WGPURenderPassEncoderMethods WGPURenderPassEncoder methods
 * \brief Functions whose first argument has type WGPURenderPassEncoder.
 *
 * @{
 */
	[CLink] public static extern void wgpuRenderPassEncoderBeginOcclusionQuery(WGPURenderPassEncoder renderPassEncoder, uint32 queryIndex);
	[CLink] public static extern void wgpuRenderPassEncoderDraw(WGPURenderPassEncoder renderPassEncoder, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance);
	[CLink] public static extern void wgpuRenderPassEncoderDrawIndexed(WGPURenderPassEncoder renderPassEncoder, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 baseVertex, uint32 firstInstance);
	[CLink] public static extern void wgpuRenderPassEncoderDrawIndexedIndirect(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
	[CLink] public static extern void wgpuRenderPassEncoderDrawIndirect(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer indirectBuffer, uint64 indirectOffset);
	[CLink] public static extern void wgpuRenderPassEncoderEnd(WGPURenderPassEncoder renderPassEncoder);
	[CLink] public static extern void wgpuRenderPassEncoderEndOcclusionQuery(WGPURenderPassEncoder renderPassEncoder);
	[CLink] public static extern void wgpuRenderPassEncoderExecuteBundles(WGPURenderPassEncoder renderPassEncoder, uint bundleCount, WGPURenderBundle* bundles);
	[CLink] public static extern void wgpuRenderPassEncoderInsertDebugMarker(WGPURenderPassEncoder renderPassEncoder, WGPUStringView markerLabel);
	[CLink] public static extern void wgpuRenderPassEncoderPopDebugGroup(WGPURenderPassEncoder renderPassEncoder);
	[CLink] public static extern void wgpuRenderPassEncoderPushDebugGroup(WGPURenderPassEncoder renderPassEncoder, WGPUStringView groupLabel);
	[CLink] public static extern void wgpuRenderPassEncoderSetBindGroup(WGPURenderPassEncoder renderPassEncoder, uint32 groupIndex, WGPUBindGroup group, uint dynamicOffsetCount, uint32* dynamicOffsets);
/**
 * @param color
 * The RGBA blend constant. Represents an `f32` color using @ref DoubleAsSupertype.
 */
	[CLink] public static extern void wgpuRenderPassEncoderSetBlendConstant(WGPURenderPassEncoder renderPassEncoder, WGPUColor* color);
	[CLink] public static extern void wgpuRenderPassEncoderSetIndexBuffer(WGPURenderPassEncoder renderPassEncoder, WGPUBuffer buffer, WGPUIndexFormat format, uint64 offset, uint64 size);
	[CLink] public static extern void wgpuRenderPassEncoderSetLabel(WGPURenderPassEncoder renderPassEncoder, WGPUStringView label);
	[CLink] public static extern void wgpuRenderPassEncoderSetPipeline(WGPURenderPassEncoder renderPassEncoder, WGPURenderPipeline pipeline);
	[CLink] public static extern void wgpuRenderPassEncoderSetScissorRect(WGPURenderPassEncoder renderPassEncoder, uint32 x, uint32 y, uint32 width, uint32 height);
	[CLink] public static extern void wgpuRenderPassEncoderSetStencilReference(WGPURenderPassEncoder renderPassEncoder, uint32 reference);
	[CLink] public static extern void wgpuRenderPassEncoderSetVertexBuffer(WGPURenderPassEncoder renderPassEncoder, uint32 slot, WGPUBuffer buffer, uint64 offset, uint64 size);
/**
 * TODO
 *
 * If any argument is non-finite, produces a @ref NonFiniteFloatValueError.
 */
	[CLink] public static extern void wgpuRenderPassEncoderSetViewport(WGPURenderPassEncoder renderPassEncoder, float x, float y, float width, float height, float minDepth, float maxDepth);
	[CLink] public static extern void wgpuRenderPassEncoderAddRef(WGPURenderPassEncoder renderPassEncoder);
	[CLink] public static extern void wgpuRenderPassEncoderRelease(WGPURenderPassEncoder renderPassEncoder);

/** @} */

/**
 * \defgroup WGPURenderPipelineMethods WGPURenderPipeline methods
 * \brief Functions whose first argument has type WGPURenderPipeline.
 *
 * @{
 */
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUBindGroupLayout wgpuRenderPipelineGetBindGroupLayout(WGPURenderPipeline renderPipeline, uint32 groupIndex);
	[CLink] public static extern void wgpuRenderPipelineSetLabel(WGPURenderPipeline renderPipeline, WGPUStringView label);
	[CLink] public static extern void wgpuRenderPipelineAddRef(WGPURenderPipeline renderPipeline);
	[CLink] public static extern void wgpuRenderPipelineRelease(WGPURenderPipeline renderPipeline);

/** @} */

/**
 * \defgroup WGPUSamplerMethods WGPUSampler methods
 * \brief Functions whose first argument has type WGPUSampler.
 *
 * @{
 */
	[CLink] public static extern void wgpuSamplerSetLabel(WGPUSampler sampler, WGPUStringView label);
	[CLink] public static extern void wgpuSamplerAddRef(WGPUSampler sampler);
	[CLink] public static extern void wgpuSamplerRelease(WGPUSampler sampler);

/** @} */

/**
 * \defgroup WGPUShaderModuleMethods WGPUShaderModule methods
 * \brief Functions whose first argument has type WGPUShaderModule.
 *
 * @{
 */
	[CLink] public static extern WGPUFuture wgpuShaderModuleGetCompilationInfo(WGPUShaderModule shaderModule, WGPUCompilationInfoCallbackInfo callbackInfo);
	[CLink] public static extern void wgpuShaderModuleSetLabel(WGPUShaderModule shaderModule, WGPUStringView label);
	[CLink] public static extern void wgpuShaderModuleAddRef(WGPUShaderModule shaderModule);
	[CLink] public static extern void wgpuShaderModuleRelease(WGPUShaderModule shaderModule);

/** @} */

/**
 * \defgroup WGPUSupportedFeaturesMethods WGPUSupportedFeatures methods
 * \brief Functions whose first argument has type WGPUSupportedFeatures.
 *
 * @{
 */
/**
 * Frees members which were allocated by the API.
 */
	[CLink] public static extern void wgpuSupportedFeaturesFreeMembers(WGPUSupportedFeatures supportedFeatures);

/** @} */

/**
 * \defgroup WGPUSupportedInstanceFeaturesMethods WGPUSupportedInstanceFeatures methods
 * \brief Functions whose first argument has type WGPUSupportedInstanceFeatures.
 *
 * @{
 */
/**
 * Frees members which were allocated by the API.
 */
	[CLink] public static extern void wgpuSupportedInstanceFeaturesFreeMembers(WGPUSupportedInstanceFeatures supportedInstanceFeatures);

/** @} */

/**
 * \defgroup WGPUSupportedWGSLLanguageFeaturesMethods WGPUSupportedWGSLLanguageFeatures methods
 * \brief Functions whose first argument has type WGPUSupportedWGSLLanguageFeatures.
 *
 * @{
 */
/**
 * Frees members which were allocated by the API.
 */
	[CLink] public static extern void wgpuSupportedWGSLLanguageFeaturesFreeMembers(WGPUSupportedWGSLLanguageFeatures supportedWGSLLanguageFeatures);

/** @} */

/**
 * \defgroup WGPUSurfaceMethods WGPUSurface methods
 * \brief Functions whose first argument has type WGPUSurface.
 *
 * @{
 */
/**
 * Configures parameters for rendering to `surface`.
 * Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
 *
 * See @ref Surface-Configuration for more details.
 *
 * @param config
 * The new configuration to use.
 */
	[CLink] public static extern void wgpuSurfaceConfigure(WGPUSurface surface, WGPUSurfaceConfiguration* config);
/**
 * Provides information on how `adapter` is able to use `surface`.
 * See @ref Surface-Capabilities for more details.
 *
 * @param adapter
 * The @ref WGPUAdapter to get capabilities for presenting to this @ref WGPUSurface.
 *
 * @param capabilities
 * The structure to fill capabilities in.
 * It may contain memory allocations so @ref wgpuSurfaceCapabilitiesFreeMembers must be called to avoid memory leaks.
 * This parameter is @ref ReturnedWithOwnership.
 *
 * @returns
 * Indicates if there was an @ref OutStructChainError.
 */
	[CLink] public static extern WGPUStatus wgpuSurfaceGetCapabilities(WGPUSurface surface, WGPUAdapter adapter, WGPUSurfaceCapabilities* capabilities);
/**
 * Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
 * Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
 *
 * See @ref Surface-Presenting for more details.
 *
 * @param surfaceTexture
 * The structure to fill the @ref WGPUTexture and metadata in.
 */
	[CLink] public static extern void wgpuSurfaceGetCurrentTexture(WGPUSurface surface, WGPUSurfaceTexture* surfaceTexture);
/**
 * Shows `surface`'s current texture to the user.
 * See @ref Surface-Presenting for more details.
 *
 * @returns
 * Returns @ref WGPUStatus_Error if the surface doesn't have a current texture.
 */
	[CLink] public static extern WGPUStatus wgpuSurfacePresent(WGPUSurface surface);
/**
 * Modifies the label used to refer to `surface`.
 *
 * @param label
 * The new label.
 */
	[CLink] public static extern void wgpuSurfaceSetLabel(WGPUSurface surface, WGPUStringView label);
/**
 * Removes the configuration for `surface`.
 * See @ref Surface-Configuration for more details.
 */
	[CLink] public static extern void wgpuSurfaceUnconfigure(WGPUSurface surface);
	[CLink] public static extern void wgpuSurfaceAddRef(WGPUSurface surface);
	[CLink] public static extern void wgpuSurfaceRelease(WGPUSurface surface);

/** @} */

/**
 * \defgroup WGPUSurfaceCapabilitiesMethods WGPUSurfaceCapabilities methods
 * \brief Functions whose first argument has type WGPUSurfaceCapabilities.
 *
 * @{
 */
/**
 * Frees members which were allocated by the API.
 */
	[CLink] public static extern void wgpuSurfaceCapabilitiesFreeMembers(WGPUSurfaceCapabilities surfaceCapabilities);

/** @} */

/**
 * \defgroup WGPUTextureMethods WGPUTexture methods
 * \brief Functions whose first argument has type WGPUTexture.
 *
 * @{
 */
/**
 * @returns
 * This value is @ref ReturnedWithOwnership.
 */
	[CLink] public static extern WGPUTextureView wgpuTextureCreateView(WGPUTexture texture, WGPUTextureViewDescriptor* descriptor);
	[CLink] public static extern void wgpuTextureDestroy(WGPUTexture texture);
	[CLink] public static extern uint32 wgpuTextureGetDepthOrArrayLayers(WGPUTexture texture);
	[CLink] public static extern WGPUTextureDimension wgpuTextureGetDimension(WGPUTexture texture);
	[CLink] public static extern WGPUTextureFormat wgpuTextureGetFormat(WGPUTexture texture);
	[CLink] public static extern uint32 wgpuTextureGetHeight(WGPUTexture texture);
	[CLink] public static extern uint32 wgpuTextureGetMipLevelCount(WGPUTexture texture);
	[CLink] public static extern uint32 wgpuTextureGetSampleCount(WGPUTexture texture);
	[CLink] public static extern WGPUTextureViewDimension wgpuTextureGetTextureBindingViewDimension(WGPUTexture texture);
	[CLink] public static extern WGPUTextureUsage wgpuTextureGetUsage(WGPUTexture texture);
	[CLink] public static extern uint32 wgpuTextureGetWidth(WGPUTexture texture);
	[CLink] public static extern void wgpuTextureSetLabel(WGPUTexture texture, WGPUStringView label);
	[CLink] public static extern void wgpuTextureAddRef(WGPUTexture texture);
	[CLink] public static extern void wgpuTextureRelease(WGPUTexture texture);

/** @} */

/**
 * \defgroup WGPUTextureViewMethods WGPUTextureView methods
 * \brief Functions whose first argument has type WGPUTextureView.
 *
 * @{
 */
	[CLink] public static extern void wgpuTextureViewSetLabel(WGPUTextureView textureView, WGPUStringView label);
	[CLink] public static extern void wgpuTextureViewAddRef(WGPUTextureView textureView);
	[CLink] public static extern void wgpuTextureViewRelease(WGPUTextureView textureView);

}
/** @} */

/** @} */
