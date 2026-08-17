namespace ClockWorkEngine.Window;

using System;

using ClockWorkEngine.Application;
using SDL3.Raw;

abstract class CWindow
{
	protected CApplication* App;
	protected StringView WindowName;

	public this(CApplication* Application, StringView Name)
	{
		App = Application;
		WindowName = Name;
	}

	public abstract void Init();
	public abstract void Tick();
	public abstract void Shutdown();
}