namespace ClockWorkEngine.Module.Logger;

using ClockWorkEngine.Module;


using System;
using System.Collections;

using TailTrace;

using static ClockWorkEngine.Utils.StringUtils;

enum ELogVerbosity
{
	Trace,
	Debug,
	Info,
	Warning,
	Error
}

struct SLogCategoryInfo
{
	private String Log;
	private bool bShow = true;
}

class CLogger : CModule
{
	static private List<StringView> LogCategories;
	static private Dictionary<StringView, SLogCategoryInfo> Logs;


	public override System.StringView GetModuleName()
	{
		return "CLogger";
	}

	public override void StartupModule()
	{
		DeclareLogCategory("ClockWorkEngine","ClockWorkEditor","ClockWorkApplication","ClockWorkWindow","ClockWorkModule","ClockWorkUI");
	}

	public override void ShutdownModule()
	{
		LogCategories.Clear();
		Logs.Clear();
	}

	public void CW_Log(StringView LogCategory, ELogVerbosity Verbosity, String LogMessage)
	{
		StringView Category = scope String();

		if(!LogCategories.Contains(LogCategory))
		{
			//We don't have the define category we are going to seperate it into an undefined log
			Category = "Undefined";
			return;
		}
		else
		{
			Category = LogCategory;
		}

		let DebugString = scope String();
		ConcatString(DebugString, Category, ": ", LogMessage);
		switch(Verbosity)
		{
		case .Trace:
			Log.Trace(DebugString);
			break;

		case .Debug:
			Log.Debug(DebugString);
			break;

		case .Info:
			Log.Info(DebugString);
			break;

		case .Warning:
			Log.Warning(DebugString);
			break;

		case .Error:
			Log.Error(DebugString);
			break;

		default:
			Log.Info(DebugString);
			break;
		}
	}

	public void DeclareLogCategory(params Object[] Values)
	{
		for(let Cat in ref Values)
		{
			if(!LogCategories.Contains((StringView)Cat))
				LogCategories.Add((StringView)Cat);
		}
	}

}