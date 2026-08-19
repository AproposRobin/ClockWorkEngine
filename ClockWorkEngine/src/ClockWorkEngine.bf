using System;
using System.Threading;
using System.Collections;
using System.Diagnostics;

using ClockWorkEngine.CoreMinimal;
using ClockWorkEngine.ModuleManager;
using ClockWorkEngine.Module;
using ClockWorkEngine.Module.TypeRegister;
using ClockWorkEngine.Module.Logger;

namespace ClockWorkEngine
{
	class ClockWorkEngine
	{
		private String EngVer = "0.0.1";
		private double DeltaTime = 0.0;
		private double LastTime;
		private Stopwatch Watch = new Stopwatch() ~ delete _;
		private CModuleManager ModuleManager = new .(this) ~ delete _;
		private static CoreMinimal CMinimal = new .() ~ delete _;

		//Public Functions

		public void Tick()
		{
			double Now = Watch.Elapsed.TotalSeconds;
			DeltaTime = Now - LastTime;
			LastTime = Now;
			EngineTick(float(DeltaTime));
			Console.WriteLine(DeltaTime);
		}

		public void Init()
		{
			RegisterModules();
			CMinimal.InitCoreMinimal(this);
			ModuleManager.StartupAllModules();
			Watch.Start();
			LastTime = Watch.Elapsed.TotalSeconds;
		}

		public void Shutdown()
		{
			ModuleManager.ShutdownAllModules();
		}

		private void RegisterModules()
		{
			RegisterModule(new CTypeRegistery());
			RegisterModule(new CLogger());
		}

		public CModule GetModule(StringView ModuleName)
		{
			return ModuleManager.GetModule(ModuleName);
		}

		public String GetEngineVersion() => EngVer;

		public void RegisterModule(CModule Module) => ModuleManager.RegisterModule(Module);

		//Private Functions 

		

		private void EngineTick(float DeltaTime)
		{
			ModuleManager.TickModules(DeltaTime);
		}
	}
}



