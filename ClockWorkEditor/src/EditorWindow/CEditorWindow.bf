namespace ClockWorkEditor.EditorWindow;

using ClockWorkEngine.Window;
using SDL3.Raw;

class CEditorWindow : CWindow
{
	public this(ClockWorkEngine.Application.CApplication Application, System.StringView Name) : base(Application, Name){}

	public override void Init()
	{
		CreateWindow(WindowName);
	}

	public override void Shutdown()
	{

	}

	public override void Tick()
	{
		SDL_SetRenderDrawColor(AppRenderer, 35, 35, 38, 255);

		//Draw UI
		SDL_RenderClear(AppRenderer);
		SDL_RenderPresent(AppRenderer);
	}
}