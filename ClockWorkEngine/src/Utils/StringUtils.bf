namespace ClockWorkEngine.Utils;

using System;

class StringUtils
{
	public static void ConcatString(String OutStr, params Object[] values)
	{
		for(let Str in values)
			OutStr.Append(Str);
	}

}