

using ClockWorkEngine.Window;
using System;
using System.Collections;

using SDL3.Raw;
using TailTrace;

namespace ClockWorkEngine.Application
{
	abstract class CApplication
	{
		protected CWindow PrimaryWindow;
		protected List<CWindow> Windows = new .() ~ DeleteContainerAndItems!(_);
		protected ClockWorkEngine CEngine;
		protected StringView AppName;

		private int32 ExitCode = 0;
		private bool bRunning = true;

		public this(ClockWorkEngine Engine)
		{
			CEngine = Engine;
			if(!SDL_Init(.SDL_INIT_EVENTS | .SDL_INIT_VIDEO))
			{
				Log.Error("Failed to initialize SDL, application will shutdown");
				Exit(2);//<--Exit code 2 SDL initialization failure
			}
		}

		protected int32 StartApplication()
		{
			while(bRunning)
			{
				if(CEngine.IsActive())
				{
					CEngine.Tick();
				}
			}
			return ExitCode;
		}

		protected void SetupPrimaryWindow<T>(StringView WindowName) where T : CWindow
		{
			PrimaryWindow = new T(WindowName);
			PrimaryWindow.CreatePrimaryWindow();
			PrimaryWindow.Init();
		}

		protected void Exit(int32 ExitReason)
		{
			if(PrimaryWindow != null)
			{
				delete PrimaryWindow;
			}
		}

		public abstract void Init(StringView ApplicationName);
		public abstract int32 Run();
		
		public abstract void Shutdown();
		public abstract void OnWindowEvent(SDL_Event* Event);
		
	}
}
