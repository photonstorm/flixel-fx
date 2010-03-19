package  
{
	import flash.display.BitmapData;
	import org.flixel.*;
	
	public class SnakeBit extends FlxSprite
	{
		
		
		public function SnakeBit(_x:int, _y:int, body:BitmapData) 
		{
			super(_x, _y);
			
			this.createGraphic(16, 16);
			
			this.pixels = body;
			
			trace("snake alive at " + x + " y: " + y);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}