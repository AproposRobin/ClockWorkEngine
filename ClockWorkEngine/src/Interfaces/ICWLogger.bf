using System;

namespace ClockWorkEngine.CoreMinimal
{
	enum ELogVerbosity
	{
		Trace,
		Debug,
		Info,
		Warning,
		Error,
		Fatal
	}

	interface ICWLogger
	{
		public void Log(StringView Category, ELogVerbosity Verbosity, String Message);
	}
}

