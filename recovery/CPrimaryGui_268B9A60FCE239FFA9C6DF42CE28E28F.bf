namespace ClockWorkEditor.Gui.Primary;

using ClockWorkEditor.Renderer;
using ClockWorkEditor.Gui;
using ClockWorkEditor.Panel.ToolBar;
using SDL2;

using static SDL2.SDL;

class CPrimaryGui : CGui
{
	public this(ClockWorkEditor Editor, CRenderer OwningRenderer) : base(Editor, OwningRenderer){}

	public override void Init(Renderer* InRenderer)
	{
		base.Init(InRenderer);

		int32 Width;
		int32 Height;

		GetWindowSize(OwnerRenderer.GetRendererWindow(), out Width, out Height);
		Height = 20;//<--In this instance we want to reset the size to a desired, this one in particular should be 32 pixels
		PanelManager.RegisterPanel(new CToolBarPanel("EditorToolBar", .Top, .(0, 0, Width, Height), InRenderer));//Need to make the rect properly
		PanelManager.ActivatePanel("EditorToolBar");
	}

	public override void Draw()
	{
		PanelManager.DrawActivePanels();
	}

	public override void Shutdown()
	{
		PanelManager.ShutdownPanels();
	}
}