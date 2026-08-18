namespace ClockWorkEngine.Utils;

using System;

class StringUtils
{
	public static void ConcatString(String OutStr, params Object[] Values)
	{
		for(let Str in ref Values)
			OutStr.Append(Str);
	}

}