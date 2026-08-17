namespace ClockWorkEditor.Window.Primary;

using System;

using ClockWorkEditor.Window;
using ClockWorkEditor.Renderer.Primary;

using SDL2;
using static SDL2.SDL;


class CPrimaryWindow : CWindow
{
	
	public this(ClockWorkEditor Editor, StringView WindowName) : base(Editor, WindowName){}

	public override void RequestShutdown(int32 ExitReason)
	{
		CWEditor.ShutdownApplication(ExitReason);
	}

	public override void Shutdown()
	{
		CRend.Shutdown();
		DestroyWindow(AppWindow);
		delete CRend;
	}

	public override void CreateAppWindow()
	{
		AppWindow = SDL.CreateWindow(scope String(WinName), .Centered, .Centered, 800, 600, .Shown | .Maximized | .Resizable);
	}

	public override void CreateRenderer()
	{
		CRend = new CPrimaryWindowRenderer(CWEditor);
		CRend.Init(AppWindow);
	}
}