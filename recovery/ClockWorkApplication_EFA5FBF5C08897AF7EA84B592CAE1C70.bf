namespace ClockWorkEditor;

using ClockWorkEngine.Core;
using ClockWorkEngine.Core.Application.PanelManager;
using ClockWorkEngine.Core.Application.Panel;

class ClockWorkApplication
{
	private CPanelManager PanelManager = new .(this) ~ delete _;
	private ClockWorkEngine CEngine {get; private set;}

	public this(ClockWorkEngine GameEngine)
	{
		CEngine = GameEngine;
	}

	public void Init()
	{
		RegisterPanels();
	}

	private void RegisterPanels()
	{

	}

	public void RegisterPanel(CPanel Panel)
	{
		PanelManager.RegisterPanel(Panel);
	}

	public void Draw()
	{
		PanelManager.DrawActivePanels();
	}

	public void Shutdown()
	{
		PanelManager.ShutdownPanels();
	}
}