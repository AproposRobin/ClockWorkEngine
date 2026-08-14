namespace ClockWorkEngine;

using System;

using ClockWorkEngine.Core;
class Main
{
	public static int Main()
	{
		let CEngine = scope ClockWorkEngine();
		CEngine.Init();
		return CEngine.Run();
	}
}