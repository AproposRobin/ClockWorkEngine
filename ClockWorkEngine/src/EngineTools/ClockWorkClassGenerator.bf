using System;
using System.Collections;

namespace ClockWorkEngine.Tools
{
	class ClockWorkClassGenerator : Compiler.Generator
	{
		public override String Name => "ClockWork Class";

		public override void InitUI()
		{
			AddCombo("ClockWorkClasses", "Class Type", "", StringView[?]("Base", "l--Entity", "l--Component", "l--UI"));
			AddEdit("Name", "Class Name", "");
			AddCheckbox("bIsGraphable", "Graph Compatible", false);
		}

		public override void Generate(String outFileName, String outText, ref Flags generateFlags)
		{
			let FileName = mParams["Name"];

			outFileName.Append(FileName);

			let Classtype = mParams["ClockWorkClasses"];

			if(Classtype == "Base")
			{
				outText.AppendF(
					$"""
					using ClockWorkEngine.CoreMinimal;

					namespace {Namespace}
					{{
						class {FileName}
						{{
						}}
					}}
					""");
			}


		}
	}
}

