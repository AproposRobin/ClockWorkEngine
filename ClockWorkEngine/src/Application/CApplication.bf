namespace ClockWorkEngine.Application;

using ClockWorkEngine.Window;
using System;
using System.Collections;

using SDL3.Raw;

using static SDL3.Raw.SDL_EventType;

abstract class CApplication
{
	protected List<CWindow> Windows;
	protected ClockWorkEngine* CEngine;
	protected StringView AppName;
	protected SDL_Window* AppWindow;
	protected SDL_Renderer* AppRenderer;

	public this(ClockWorkEngine* Engine)
	{
		CEngine = Engine;
		SDL_Init(.SDL_INIT_EVENTS | .SDL_INIT_VIDEO);
	}

	public abstract void Init(StringView ApplicationName);
	public abstract void Tick();
	public abstract void Exit(int32 ExitReason);
	public abstract void Shutdown();

	public void CreateWindow(StringView WindowTitle)
	{
		SDL_CreateWindowAndRenderer(scope String(WindowTitle), 800, 600, .SDL_WINDOW_RESIZABLE | .SDL_WINDOW_MAXIMIZED, &AppWindow, &AppRenderer);
	}

	public void PollEvents()
	{
		SDL_Event Event = default;
		while (SDL_PollEvent(&Event))
		{
			switch(Event.type)
			{
			case (uint32)SDL_EVENT_QUIT:
				Exit(0);
				break;
			default:
				break;
			}
		}
		
	}
}