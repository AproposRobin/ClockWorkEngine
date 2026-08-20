using System;
using System.Threading;
using System.Collections;
using System.Diagnostics;

using ClockWorkEngine.CoreMinimal;
using ClockWorkEngine.ModuleManager;
using ClockWorkEngine.Module;

namespace ClockWorkEngine
{
	class ClockWorkEngine
	{
		private String EngVer = "0.0.1";
		private double DeltaTime = 0.0;
		private double LastTime;
		private Stopwatch Watch = new Stopwatch() ~ delete _;
		private CModuleManager ModuleManager = new .(this) ~ delete _;
		private bool bIsActiveSim = false;
		

		//Public Functions
		public void Init()
		{
			RegisterModules();
			ModuleManager.StartupAllModules();
			Watch.Start();
			LastTime = Watch.Elapsed.TotalSeconds;
			CLogger log = (CLogger)GetModule("CLogger");
			log.DeclareLogCategory("ClockWorkEngine");
			CW_LOG("ClockWorkEngine", .Info, "Working");
		}

		public void Shutdown()
		{
			ModuleManager.ShutdownAllModules();
		}

		public void Tick()
		{
			double Now = Watch.Elapsed.TotalSeconds;
			DeltaTime = Now - LastTime;
			LastTime = Now;
			EngineTick(float(DeltaTime));
		}

		private void RegisterModules()
		{
			RegisterModule(new CLogger());
			RegisterModule(new CTypeRegistery());
			RegisterModule(new CWindowEvent());
		}

		public CModule GetModule(StringView ModuleName)
		{
			return ModuleManager.GetModule(ModuleName);
		}

		public String GetEngineVersion() => EngVer;

		public void RegisterModule(CModule Module) => ModuleManager.RegisterModule(Module);

		public bool IsSimActive() => bIsActiveSim;

		//Private Functions 

		private void EngineTick(float DeltaTime)
		{
			ModuleManager.TickModules(DeltaTime);
		}
	}
}



