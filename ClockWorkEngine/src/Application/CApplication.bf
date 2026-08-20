using System;
using System.Collections;

using ClockWorkEngine.Window;
using SDL3.Raw;

namespace ClockWorkEngine.Application
{
	abstract class CApplication
	{
		protected CWindow PrimaryWindow;
		protected Dictionary<StringView, CWindow> Windows = new .() ~ DeleteDictionaryAndValues!(_);
		protected ClockWorkEngine CEngine;
		protected StringView AppName;

		private int32 ExitCode = 0;
		private bool bRunning = true;

		public this(ClockWorkEngine Engine)
		{
			CEngine = Engine;
			if(!SDL_Init(.SDL_INIT_EVENTS | .SDL_INIT_VIDEO))
			{
				Console.WriteLine("Failed to initialize SDL, application will shutdown");
				Exit(2);//<--Exit code 2 SDL initialization failure
			}
		}

		protected int32 StartApplication()
		{
			while(bRunning)
			{
				//Need to setup a couple of threads GlobalIlluminationThread, GameThread, PhysicsThread, UIRenderThread, AnimationThread. There may be more later but generally these are the biggest concerns.
				if(CEngine.IsSimActive())
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
			PrimaryWindow.Shutdown();
			delete PrimaryWindow;
			CEngine.Shutdown();
		}

		public CWindow GetPrimaryWindow() => PrimaryWindow;
		public abstract void Init(StringView ApplicationName);
		public abstract int32 Run();
		
		public abstract void Shutdown();
		public abstract void OnWindowEvent(SDL_Event* Event);
		
	}
}
