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
	/**
	DataTypes
	*/
	//Vectors & Transforms

	struct CVector2D : this(float X, float Y);

	struct CVector3D : this(float X, float Y, float Z);

	struct CRotator : this(float Pitch, float Yaw, float Roll);

	struct CTransform : this(CVector3D Location, CRotator Rotation, CVector3D Scale);

	static
	{
		public static delegate void(StringView Category, ELogVerbosity Verbosity, String Message) LogMessage = null;

		public static void ConcatString(String OutStr, params Object[] Values)
		{
			for(let Str in ref Values)
				OutStr.Append(Str);
		}

		public static void CW_LOG(StringView Category, ELogVerbosity Verbosity, String Message)
		{
			if(LogMessage != null)
			{
				LogMessage(Category, Verbosity, Message);
			}
		}

		public static void CW_DECLARELOGCATEGORY(StringView Category){}
		public static void CW_DECLARELOGCATEGORIES(params StringView[] Categories){}
	}
}
