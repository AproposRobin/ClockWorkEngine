namespace ClockWorkEditor.Panel;

using System;

struct SPanelRect
{
	public float X;
	public float Y;
	public float Width;
	public float Height;

	public this(float X, float Y, float Width, float Height)
	{
		this.X = X;
		this.Y = Y;
		this.Width = Width;
		this.Height = Height;
	}
}

enum EPanelDock
{
	Top,
	Bottom,
	Left,
	Right,
	Center
}

abstract class CPanel
{
	private StringView PanelName;
	private EPanelDock DockLoc;
	private SPanelRect PanLayout;
	protected bool bIsUndockable = false;//<--Inheriting classes should have access to change this

	public this(StringView Name, EPanelDock DockLocation, SPanelRect PanelLayout)
	{
		PanelName = Name;
		DockLoc = DockLocation;
		PanLayout = PanelLayout;
	}

	public abstract void Init();

	public virtual void Draw()
	{

	}

	public abstract void Shutdown();

	public StringView GetPanelName(){return PanelName;}

	public SPanelRect GetLayout()
	{
		return PanLayout;
	}

	public void SetLayout(SPanelRect Layout)
	{
		PanLayout = Layout;
	}
}