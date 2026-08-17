namespace ClockWorkEditor.Renderer;

using System;

using ClockWorkEditor.WindowRenderer;
using static SDL2.SDL;

class ClockWorkRenderer : CRenderer
{
	public this(ClockWorkEditor Editor) : base(Editor){}

	public override void Init(Window* AppWindow)
	{
		AppRenderer = CreateRenderer(AppWindow, 0, .Accelerated);
		CGui.Init(AppRenderer);
	}
}