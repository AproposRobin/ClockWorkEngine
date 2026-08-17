namespace ClockWorkEditor;

using System;
using System.Collections;

using ClockWorkEditor.EditorApplication;
using ClockWorkEngine;
using ClockWorkEngine.Utils;
using TailTrace;
using TailTrace.Loggers;

using static TailTrace.Log;

class ClockWorkEditor
{
	private String ApplicationName;
	private bool bRunning = true;
	private int ExitCode = 0;
	private bool bPIEisActive = false;
	private ClockWorkEngine CEngine;
	private CEditorApplication CApp;

	static public int Main()
	{
		AddLogger(new ConsoleLogger() ..SetLevel(.Trace) ..SetFormat("%l::%x (%o/%a/%y - %t)"));
		let EditorApp = scope ClockWorkEditor();
		EditorApp.Init();
		return EditorApp.Run();
	}

	public void Init()
	{
		Log.Info("Initializing Editor Application");
		CEngine = new ClockWorkEngine();
		if(CEngine == null)
		{
			Log.Error("ClockWorkEngine was not able to be created application will shutdown}");
			ShutdownApplication(1);//<--Engine Creation Failure
		}
		CEngine.Init();
		Log.Info("Engine was created and initialized");
		CApp = new CEditorApplication(CEngine);
		String AppName = scope String();
		StringUtils.ConcatString(AppName, "ClockWork Engine Ver ", CEngine.GetEngineVersion());
		CApp.Init(AppName);
		CApp.SetEditorInstance(this);
	}

	public int Run()
	{
		while(bRunning)
		{
			CApp.Tick();
			if(bPIEisActive)
			{
				CEngine.Tick();
			}
		}
		CApp.Shutdown();
		CEngine.Shutdown();

		delete CApp;
		delete CEngine;
		return ExitCode;
		
	}

	public void ShutdownApplication(int32 ReasonCode)
	{
		ExitCode = ReasonCode;
		bRunning = false;
	}

	public ClockWorkEngine GetEngine() => CEngine;
	public String GetEngineVer() =>CEngine.GetEngineVersion();
}