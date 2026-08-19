namespace ClockWorkEngine.Application;

using ClockWorkEngine.Window;
using System;
using System.Collections;

using SDL3.Raw;

using TailTrace;


abstract class CApplication
{
	protected List<CWindow> Windows = new .() ~ DeleteContainerAndItems!(_);
	protected ClockWorkEngine CEngine;
	protected StringView AppName;

	public this(ClockWorkEngine Engine)
	{
		CEngine = Engine;
		if(!SDL_Init(.SDL_INIT_EVENTS | .SDL_INIT_VIDEO))
		{
			Log.Error("Failed to initialize SDL, application will shutdown");
			Exit(2);//<--Exit code 2 SDL initialization failure
		}
	}

	public abstract void Init(StringView ApplicationName);
	public abstract void Tick();
	public abstract void Exit(int32 ExitReason);
	public abstract void Shutdown();
}