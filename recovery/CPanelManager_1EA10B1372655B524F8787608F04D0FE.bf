namespace ClockWorkEngine.Core.Application.PanelManager;

using System;
using System.Collections;

using ClockWorkEngine.Core.Application.Panel;

class CPanelManager
{
	private Dictionary<StringView, CPanel> Panels = new .() ~ delete _;
	private ClockWorkApplication App;

	public this(ClockWorkApplication EngineApplication)
	{
		App = EngineApplication;
	}

	public void RegisterPanel(CPanel Panel)
	{

	}

	public void StartupPanels()
	{

	}

	public void ShutdownPanels()
	{

	}

	public void DrawActivePanels()
	{

	}
}