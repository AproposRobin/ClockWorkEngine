using System;

using ClockWorkEngine.CoreMinimal;




namespace ClockWorkEngine.ClockWorkCore.Logging
{
	class CWLog
	{
		private static ICWLogger Logger;
		private static ClockWorkEngine CEngine;

		public void InitCoreMinimal(ClockWorkEngine Engine)
		{
			CEngine = Engine;

			#if CW_EDITOR || CW_RUNTIME && CW_RUNTIMEDEBUGGER
			Logger = (ICWLogger)CEngine.GetModule("CLogger");//<--Add the logger only if we should
			#endif
		}

		#if CW_EDITOR || CW_RUNTIME && CW_RUNTIMEDEBUGGER
		public static void LOG(StringView Category, ELogVerbosity Verbosity, String Message) => Logger.Log(Category, Verbosity, Message);
		public static void DECLARELOGCATEGORY(StringView Category) => Logger.DeclareLogCategory(Category);
		public static void DECLARELOGCATEGORIES(params StringView[] Categories) => Logger.DeclareLogCategories(params Categories);
		#endif
	}
}

