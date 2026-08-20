using System;
using System.Collections;

namespace ClockWorkEngine.Module
{
	abstract class CModule : IModule
	{
		private List<StringView> PublicDependencies = new .() ~ delete(_);
		private List<StringView> PrivateDependencies = new .() ~ delete(_);
		private bool bModuleTicks = false;
		protected ClockWorkEngine CEngine {get; protected set;}

		public abstract StringView GetModuleName();
		public abstract void StartupModule();
		public abstract void ShutdownModule();
		public virtual void ModuleTick(float DeltaTime){}
		public Span<StringView> GetPublicDependencies() {return PublicDependencies;}
		public Span<StringView> GetPrivateDependencies() {return PrivateDependencies;}

		public void InitModule(ClockWorkEngine GameEngine){CEngine = GameEngine;}
		public bool DoesModuleTick(){return bModuleTicks;}
		public void CanModuleEverTick(bool bCanTick){bModuleTicks = bCanTick;}
	}
}
