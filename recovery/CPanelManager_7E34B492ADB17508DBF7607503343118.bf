namespace ClockWorkEditor.PanelManager;

using System;
using System.Collections;

using ClockWorkEditor.Panel;


class CPanelManager
{
	private Dictionary<StringView, CPanel> Panels = new .() ~ delete _;
	private List<CPanel> ActivePanels = new .() ~ delete _;


	public this()
	{
		
	}

	public void RegisterPanel(CPanel Panel)
	{
		if (Panel == null)
			return;

		Panels[Panel.GetPanelName()] = Panel;
	}

	public void StartupPanels()
	{
		for (let Panel in Panels.Values)
			Panel.Init();
	}

	public void ShutdownPanels()
	{
		for(let Pan in Panels.Values)
		{
			Pan.Shutdown();
			delete Pan;
		}
	}

	public void ActivatePanel(StringView Name)
	{
		if (Panels.TryGetValue(Name, let Panel))
			if (!ActivePanels.Contains(Panel))
				ActivePanels.Add(Panel);
	}

	public void DeactivatePanel(StringView Name)
	{
		if (Panels.TryGetValue(Name, let Panel))
			ActivePanels.Remove(Panel);
	}

	public void DrawActivePanels()
	{
		for(let Pan in ActivePanels)
		{
			Pan.Draw();
		}	
	}
}