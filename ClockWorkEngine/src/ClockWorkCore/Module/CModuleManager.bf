using System;
using System.Collections;

using ClockWorkEngine.Module;

namespace ClockWorkEngine.ModuleManager
{
	class CModuleManager
	{
		private Dictionary<StringView, IModule> Modules = new .() ~ DeleteDictionaryAndValues!(_);
		private ClockWorkEngine CEngine;

		public this(ClockWorkEngine GameEngine)
		{
			CEngine = GameEngine;
		}

		public void RegisterModule(IModule Module)
		{
			Modules[Module.GetModuleName()] = Module;
			Module.InitModule(CEngine);
		}

		public void StartupCoreModules()
		{
			List<IModule> SortedMods = scope .();
			HashSet<StringView> VisitedMods = scope .();
			HashSet<StringView> VisitingMods = scope .();

			void Visit(IModule Mod)
			{
				StringView ModName = Mod.GetModuleName();

				if (VisitingMods.Contains(ModName))
				{
					Runtime.FatalError(scope $"Fatal: Circular dependency detected involving module '{ModName}'!");
				}

				if(VisitedMods.Contains(Mod.GetModuleName()))
					return;

				VisitingMods.Add(Mod.GetModuleName());

				for(let DepName in Mod.GetPublicDependencies())
				{
					if(Modules.TryGetValue(DepName, let Dep))
						Visit(Dep);
					else
						Console.WriteLine(scope $"Warning: module '{Mod.GetModuleName()}' missing dependency '{DepName}'");
				}
				VisitingMods.Remove(ModName);
				VisitedMods.Add(ModName);
				//We need to do private dependencies separately for each module and ensure it isn't already loaded
				SortedMods.Add(Mod);
				return;
			}

			for(let Mod in Modules.Values)
				Visit(Mod);

			for(let Mod in SortedMods)
				Mod.StartupModule();
		}

		public void ShutdownAllModules()
		{
			for(let Mod in Modules.Values)
				Mod.ShutdownModule();
		}

		public void TickModules(float DeltaTime)
		{
			//Later we should check if a module can even tick not all of them need to
			for(let Mod in Modules.Values)
			{
				if(Mod.DoesModuleTick())
				{
					Mod.ModuleTick(DeltaTime);
				}
			}
		}

		public CModule GetModule(StringView ModuleName)
		{
			if (Modules.TryGetValue(ModuleName, let Mod))
				return Mod as CModule;
			return null;
		}
	}
}