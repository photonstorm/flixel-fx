package  
{
	import org.flixel.*;
	
	public class DemoScale extends FlxState
	{
		public function DemoScale() 
		{
		}
		
		override public function create():void
		{
			var h:HUD = new HUD();
			
			add(h);
			
		}
	}
}