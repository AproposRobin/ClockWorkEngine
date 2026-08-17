namespace ClockWorkEditor;

using System;
using System.Collections;

using ClockWorkEditor.EditorApplication;
using ClockWorkEngine;
using ClockWorkEngine.Utils;


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
		CEngine.Init();
		CApp = new CEditorApplication(&CEngine);
		String AppName = scope String();
		StringUtils.ConcatString(AppName, "ClockWork Engine Ver ", CEngine.GetEngineVersion());
		CApp.Init(AppName);
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
		return 0;
	}

	public void ShutdownApplication(int32 ReasonCode)
	{
		ExitCode = ReasonCode;
		bRunning = false;
	}

	public ClockWorkEngine GetEngine() => CEngine;
	public String GetEngineVer() =>CEngine.GetEngineVersion();
}