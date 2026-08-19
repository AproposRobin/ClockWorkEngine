using System;
using System.Collections;
using ClockWorkEngine.CoreMinimal;

namespace ClockWorkEngine.Module
{
	struct SCeTypeFields : this(Dictionary<StringView, Type> Fields);

	struct SCeTypeInfo : this(Type Type, StringView DisplayName, SCeTypeFields Fields);


	class CTypeRegistery : CModule
	{
		private Dictionary<Type, SCeTypeInfo> Types = new .() ~ delete _;

		public override System.StringView GetModuleName()
		{
			return "CTypeRegistery";
		}

		public override void StartupModule()
		{
			RegisterType<CVector2D>("Vector2D", .(new .() {("X", typeof(float)),("Y", typeof(float))}));
			RegisterType<CVector3D>("Vector3D", .(new .() {("X", typeof(float)),("Y", typeof(float)),("Z", typeof(float))}));
			RegisterType<CRotator>("Rotation", .(new .() {("Pitch", typeof(float)),("Yaw", typeof(float)),("Roll", typeof(float))}));
			RegisterType<CTransform>("Transform", .(new .() {("Location", typeof(CVector3D)),("Rotation", typeof(CRotator)),("Scale", typeof(CVector3D))}));
		}

		public void RegisterType<T>(StringView DisplayName, SCeTypeFields Fields)
		{
			Types[typeof(T)] = .(typeof(T), DisplayName, Fields);
		}

		public SCeTypeInfo GetTypeInfo(Type Type)
		{
			return Types[Type];
		}

		public override void ShutdownModule()
		{
			for(let Types in ref Types.Values)
			{
				delete Types.Fields.Fields;
			}
			Types.Clear();
		}
	}
}

