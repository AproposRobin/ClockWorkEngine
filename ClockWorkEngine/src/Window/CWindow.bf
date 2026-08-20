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

	public abstract void Init();
	public abstract void Shutdown();
	public abstract void Tick();
	public abstract void DrawUI();

	public void CreatePrimaryWindow()
	{
		SDL_CreateWindowAndRenderer(WindowName.ToScopeCStr!(), 800, 600, .SDL_WINDOW_RESIZABLE | .SDL_WINDOW_MAXIMIZED | .SDL_WINDOW_BORDERLESS, &AppWindow, &AppRenderer);
	}

	public virtual void CreateCustomWindow(){}
}