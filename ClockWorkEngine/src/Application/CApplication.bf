namespace ClockWorkEngine.Application;

using ClockWorkEngine.Window;
using System;
using System.Collections;

abstract class CApplication
{
	protected List<CWindow*> Windows;
	protected ClockWorkEngine* CEngine;
	protected StringView AppName;

	public this(ClockWorkEngine* Engine)
	{
		CEngine = Engine;
	}

	public abstract void Init(StringView ApplicationName);
	public abstract void Tick();
	public abstract void Exit(int32 ExitReason);
	public abstract void Shutdown();
}