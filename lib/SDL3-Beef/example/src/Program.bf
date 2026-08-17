namespace example;

using System;
using System.IO;

using SDL3.Raw;

class Program
{
	public static void Main()
	{
		SDL_Window* window = null;
		SDL_Renderer* renderer = null;

		if(!SDL_Init(.SDL_INIT_VIDEO))
		{
			Console.WriteLine("Unable to initialize sdl3");
			Console.Read();
		}

		if(!SDL_CreateWindowAndRenderer("SDL3 - Hello world", 720, 360, .SDL_WINDOW_OPENGL, &window, &renderer))
		{
			Console.WriteLine("Unable to create a renderer");
			Console.Read();
		}

		bool quit = false;
		SDL_Event e = .();

		while(!quit)
		{
			while(SDL_PollEvent(&e))
			{
				if(((SDL_EventType)e.type == SDL_EventType.SDL_EVENT_QUIT))
					quit = true;
			}

			SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

			SDL_RenderClear(renderer);

			SDL_FRect r = .() {x = 720/2-5, y = 360/2-5, w = 10, h = 10};
			SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
			SDL_RenderRect(renderer, &r);
			SDL_RenderPresent(renderer);
		}

		SDL_DestroyRenderer(renderer);
		SDL_DestroyWindow(window);
		SDL_Quit();
	}
}