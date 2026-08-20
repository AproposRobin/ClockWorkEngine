using System;

using ClockWorkEngine;
using ClockWorkEngine.CoreMinimal;
using ClockWorkEngine.Application;
using ClockWorkEngine.Window;


namespace ClockWorkEditor
{
	class Program
	{
		public static int32 Main()
		{
			ClockWorkEngine CEngine = new ClockWorkEngine();
			CEngine.Init();
			TestProgram TP = new TestProgram(CEngine);
			let AppName = scope String();
			ConcatString(AppName, "ClockWork Engine Ver ", CEngine.GetEngineVersion());
			TP.Init(AppName);
			defer delete CEngine;
			defer delete TP;
			return TP.Run();
		}
	}

	class TestProgram : CApplication
	{

		public this(ClockWorkEngine.ClockWorkEngine Engine) : base(Engine)
		{

		}

		public override void Init(System.StringView ApplicationName)
		{
			SetupPrimaryWindow<TestWindow>(ApplicationName);
		}

		public override int32 Run()
		{
			return StartApplication();
		}

		public override void OnWindowEvent(SDL3.Raw.SDL_Event* Event)
		{

		}

		public override void Shutdown()
		{
			PrimaryWindow.Shutdown();
		}
	}

	
	using SDL3.Raw;
	class TestWindow : CWindow
	{

		public this(StringView Name) : base(Name){}

		public override void Init()
		{
			
		}

		public override void Shutdown()
		{
			SDL_DestroyWindow(AppWindow);
			SDL_DestroyRenderer(AppRenderer);
		}

		public override void Tick()
		{

		}

		public override void DrawUI()
		{

		}
		
	}
}