using System;

namespace ClockWorkEngine.CoreMinimal
{
	class CoreMinimal
	{
		private static ICWLogger Logger;
		private static ClockWorkEngine CEngine;

		public void InitCoreMinimal(ClockWorkEngine Engine)
		{
			CEngine = Engine;
			Logger = (ICWLogger)CEngine.GetModule("CLogger");
		}

		public static void CW_LOG(StringView Category, ELogVerbosity Verbosity, String Message) => Logger.Log(Category, Verbosity, Message);
	}
}
