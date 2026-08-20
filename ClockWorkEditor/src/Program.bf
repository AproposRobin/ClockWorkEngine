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
			ClockWorkEngine CEngine = scope ClockWorkEngine();
			CEngine.Init();
			TestProgram TP = scope TestProgram(CEngine);
			let AppName = scope String();
			ConcatString(AppName, "ClockWork Engine Ver ", CEngine.GetEngineVersion());
			TP.Init(AppName);
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

		}
	}

	class TestWindow : CWindow
	{

		public this(StringView Name) : base(Name){}

		public override void Init()
		{

		}

		public override void Shutdown()
		{

		}

		public override void Tick()
		{

		}

		public override void DrawUI()
		{

		}
		
	}
}