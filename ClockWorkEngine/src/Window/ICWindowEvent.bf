using ClockWorkEngine.CoreMinimal;

namespace ClockWorkEngine.WindowEvents
{
	interface ICWindowEvent
	{
		//public void BindOnCloseDelegate(delegate void(int32) OnWinCloseDel);
		public void BindOnCloseDelegate(delegate void(int32) OnWinCloseDel);
	}
}