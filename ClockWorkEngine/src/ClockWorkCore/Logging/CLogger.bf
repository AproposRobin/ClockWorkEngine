using System;
using System.Collections;

using ClockWorkEngine.Module;
using ClockWorkEngine.CoreMinimal;

using TailTrace;
using TailTrace.Loggers;

/**
This is the main Logger Module, it is likely I will position to making my own custom logger later in the future so the back-end will need to be completely agnostic in design.
Primary use case for the logger should only be limited logging for run-time builds for things like crash reports, and general logs for things like servers.
Editor logging needs to be broken into 2 separate types CORE and CLIENT, the core will always be present in the editor build, clients should be able to plug into the logger to handle there own logging information.
Another thing to take a look at is making the logger run on a separate thread altogether and decouple it from the engine itself.
*/
namespace ClockWorkEngine.Module
{
	struct SLogCategoryInfo : this(String Log, bool bShow);

	class CLogger : CModule 
	{
		static private Dictionary<StringView, bool> LogCategories = new .() ~ delete(_);
		static private Dictionary<StringView, SLogCategoryInfo> Logs = new .() ~ delete(_);

		public this()
		{
			Log.AddLogger(new ConsoleLogger() ..SetLevel(.Trace) ..SetFormat("[%l] %o/%a/%y %x"));
			LogMessage = new => CLog;
		}

		public ~ this()
		{
			LogMessage = null;
		}


		public override System.StringView GetModuleName()
		{
			return "CLogger";
		}

		public override void StartupModule()
		{
			
		}

		public override void ShutdownModule()
		{
			LogCategories.Clear();
			Logs.Clear();
		}

		public void CLog(StringView LogCategory, ELogVerbosity Verbosity, String LogMessage)
		{
			StringView Category = scope String();

			if(!LogCategories.ContainsKey(LogCategory))
			{
				//We don't have the define category we are going to seperate it into an undefined log
				Category = "Undefined";
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

		public void DeclareLogCategories(params StringView[] Values)
		{
			for(let Cat in ref Values)
			{
				if(!LogCategories.ContainsKey(Cat))
					LogCategories.Add(Cat, true);//<--All Declared log categories will always be default shown true, only saved serialization passes or in application toggles will shut them off
			}
		}

		public void DeclareLogCategory(StringView Category)
		{
			if(!LogCategories.ContainsKey(Category))
				LogCategories.Add(Category, true);
		}

		//Currently without the primary window these are not in use but are in place for when the application does get its logger window
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
}

