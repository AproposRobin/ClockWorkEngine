namespace ClockWorkEngine.Modules;

using ClockWorkEngine.Module;
using ClockWorkEngine.OpenGl;
using System;

using GLFW;
using ImGui;

using static GLFW.Glfw;
using static ImGui.ImGui;

class CRenderer : CModule
{
	public override StringView GetModuleName(){return "CRenderer";}

	public override void StartupModule()
	{

	}

	public override void ShutdownModule()
	{

	}
}