namespace ClockWorkEditor.Window;

using System;

using ClockWorkEditor.Panel;
using ClockWorkEditor.PanelManager;
using ClockWorkEditor.Gui;
using ClockWorkEditor.Renderer;
using SDL2;

using static SDL2.SDL;

class ClockWorkWindow
{
	private ClockWorkEditor CWEditor;
	private ClockWorkRenderer CRend = new .(CWEditor) ~ delete _;
	private StringView WinName;
	private Window* AppWindow;

	
	public this(ClockWorkEditor Editor, StringView WindowName)
	{
		CWEditor = Editor;
		WinName = WindowName;
	}

	public void Init()
	{
		AppWindow = CreateWindow(scope String(WinName), .Centered, .Centered, 800, 600, .Shown | .Maximized | .Resizable);
		CRend.Init(AppWindow);

	}


	public void Tick()
	{
		PollEvents();
		CRend.Tick();
	}

	public void RequestShutdown(int32 ExitReason)
	{
		CWEditor.ShutdownApplication(ExitReason);
	}

	public void Shutdown()
	{
		CRend.Shutdown();
		DestroyWindow(AppWindow);
	}

	public Window* GetAppWindow() {return AppWindow;}

	private void PollEvents()
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
}