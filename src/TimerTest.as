package  
{
	import org.flixel.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimerTest extends FlxState
	{
		private var myTimer:Timer;
		
		public function TimerTest() 
		{
			super();
			
			myTimer = new Timer(10000, 0);
		}
		
	}

}