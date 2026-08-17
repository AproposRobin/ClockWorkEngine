namespace ClockWorkEngine.Application;

using ClockWorkEngine.Window;
using System;
using System.Collections;

using SDL3.Raw;

using static SDL3.Raw.SDL_EventType;

using TailTrace;


abstract class CApplication
{
	protected List<CWindow> Windows = new .() ~ delete _;
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

	public void PollEvents()
	{
		SDL_Event Event = default;
		while (SDL_PollEvent(&Event))
		{
			switch(Event.type)
			{
			case (.)SDL_EVENT_QUIT://<--All the . is doing is telling the compile to infer the type for me in this case it's a uint32 cast
				Exit(0);
				break;
			default:
				break;
			}
		}
		
	}
}