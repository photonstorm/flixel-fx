package  
{
	import flash.display.BitmapData;
	import org.flixel.*;

	public class Demo9Plasma extends FlxState
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
		private var canvas2:FlxSprite;
		private var canvas3:FlxSprite;
		private var canvas4:FlxSprite;
		
		public function Demo9Plasma() 
		{
		}
		
		override public function create():void
		{
			canvas = new FlxSprite(0, 0).createGraphic(320 / 2, 240 / 2, 0xff000000);
			
			//	Trying to tile the effect :)
			canvas2 = new FlxSprite(160, 0).createGraphic(320 / 2, 240 / 2, 0xff000000);
			canvas2.scale.x = -1;
			
			canvas3 = new FlxSprite(0, 120).createGraphic(320 / 2, 240 / 2, 0xff000000);
			canvas3.scale.y = -1;
			
			canvas4 = new FlxSprite(160, 120).createGraphic(320 / 2, 240 / 2, 0xff000000);
			canvas4.scale.x = -1;
			canvas4.scale.y = -1;
			
			//	Make sure the first and last colours are the same for a seamless plasma
			
			//	Beautiful :)
			colours = FlxGradient.createGradientArray(1, 361, [0x00FF00, 0x00FFFF, 0xFF0080, 0x00FF00] );
			
			//	Uber plasma :)
			//colours = FlxGradient.createGradientArray(1, 361, [0xFF0080, 0x00FFFF, 0xFF0080, 0x00FFFF, 0xFF0080, 0x00FFFF, 0xFF0080, 0x00FFFF, 0xFF0080, 0x00FFFF, 0xFF0080] );
			
			//	Pink and Black
			//colours = FlxGradient.createGradientArray(1, 361, [0x000000, 0x000000, 0x000000, 0x000000, 0xFF0080, 0x000000, 0x000000, 0x000000, 0x000000] );
			
			FlxG.log("len: " + colours.length);
			FlxG.log(colours);
			
			aSin = new Array();
			
			for (var i:int = 0; i < 1024; i++)
			{
				var rad:Number = (i * 0.703125) * 0.0174532;
				aSin[i] = Math.sin(rad) * 1024;
			}
			
			add(canvas);
			add(canvas2);
			add(canvas3);
			add(canvas4);
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
				
					var index:int = FlxMath.wrapValue(128, x2 >> 4, 359);
					
					b.setPixel(x, y, colours[index]);
					
					tpos1 += 5;
					tpos2 += 3;
				}
				
				tpos4 += 3;
				tpos3 += 1;
			}
			
			canvas.pixels = b;
			
			canvas2.pixels = canvas.pixels;
			canvas3.pixels = canvas.pixels;
			canvas4.pixels = canvas.pixels;
			
			//	Move Plasma speeds
			
			pos1 += 1;
			pos3 += 2;
		}

		
	}

}