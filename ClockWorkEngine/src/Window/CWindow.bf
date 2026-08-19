namespace ClockWorkEngine.Window;

using System;

using ClockWorkEngine.Application;
using SDL3.Raw;

using static SDL3.Raw.SDL_EventType;

abstract class CWindow
{
	protected StringView WindowName;
	protected SDL_Window* AppWindow;
	protected SDL_Renderer* AppRenderer;

	public this(StringView Name)
	{
		WindowName = Name;
	}

	public void CreateWindow(StringView WindowTitle)
	{
		SDL_CreateWindowAndRenderer(scope String(WindowTitle), 800, 600, .SDL_WINDOW_RESIZABLE | .SDL_WINDOW_MAXIMIZED | .SDL_WINDOW_BORDERLESS, &AppWindow, &AppRenderer);
	}

	public abstract void Init();
	public abstract void Tick();
	public abstract void Shutdown();
	public abstract void DrawUI();

	public virtual void CreateCustomWindow(StringView WindowTitle){}

	public void PollEvents()
	{
		SDL_Event Event = default;
		while (SDL_PollEvent(&Event))
		{
			switch(Event.type)
			{
			case (.)SDL_EVENT_QUIT://<--All the . is doing is telling the compile to infer the type for me in this case it's a uint32 cast
				//Call shutdown from application
				break;
			default:
				break;
			}
		}
		
	}
}