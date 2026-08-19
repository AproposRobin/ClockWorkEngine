namespace ClockWorkEditor.EditorApplication;

using ClockWorkEngine.Application;
using ClockWorkEditor.EditorWindow;
using System;
using System.Collections;

using SDL3.Raw;

class CEditorApplication : CApplication
{
	private ClockWorkEditor CEditor;
	public this(ClockWorkEngine.ClockWorkEngine Engine) : base(Engine)
	{
		
	}

	public override void Init(StringView ApplicationName)
	{
		Windows.Add(new CEditorWindow(this, ApplicationName));
		for(let Win in ref Windows)
		{
			Win.Init();
		}
	}

	public void SetEditorInstance(ClockWorkEditor ClockWorkEditor)
	{
		CEditor = ClockWorkEditor;
	}

	public override void Tick()
	{
		for(let Win in ref Windows)
			Win.Tick();
	}

	public override void Exit(int32 ExitReason)
	{
		CEditor.ShutdownApplication(ExitReason);
	}

	public override void Shutdown()
	{
		for(let Win in ref Windows)
			Win.Shutdown();
	}
}