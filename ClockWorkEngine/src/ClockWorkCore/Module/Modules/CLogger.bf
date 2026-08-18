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

struct SLogCategoryInfo : this(String Log, bool bShow);

class CLogger : CModule
{
	static private Dictionary<StringView, bool> LogCategories = new .() ~ delete(_);
	static private Dictionary<StringView, SLogCategoryInfo> Logs = new .() ~ delete(_);


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

		if(LogCategories.ContainsKey(LogCategory))
		{
			//We don't have the define category we are going to seperate it into an undefined log
			Category = "Undefined";
			return;
		}
		else
		{
			Category = LogCategory;
		}

		let LogString = scope String();
		ConcatString(LogString, Category, ": ", LogMessage);
		switch(Verbosity)
		{
		case .Trace:
			Log.Trace(LogString);
			break;

		case .Debug:
			Log.Debug(LogString);
			break;

		case .Info:
			Log.Info(LogString);
			break;

		case .Warning:
			Log.Warning(LogString);
			break;

		case .Error:
			Log.Error(LogString);
			break;

		default:
			Log.Info(LogString);
			break;
		}
		Logs.Add(Category, .(LogString, ShouldShowCategory(Category)));
	}

	public void DeclareLogCategory(params StringView[] Values)
	{
		for(let Cat in ref Values)
		{
			if(!LogCategories.ContainsKey(Cat))
				LogCategories.Add(Cat, true);//<--All Declared log categories will always be default shown true, only saved serialization passes or in application toggles will shut them off
		}
	}

	private bool ShouldShowCategory(StringView Category)
	{
		return LogCategories.GetValue(Category);
	}

	public void SetShowLogCategory(StringView Category, bool bShow)
	{
		//Only change if the set show is called
		if(LogCategories[Category] != bShow)
		{
			LogCategories[Category] = bShow;
			if(!bShow)
			{
				//Set all the logs as no longer visible
			}
			else
			{
				//Set all the string as visible
			}
		}
	}
}