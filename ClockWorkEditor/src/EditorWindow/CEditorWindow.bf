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
		SDL_RenderClear(AppRenderer);

		DrawUI();

		
		SDL_RenderPresent(AppRenderer);
	}

	public override void DrawUI()
	{
		//Draw Top ToolBar
		SDL_SetRenderDrawColor(AppRenderer, 10, 10, 18, 80);
		int32 Width = 0;
		int32 Height = 0;
		SDL_GetWindowSize(AppWindow, &Width, &Height);
		SDL_FRect Toolbar;
		Toolbar.x = 0;
		Toolbar.y = 0;
		Toolbar.w = (float)Width;
		Toolbar.h = 20;
		SDL_RenderFillRect(AppRenderer, &Toolbar);
		//Draw ToolBar Buttons

		
	}
}