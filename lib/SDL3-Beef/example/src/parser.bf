namespace example;

using System;
using System.IO;

class Parser
{
	/*
		This is for internal use and binding creation
	*/
	public static void Parse()
	{
		for(var f in Directory.EnumerateFiles("path to header file"))
		{
			Console.WriteLine("");
			Console.WriteLine(f.GetFilePath(.. scope .()));
			var t = File.ReadAllText(scope $"{f.GetFilePath(.. scope .())}", .. scope .());
			for(var line in t.Split('\n'))
			{
				if(line.StartsWith("extern SDL_DECLSPEC"))
				{
					String nl = scope .(line);
					nl.Remove(0, "extern SDL_DECLSPEC".Length);
					nl.Replace("SDLCALL ", "");

					/*
					String sdlident = scope .(nl.Substring(
						nl.IndexOf(" SDL_")+1,
						nl.IndexOf("(")-nl.IndexOf(" SDL_")-1
						));

					if(sdlident.Contains(' '))
						sdlident = scope:: .(sdlident.Substring(sdlident.LastIndexOf(' ')));
					*/

					while(nl.Contains(" *"))
						nl.Replace(" *", "* ");

					//nl.Replace("SDL_", "");
					nl.Replace("(void)", "()");
					Console.WriteLine(scope $"""
							public static extern{nl}

						""");

				}
			}
		}
		Console.ReadLine(.. scope .());
	}
}