namespace ClockWorkEngine.ModuleManager;

using System;
using System.Collections;

using ClockWorkEngine.Module;

class CModuleManager
{
	private Dictionary<StringView, CModule> Modules = new .() ~ DeleteDictionaryAndValues!(_);
	private ClockWorkEngine CEngine;

	public this(ClockWorkEngine GameEngine)
	{
		CEngine = GameEngine;
	}

	public void RegisterModule(CModule Module)
	{
		Modules[Module.GetModuleName()] = Module;
		Module.InitModule(CEngine);
	}

	public void StartupAllModules()
	{
		List<CModule> SortedMods = scope .();
		HashSet<StringView> VisitedMods = scope .();

		void Visit(CModule Mod)
		{
			if(VisitedMods.Contains(Mod.GetModuleName()))
				return;
			VisitedMods.Add(Mod.GetModuleName());

			if(Mod.GetPublicDependencies().Length != 0)
			{
				for(let DepName in ref Mod.GetPublicDependencies())
				{
					if(Modules.TryGetValue(DepName, let Dep))
						Visit(Dep);
					else
						Console.WriteLine(scope $"Warning: module '{Mod.GetModuleName()}' missing dependency '{DepName}'");
				}
			}
			//We need to do private dependencies seperately for each module and ensure it isn't already loaded
			SortedMods.Add(Mod);
			return;
		}

		for(let Mod in ref Modules.Values)
			Visit(Mod);

		for(let Mod in ref SortedMods)
			Mod.StartupModule();
	}

	public void ShutdownAllModules()
	{
		for(let Mod in ref Modules.Values)
			Mod.ShutdownModule();
	}

	public void TickModules(float DeltaTime)
	{
		//Later we should check if a module can even tick not all of them need to
		for(let Mod in ref Modules.Values)
			Mod.ModuleTick(DeltaTime);
	}

	public CModule GetModule(StringView ModuleName)
	{
		return Modules.GetValue(ModuleName);
	}
}