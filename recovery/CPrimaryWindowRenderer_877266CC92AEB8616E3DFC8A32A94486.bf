namespace ClockWorkEditor.Renderer.Primary;

using System;

using ClockWorkEditor.Renderer;
using ClockWorkEditor.Gui.Primary;
using static SDL2.SDL;

class CPrimaryWindowRenderer : CRenderer
{
	public this(ClockWorkEditor Editor) : base(Editor){}

	public override void Init(Window* ApplicationWindow)
	{
		AppWindow = ApplicationWindow;
		AppRenderer = CreateRenderer(AppWindow, 0, .Accelerated);


		

		WinGui = new CPrimaryGui(CWEditor, this);
		WinGui.Init(AppRenderer);
	}

	public override void DrawWindow()
	{
		int32 AppW;
		int32 AppH;

		GetWindowSize(AppWindow, out AppW, out AppH);

		let WindowRect = scope Rect(0, 0, AppW, AppH);

		SetRenderDrawColor(AppRenderer, 35, 35, 38, 255);
		RenderFillRect(AppRenderer, WindowRect);
	}

	public override void Shutdown()
	{
		WinGui.Shutdown();
		delete WinGui;
	}
}