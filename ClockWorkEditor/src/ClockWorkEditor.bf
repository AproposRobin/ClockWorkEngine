namespace ClockWorkEditor;

using System;
using System.Collections;

using ClockWorkEditor.EditorApplication;
using ClockWorkEngine;
using ClockWorkEngine.Utils;
using ClockWorkEngine.CoreMinimal;

using static ClockWorkEngine.Utils.StringUtils;

//This class should be considered early and will most likely be removed at later builds, instead there should be a general EntryPoint class defined in the engine that starts the application

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
		let EditorApp = scope ClockWorkEditor();
		EditorApp.Init();
		return EditorApp.Run();
	}

	public void Init()
	{
		CEngine = new ClockWorkEngine();
		if(CEngine == null)
		{
			ShutdownApplication(1);//<--Engine Creation Failure
		}
		CEngine.Init();
		CApp = new CEditorApplication(CEngine);
		if(CApp == null)
		{
			
		}
		CoreMinimal.CW_LOG("", .Info, "We Are Starting Up");
		String AppName = scope String();
		ConcatString(AppName, "ClockWork Engine Ver ", CEngine.GetEngineVersion());
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