namespace ClockWorkEngine.Window;

using System;

using ClockWorkEngine.Application;
using SDL3.Raw;



abstract class CWindow
{
	protected CApplication App;
	protected StringView WindowName;
	protected SDL_Window* AppWindow;
	protected SDL_Renderer* AppRenderer;

	public this(CApplication Application, StringView Name)
	{
		App = Application;
		WindowName = Name;
	}

	public void CreateWindow(StringView WindowTitle)
	{
		SDL_CreateWindowAndRenderer(scope String(WindowTitle), 800, 600, .SDL_WINDOW_RESIZABLE | .SDL_WINDOW_MAXIMIZED | .SDL_WINDOW_BORDERLESS, &AppWindow, &AppRenderer);
	}

	public abstract void Init();
	public abstract void Tick();
	public abstract void Shutdown();
}