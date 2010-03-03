package  
{
	import flash.display.BitmapData;
	import org.flixel.*;

	public class Demo6Plasma extends FlxState
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

		private var mod:Number;
		
		private var canvas:FlxSprite;
		
		public function Demo6Plasma() 
		{
		}
		
		override public function create():void
		{
			canvas = new FlxSprite(0, 0).createGraphic(320/2, 240/2, 0xff000000);
			canvas.scale.x = 3;
			canvas.scale.y = 3;
			
			colours = FlxColor.getHSVColorWheel();
			
			aSin = new Array();
			
			for (var i:int = 0; i < 512; i++)
			{
				var rad:Number = (i * 0.703125) * 0.0174532;
				aSin[i] = Math.sin(rad) * 1024;
			}
			
			add(canvas);
		}
		
		override public function update():void
		{
			super.update();
			
			tpos4 = pos4;
			tpos3 = pos3;
			
			var b:BitmapData = canvas.pixels;
			
			for (var y:int = 0; y < canvas.height; ++y)
			{
				tpos1 = pos1 + 5;
				tpos2 = pos2 + 3;
				
				tpos3 &= 511;
				tpos2 &= 511;
				
				for (var x:int = 0; x < canvas.width; ++x)
				{
					tpos1 &= 511;
					tpos2 &= 511;
					
					var x2:int = aSin[tpos1] + aSin[tpos2] + aSin[tpos3] + aSin[tpos4];
				
					var index:int = 128 + (x2 >> 4);
					
					if (index < 0)
					{
						index += 360;
					}
					
					if (index >= 360)
					{
						index -= 360;
					}
					
					b.setPixel(x, y, colours[index]);
					
					tpos1 += 5;
					tpos2 += 3;
				}
				
				tpos4 += 3;
				tpos3 += 1;
			}
			
			canvas.pixels = b;
			
			//	Move Plasma speeds
			
			pos1 += 1;
			pos3 += 2;
		}

		
	}

}