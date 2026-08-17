namespace ClockWorkEngine.Module.TypeRegister;

using System;
using System.Collections;
using ClockWorkEngine.CoreMinimal;

struct SCeTypeInfo
{
	public Type Type;
	public StringView DisplayName;

	public this(Type Type, StringView DisplayName)
	{
		this.Type = Type;
		this.DisplayName = DisplayName;
	}
}

class CTypeRegistery : CModule
{
	private Dictionary<Type, SCeTypeInfo> Types = new .() ~ delete _;

	public override System.StringView GetModuleName()
	{
		return "TypeRegistery";
	}

	public override void StartupModule()
	{
		RegisterType<SVector2D>("Vector 2D");
		RegisterType<SVector3D>("Vector 3D");
		RegisterType<SRotator>("Rotation");

		RegisterType<STransform>("Transform");
	}

	public void RegisterType<T>(StringView DisplayName)
	{
		Types[typeof(T)] = .(typeof(T), DisplayName);
	}

	public SCeTypeInfo GetTypeInfo(Type Type)
	{
		return Types[Type];
	}

	public override void ShutdownModule()
	{

	}
}