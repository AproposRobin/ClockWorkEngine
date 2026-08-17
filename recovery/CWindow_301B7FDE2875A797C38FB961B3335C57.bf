namespace ClockWorkEditor.Window;

using ClockWorkEditor.Renderer;
using ClockWorkEditor.Renderer.Primary;
using System;

using SDL2;

using static SDL2.SDL;

/*
* Constructor(Should always be declared in each window)
* =============================================================================================================
* public this(ClockWorkEditor Editor, StringView WindowName) : base(Editor, WindowName){}
* =============================================================================================================
*
* Required Functions
* =============================================================================================================
* public override void RequestShutdown(int32 ExitReason);
* public override void Shutdown();
* public override void CreateAppWindow();
* =============================================================================================================
*
*
* Overridable Functions
* =============================================================================================================
* public override void Tick()
* protected override void PollEvents()
* =============================================================================================================
*
*/

abstract class CWindow
{
	protected Window* AppWindow;
	protected ClockWorkEditor CWEditor;
	protected CRenderer CRend;
	protected StringView WinName;

	public this(ClockWorkEditor Editor, StringView WindowName)
	{
		CWEditor = Editor;
		WinName = WindowName;
	}

	public void Init()
	{
		CreateAppWindow();
		CreateRenderer();

	}

	public virtual void Tick()//<--If this is overwritten base.Tick() should always be called
	{
		PollEvents();
		CRend.Tick();
	}

	protected virtual void PollEvents()
	{
		Event Pollevent;
		while (PollEvent(out Pollevent) != 0)
		{
			//Log(scope $"SDL Event {Pollevent.type}"); <--Simple logger to see events
			switch (Pollevent.type)
			{
			case .Quit:
				RequestShutdown(0);
				break;
			default:
				break;
			}
		}
	}

	public Window* GetAppWindow() {return AppWindow;}

	public abstract void RequestShutdown(int32 ExitReason);
	public abstract void Shutdown();
	public abstract void CreateAppWindow();
	public abstract void CreateRenderer();
}
