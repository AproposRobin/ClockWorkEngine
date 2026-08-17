namespace ClockWorkEditor.Renderer;

using ClockWorkEditor.Gui;

using SDL2;
using static SDL2.SDL;

abstract class CRenderer
{
	protected ClockWorkEditor CWEditor;
	protected Renderer* AppRenderer;
	protected Window* AppWindow;
	protected CGui WinGui;

	public this(ClockWorkEditor Editor)
	{
		CWEditor = Editor;
	}

	public abstract void Init(Window* ApplicationWindow);
	public abstract void DrawWindow();

	public virtual void Tick()
	{
		SetRenderDrawColor(AppRenderer, 0, 0, 0, 255);
		RenderClear(AppRenderer);
		DrawWindow();
		WinGui.Draw();
		RenderPresent(AppRenderer);
	}

	public virtual void Shutdown()
	{
		WinGui.Shutdown();
		DestroyRenderer(AppRenderer);
	}

	public Renderer* GetRenderer(){return AppRenderer;}
	public Window* GetRendererWindow(){return AppWindow;}
}