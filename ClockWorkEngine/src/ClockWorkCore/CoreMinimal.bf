using System;
using System.Threading;

namespace ClockWorkEngine.CoreMinimal
{
	class CoreMinimal
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
		public static void CW_LOG(StringView Category, ELogVerbosity Verbosity, String Message) => Logger.Log(Category, Verbosity, Message);
		public static void CW_DECLARELOGCATEGORY(StringView Category) => Logger.DeclareLogCategory(Category);
		public static void CW_DECLARELOGCATEGORIES(params StringView[] Categories) => Logger.DeclareLogCategories(params Categories);
		#endif
	}
}
