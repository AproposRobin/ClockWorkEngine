namespace ClockWorkEditor.Gui;

using System;
using ClockWorkEditor.Renderer;
using ClockWorkEditor.Window;
using ClockWorkEditor.PanelManager;
using SDL2;

using static SDL2.SDL;


abstract class CGui
{
	protected ClockWorkEditor CWEditor;
	protected CPanelManager PanelManager = new .() ~ delete _;
	protected Renderer* AppRenderer;
	protected CRenderer OwnerRenderer;
	
	public this(ClockWorkEditor Editor, CRenderer OwningRenderer)
	{
		CWEditor = Editor;
		OwnerRenderer = OwningRenderer;
	}
	
	public virtual void Init(Renderer* InRenderer)
	{
		AppRenderer = InRenderer;
	}

	public virtual void Draw()
	{
		PanelManager.DrawActivePanels();
	}


	public abstract void Shutdown();
}