namespace ClockWorkEditor.PanelManager;

using System;
using System.Collections;

using ClockWorkEditor.Window;
using ClockWorkEditor.Panel;


class CPanelManager
{
	private Dictionary<StringView, CPanel> Panels = new .() ~ delete _;
	private List<CPanel> ActivePanels = new .() ~ delete _;
	private ClockWorkWindow CWWindow;

	public this(ClockWorkWindow Window)
	{
		CWWindow = Window;
	}

	public void RegisterPanel(CPanel Panel)
	{

	}

	public void StartupPanels()
	{

	}

	public void ShutdownPanels()
	{
		for(let Pan in Panels.Values)
			delete Pan;
	}

	public void DrawActivePanels()
	{
		for(let Pan in ActivePanels)
		{
			//Draw function for individual panels
		}	
	}
}