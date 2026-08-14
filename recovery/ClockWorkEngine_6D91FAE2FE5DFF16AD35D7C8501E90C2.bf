namespace ClockWorkEngine.Core;

using System;
using System.Collections;
using System.Diagnostics;

using ClockWorkEngine.Core.ModuleManager;
using ClockWorkEngine.Core.Application;
using ClockWorkEngine.Module;
using ClockWorkEngine.Modules;


class ClockWorkEngine
{
	private String EngVer = "0.0.1";
	private int ExitCode = 0;
	private bool bRunning = true;
	private double DeltaTime = 0.0;
	private Stopwatch Watch = new Stopwatch() ~ delete _;
	private CModuleManager ModuleManager = new .(this) ~ delete _;
	private ClockWorkApplication App = new .(this) ~ delete _;

	//Public Functions

	public int Run()
	{
		Watch.Start();
		double LastTime = Watch.Elapsed.TotalSeconds;
		while(bRunning)
		{
			double Now = Watch.Elapsed.TotalSeconds;
			DeltaTime = Now - LastTime;
			LastTime = Now;
			Tick(float(DeltaTime));
		}
		ModuleManager.ShutdownAllModules();
		return ExitCode;
	}

	public void ForceClose(int InExitCode)
	{
		ExitCode = InExitCode;
		bRunning = false;
	}

	public void RequestClose()
	{
		bRunning = false;
	}

	public void Init()
	{
		RegisterModules();
		App.Init();
		ModuleManager.StartupAllModules();
	}

	public void RegisterModules()
	{
		RegisterModule(new CWindow());
	}

	public CModule GetModule(StringView ModuleName)
	{
		return ModuleManager.GetModule(ModuleName);
	}

	public String GetEngineVersion() => EngVer;
	public ClockWorkApplication GetApplication() => App;

	//Private Functions 

	private void RegisterModule(CModule Module) => ModuleManager.RegisterModule(Module);

	private void Tick(float DeltaTime)
	{
		ModuleManager.TickModules(DeltaTime);
	}
}