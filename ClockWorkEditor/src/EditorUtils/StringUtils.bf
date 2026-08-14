namespace ClockWorkEditor.EditorUtils;

using System;

class EditorUtils
{
	public static void ConcatString(String OutStr, params Object[] values)
 	{
		 for(let Str in values)
			 OutStr.Append(Str);
	}
}