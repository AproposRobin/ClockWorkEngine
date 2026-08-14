namespace ClockWorkEditor.Window;

using System;

using ClockWorkEditor.Panel;
using ClockWorkEditor.PanelManager;
using ClockWorkEditor.EditorUtils;
using ClockWorkEditor.Gui;
using ClockWorkEditor.Renderer;

class ClockWorkWindow
{
	private ClockWorkEditor CWEditor;
	private ClockWorkGui CGui = new .() ~ delete _;
	private ClockWorkRenderer CRend = new .() ~ delete _;

	public void Init()
	{
		String AppName = scope String();
		EditorUtils.ConcatString(AppName, "Clockwork Engine Ver ", CWEditor.GetEngineVer());
	}

	public this(ClockWorkEditor Editor)
	{
		CWEditor = Editor;
	}

	public void Shutdown()
	{

	}
}