namespace ClockWorkEngine.Module;

using System;


using ClockWorkEngine.Core;

abstract class CModule
{
	private List<StringView> PublicDependencies = new .() ~ delete(_);
	private List<StringView> PrivateDependencies = new .() ~ delete(_);
	protected bool bModuleTicks = false;
	protected ClockWorkEngine CEngine {get; protected set;}

	public abstract StringView GetModuleName();
	public Span<StringView> GetPublicDependencies() {return PublicDependencies;}
	public abstract void StartupModule();
	public abstract void ShutdownModule();
	public virtual void ModuleTick(float DeltaTime){}

	public void InitModule(ClockWorkEngine GameEngine){CEngine = GameEngine;}
	public bool DoesModuleTick(){return bModuleTicks;}
}