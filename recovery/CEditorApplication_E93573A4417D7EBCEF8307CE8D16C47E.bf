namespace ClockWorkEditor.EditorWindow;

using ClockWorkEngine.Application;
using System;
using System.Collections;


class CEditorApplication : CApplication
{
	public this(ClockWorkEngine.ClockWorkEngine* Engine) : base(Engine)
	{

	}

	public override void Init(StringView ApplicationName)
	{

	}

	public override int32 Run()
	{
		return default;
	}

	public override void Exit(int32 ExitReason)
	{

	}
}