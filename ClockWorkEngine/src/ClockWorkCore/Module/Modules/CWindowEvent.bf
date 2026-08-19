using ClockWorkEngine.CoreMinimal;

using SDL3.Raw;
using static SDL3.Raw.SDL_EventType;

namespace ClockWorkEngine.Module
{
	class CWindowEvent : CModule
	{
		public function void(SDL_Event*) OnEventPolled = null;
 
		public this()
		{
			CanModuleEverTick(true);
		}

		public override System.StringView GetModuleName()
		{
			return "CWindowEvent";
		}

		public override void ModuleTick(float DeltaTime)
		{
			PollEvents();
		}

		public override void StartupModule()
		{

		}

		public override void ShutdownModule()
		{

		}

		public void PollEvents()
		{
			SDL_Event Event = default;
			while (SDL_PollEvent(&Event))
			{
				if(Event.type == (.)SDL_EVENT_QUIT)
				{

				}

				if(OnEventPolled != null)
				{
					OnEventPolled(&Event);
				}
			}
			
		}
	}
}

