namespace ClockWorkEditor.Panel.ToolBar;

using System;
using ClockWorkEditor.Panel;

using SDL3;

class CToolBarPanel : CPanel
{
	private Renderer* AppRenderer;

	public this(StringView Name, EPanelDock DockLocation, SPanelRect PanelLayout, Renderer* Renderer) : base(Name, DockLocation, PanelLayout)
	{
		AppRenderer = Renderer;
	}

	public override void Init()
	{

	}

	public override void Draw()
	{
		let Layout = GetLayout();
		let ToolbarRect = scope Rect((int32)Layout.X,(int32)Layout.Y,(int32)Layout.Width,(int32)Layout.Height);
		SetRenderDrawColor(AppRenderer, 255, 255, 255, 255);
		RenderFillRect(AppRenderer, ToolbarRect);
	}

	public override void Shutdown()
	{

	}
}