namespace ClockWorkEngine;

using System;
using System.Collections;
using System.Diagnostics;

using ClockWorkEngine.Core.ModuleManager;
using ClockWorkEngine.Core.Module;



class ClockWorkEngine
{
	private String EngVer = "0.0.1";
	private bool bRunning = true;
	private double DeltaTime = 0.0;
	private Stopwatch Watch = new Stopwatch() ~ delete _;
	private CModuleManager ModuleManager = new .(this) ~ delete _;

	//Public Functions

	public void Run()
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
	}

	public void Shutdown()
	{
		bRunning = false;
	}

	public void Init()
	{
		RegisterModules();
		ModuleManager.StartupAllModules();
	}

	public void RegisterModules()
	{

	}

	public CModule GetModule(StringView ModuleName)
	{
		return ModuleManager.GetModule(ModuleName);
	}

	public String GetEngineVersion() => EngVer;

	//Private Functions 

	private void RegisterModule(CModule Module) => ModuleManager.RegisterModule(Module);

	private void Tick(float DeltaTime)
	{
		ModuleManager.TickModules(DeltaTime);
	}
}