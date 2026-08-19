using System;
using System.Collections;

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
		public void DeclareLogCategory(StringView Category);
		public void DeclareLogCategories(params StringView[] Categories);
	}
}

