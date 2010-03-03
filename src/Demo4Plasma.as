package  
{
	import flash.display.BitmapData;
	import org.flixel.*;

	public class Demo4Plasma extends FlxState
	{
		private var pos1:uint;
		private var pos2:uint;
		private var pos3:uint;
		private var pos4:uint;
		private var tpos1:uint;
		private var tpos2:uint;
		private var tpos3:uint;
		private var tpos4:uint;
		
		private var aSin:Array;
		private var colours:Array;
		
		private var canvas:FlxSprite;
		
		public function Demo4Plasma() 
		{
		}
		
		override public function create():void
		{
			colours = FlxColor.getHSVColorWheel();
			aSin = new Array();
			
			//colours = FlxColor.getGradientAsArray(0xFF0000, 0xFFFF00, 360);
			
			for (var i:int = 0; i < 512; i++)
			{
				var rad:Number = (i * 0.703125) * 0.0174532;
				//aSin[i] = Math.sin(rad) * 1024;
				aSin[i] = Math.cos(rad) * 1024;
			}
			
			canvas = new FlxSprite();
			canvas.width = 100;
			canvas.height = 100;
			
			add(canvas);
		}
		
		override public function update():void
		{
			super.update();
			
			tpos4 = pos4;
			tpos3 = pos3;
			
			//FlxG.buffer.lock();
			
			var b:BitmapData = canvas.pixels;
			
			for (var y:int = 0; y < FlxG.height; ++y)
			{
				tpos1 = pos1 + 5;
				tpos2 = pos2 + 3;
				
				//tpos1 = pos1 + 6;
				//tpos2 = pos2 + 6;
				
				tpos3 &= 511;
				tpos2 &= 511;
				
				for (var x:int = 0; x < FlxG.width; ++x)
				{
					tpos1 &= 511;
					tpos2 &= 511;
					
					var x2:int = aSin[tpos1] + aSin[tpos2] + aSin[tpos3] + aSin[tpos4];
				
					var index:int = 128 + (x2 >> 4);
					
					if (index < 0)
					{
						index += 360;
					}
					
					//FlxG.buffer.setPixel(x, y, colours[index]);
					b.setPixel(x, y, colours[index]);
					
					tpos1 += 5;
					tpos2 += 3;
					
					//tpos1 += 6;
					//tpos2 += 6;
					
				}
				
				tpos4 += 3;
				tpos3 += 1;
				
				//tpos4 += 6;
				//tpos3 += 6;
				
			}
			
			//FlxG.buffer.unlock();
			
			canvas.pixels = b;
			
			
			//	Move Plasma speeds
			
			//pos1 += 9;
			//pos3 += 8;
			
			pos1 += 1;
			pos3 += 1;
		}

		
	}

}