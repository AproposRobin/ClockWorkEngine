using System;
using System.Collections;

using ClockWorkEngine.CoreMinimal;

using ClockWorkEngine.Window;
using ClockWorkEngine.WindowEvents;
using SDL3.Raw;

namespace ClockWorkEngine.Application
{
	abstract class CApplication
	{
		protected CWindow PrimaryWindow;
		protected Dictionary<StringView, CWindow> Windows = new .() ~ DeleteDictionaryAndValues!(_);
		protected ClockWorkEngine CEngine;
		protected StringView AppName;
		protected StringView AppDebugCat = "ClockWorkApplication";

		private int32 ExitCode = 0;
		private bool bRunning = true;
		private delegate void(int32) CloseCallback;

		public this(ClockWorkEngine Engine)
		{
			CEngine = Engine;
			CW_DECLARELOGCATEGORY(AppDebugCat);
			if(!SDL_Init(.SDL_INIT_EVENTS | .SDL_INIT_VIDEO))
			{
				CW_LOG(AppDebugCat, .Error, "Failed to initialize SDL, application will shutdown");
				Exit(2);
			}

			let EventMod = (ICWindowEvent)CEngine.GetModule("CWindowEvent");
			if(EventMod == null)
			{
				CW_LOG(AppDebugCat, .Error, "Unable to retrieve Window Event Module application shutting down");
				Exit(3);
				return;
			}
			CloseCallback = new => Exit;
			EventMod.BindOnCloseDelegate(CloseCallback);
			CW_LOG(AppDebugCat, .Info, "Application has finished initialization");
		}

		protected int32 StartApplication()
		{
			while(bRunning)
			{
				//Need to setup a couple of threads GlobalIlluminationThread, GameThread, PhysicsThread, UIRenderThread, AnimationThread. There may be more later but generally these are the biggest concerns.
				CEngine.Tick();
			}
			return ExitCode;
		}

		protected void SetupPrimaryWindow<T>(StringView WindowName) where T : CWindow
		{
			PrimaryWindow = new T(WindowName);
			PrimaryWindow.CreatePrimaryWindow();
			PrimaryWindow.Init();
		}

		public void Exit(int32 ExitReason)
		{
			if(PrimaryWindow != null)
			{
				PrimaryWindow.Shutdown();
				delete PrimaryWindow;
			}
			CEngine.Shutdown();
			delete CloseCallback;
			ExitCode = ExitReason;
			bRunning = false;
		}

		public CWindow GetPrimaryWindow() => PrimaryWindow;
		public abstract void Init(StringView ApplicationName);
		public abstract int32 Run();
		
		public abstract void Shutdown();
		public abstract void OnWindowEvent(SDL_Event* Event);
		
	}
}
