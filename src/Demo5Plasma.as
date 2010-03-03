package  
{
	import flash.display.BitmapData;
	import org.flixel.*;

	public class Demo5Plasma extends FlxState
	{
		private var offset:int = 0;
		private var offsetSpeed:int = 6;
		private var colours:Array;
		private var plasma:Array;
		
		public function Demo5Plasma() 
		{
		}
		
		override public function create():void
		{
			colours = new Array();
			plasma = new Array();
			
			for (var i:int = 0; i < 359; i++)
			{
				colours[i] = FlxColor.HSVtoRGB(i, 1.0, 1.0);
			}
			
			for (var x:int = FlxG.width - 1; x >= 0; x--)
			{
				for (var y:int = FlxG.height - 1; y >= 0; y--)
				{
					var index:int = (x * y) + x;
					
					var cx:int = x - FlxG.width / 2;
					var cy:int = y - FlxG.height / 2;
					
					plasma[index] = int(Math.sin(Math.sqrt(cx * cx + cy * cy) * 16.0) * 64.0 - 180.0 * Math.sin(cx * 2.0) + 180.0 + Math.sin(cy * 2.0)) / 2;
				}
			}
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.buffer.lock();
			
			var p:BitmapData = FlxG.buffer;
			
			for (var y:int = 0; y < FlxG.height - 1; y++)
			{
				for (var x:int = 0; x < FlxG.width - 1; x++)
				{
					var index:int = (x * y) + x;
					p.setPixel(x, y, colours[ int(wrapvalue(plasma[index], offset)) ] );
				}
			}
			
			FlxG.buffer.unlock();
			
			offset = wrapvalue(offset, offsetSpeed);
		}
		
		//	Keeps the total between 0 and 360
		private function wrapvalue(a:Number, b:Number):uint
		{
			if (a + b > 360)
			{
				//	How much over are they?
				var left:int = 360 - (a + b);
				
				if (left > 360)
				{
					trace("bugger");
				}
				else
				{
					return left;
				}
			}
			else
			{
				return a + b;
			}
			
			return 0;
		}
		
	}

}