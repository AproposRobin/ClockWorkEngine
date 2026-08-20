using System;

namespace ClockWorkEngine.Module
{
	interface IModule
	{
		void StartupModule();
		void ShutdownModule();
		void ModuleTick(float deltaTime);
		bool DoesModuleTick();
		StringView GetModuleName();
		void InitModule(ClockWorkEngine GameEngine);

		public Span<StringView> GetPublicDependencies();
		public Span<StringView> GetPrivateDependencies();
	}
}