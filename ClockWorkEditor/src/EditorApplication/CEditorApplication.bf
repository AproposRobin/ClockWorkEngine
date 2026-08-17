namespace ClockWorkEditor.EditorApplication;

using ClockWorkEngine.Application;
using System;
using System.Collections;

using SDL3.Raw;

class CEditorApplication : CApplication
{
	private ClockWorkEditor CEditor;
	public this(ClockWorkEngine.ClockWorkEngine Engine) : base(Engine){}

	public override void Init(StringView ApplicationName)
	{
		CreateWindow(ApplicationName);
	}

	public void SetEditorInstance(ClockWorkEditor ClockWorkEditor)
	{
		CEditor = ClockWorkEditor;
	}

	public override void Tick()
	{
		SDL_SetRenderDrawColor(AppRenderer, 0, 0, 0, 255);
		SDL_RenderClear(AppRenderer);
		PollEvents();

		SDL_RenderPresent(AppRenderer);
	}

	public override void Exit(int32 ExitReason)
	{
		CEditor.ShutdownApplication(ExitReason);
	}

	public override void Shutdown()
	{

	}
}