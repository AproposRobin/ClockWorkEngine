namespace ClockWorkEditor.Gui;

using System;
using ClockWorkEditor.Window;
using ClockWorkEditor.PanelManager;
using SDL2;

using static SDL2.SDL;


class ClockWorkGui
{
	private ClockWorkEditor CWEditor;
	private CPanelManager PanelManager = new .() ~ delete _;
	private Renderer* AppRenderer;
	
	public this(ClockWorkEditor Editor)
	{
		
	}
	
	public void Init(Renderer* InRenderer)
	{
		AppRenderer = InRenderer;
	}

	public void Draw()
	{
		SetRenderDrawColor(AppRenderer, 255, 255, 255, 255);
		Rect rect = .(0, 0, 500, 500);
		RenderFillRect(AppRenderer, &rect);
		RenderDrawRect(AppRenderer, &rect);
	}

	public void Shutdown()
	{
		
	}
}