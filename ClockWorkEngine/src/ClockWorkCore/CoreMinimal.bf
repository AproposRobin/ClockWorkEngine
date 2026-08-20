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
		public static delegate void(StringView Category, ELogVerbosity Verbosity, String Message) CW_LOG = null;
		public static delegate void(StringView Category) CW_DECLARELOGCATEGORY = null;
		public static delegate void(params StringView[] Categories) CW_DECLARELOGCATEGORIES = null;

		public static void ConcatString(String OutStr, params Object[] Values)
		{
			for(let Str in ref Values)
				OutStr.Append(Str);
		}
	}
}
