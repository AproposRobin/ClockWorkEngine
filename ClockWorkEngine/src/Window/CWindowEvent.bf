using ClockWorkEngine.CoreMinimal;
using ClockWorkEngine.WindowEvents;

using SDL3.Raw;
using static SDL3.Raw.SDL_EventType;

namespace ClockWorkEngine.Module
{
	class CWindowEvent : CModule, ICWindowEvent
	{
		public delegate void(SDL_Event*) OnEventPolled = null;
		public delegate void(int32) OnWindowClose = null;
 
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

		public void BindOnCloseDelegate(delegate void(int32) OnWinCloseDel)
		{
			OnWindowClose = OnWinCloseDel;
		}

		public void PollEvents()
		{
			SDL_Event Event = default;
			while (SDL_PollEvent(&Event))
			{
				if(Event.type == (uint32)SDL_EVENT_QUIT)
				{
					if(OnWindowClose != null)
					{
						OnWindowClose(0);
					}
				}

				if(OnEventPolled != null)
				{
					OnEventPolled(&Event);
				}
			}
			
		}
	}
}

