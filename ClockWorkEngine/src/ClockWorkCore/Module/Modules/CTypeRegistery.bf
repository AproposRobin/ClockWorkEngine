namespace ClockWorkEngine.Module.TypeRegister;

using System;
using System.Collections;
using ClockWorkEngine.CoreMinimal;

struct SCeTypeFields : this(Dictionary<StringView, Type> Fields);

struct SCeTypeInfo : this(Type Type, StringView DisplayName, SCeTypeFields Fields);


class CTypeRegistery : CModule
{
	private Dictionary<Type, SCeTypeInfo> Types = new .() ~ delete _;

	public override System.StringView GetModuleName()
	{
		return "TypeRegistery";
	}

	public override void StartupModule()
	{
		RegisterType<SVector2D>("Vector 2D", .(new .() {("X", typeof(float)),("Y", typeof(float))}));
		RegisterType<SVector3D>("Vector 3D", .(new .() {("X", typeof(float)),("Y", typeof(float)),("Z", typeof(float))}));
		RegisterType<SRotator>("Rotation", .(new .() {("Pitch", typeof(float)),("Yaw", typeof(float)),("Roll", typeof(float))}));
		RegisterType<STransform>("Transform", .(new .() {("Location", typeof(SVector3D)),("Rotation", typeof(SRotator)),("Scale", typeof(SVector3D))}));
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