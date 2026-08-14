namespace ClockWorkEditor;

using System;
using ClockWorkEngine;
using ClockWorkEditor.Window;


class ClockWorkEditor
{
	private bool bRunning = true;
	private int ExitCode = 0;
	private ClockWorkEngine CEngine;
	private ClockWorkWindow CWindow;
	
	static public int Main()
	{
		let EditorApp = new ClockWorkEditor();
		defer delete EditorApp;
		EditorApp.Init();
		return EditorApp.Run();
	}

	public void Init()
	{
		CEngine = new ClockWorkEngine();
		CWindow = new ClockWorkWindow(this);

		CEngine.Init();
		CWindow.Init();
	}

	public int Run()
	{
		while(bRunning)
		{

		}
		CEngine.Shutdown();
		delete CEngine;
		CWindow.Shutdown();
		delete CWindow;
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