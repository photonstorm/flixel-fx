package photonstorm.demofx
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class starfield3D extends Sprite
	{
		private var stars:Array;
		private var output:Bitmap;
		private var cls:BitmapData;
		private var clsRectangle:Rectangle;
		private var clsPoint:Point;
		private var centerX:int;
		private var centerY:int;
		private var starMinSpeed:uint = 1;
		private var starMaxSpeed:uint = 4;
		private var powerXSeed:int;
		private var powerYSeed:int;
		private var powerX:int = 2000;
		private var powerY:int = 2000;
		private var starQuantity:uint;
		
		public function starfield3D():void
		{
		}
		
		public function init(width:uint, height:uint, quantity:uint = 500, transparent:Boolean = true, xSeed:int = 30, ySeed:int = 30):void
		{
			if (transparent)
			{
				output = new Bitmap(new BitmapData(width, height, true, 0));
				cls = new BitmapData(width, height, true, 0);
			}
			else
			{
				output = new Bitmap(new BitmapData(width, height, false, 0));
				cls = new BitmapData(width, height, false, 0);
			}
			
			clsRectangle = new Rectangle(0, 0, output.width, output.height);
			clsPoint = new Point(0, 0);
			
			starQuantity = quantity;
			
			centerX = output.width >> 1;
			centerY = output.height >> 1;
			
			powerXSeed = xSeed;
			powerYSeed = ySeed;
			
			starMinSpeed = minSpeed;
			starMaxSpeed = maxSpeed;
			
			stars = new Array();
			
			for (var i:uint = 0; i < starQuantity; i++)
			{
				initStar(i);
			}
			
			addChild(output);
			
			output.x = -(output.width / 2);
			output.y = -(output.height / 2);
			
			//return output;
		}
		
		public function go():void
		{
			addEventListener(Event.ENTER_FRAME, mainLoop, false, 0, true);
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, mainLoop);
		}
		
		private function initStar(i:uint):void
		{
			if (!stars[i])
			{
				stars[i] = [0, 0, 0, 0];
			}
			
			//	X
			stars[i][0] = -(powerXSeed / 2) + (Math.random() * powerXSeed);
			stars[i][0] *= powerX;
			
			//	Y
			stars[i][1] = -(powerYSeed / 2) + (Math.random() * powerYSeed);
			stars[i][1] *= powerY;
			
			//	Z
			stars[i][2] = i;
			
			//	Speed
			stars[i][3] = starMinSpeed + int(Math.random() * starMaxSpeed);
		}
		
		private function mainLoop(event:Event):void
		{
			output.bitmapData.lock();
			
			//	CLS
			output.bitmapData.copyPixels(cls, clsRectangle, clsPoint);
			
			for (var i:uint = 0; i < starQuantity; i++)
			{
				stars[i][2] -= stars[i][3];
				
				if (stars[i][2] <= 0)
				{
					initStar(i);
				}
				
				var tempX:Number = (stars[i][0] / stars[i][2]) + centerX;
				var tempY:Number = (stars[i][1] / stars[i][2]) + centerY;
				
				if (tempX < 0 || tempX > output.width - 1 || tempY < 0 || tempY > output.height - 1)
				{
					initStar(i);
					continue;
				}
				
				//output.bitmapData.setPixel32(tempX, tempY, calculateColour(i));
				output.bitmapData.setPixel32(tempX, tempY, 0xffffffff);
			}
			
			output.bitmapData.unlock();
			
		}
		
		private function calculateColour(i:uint):int
		{
			var jump:Number = (250 / starQuantity);
			
			jump *= (starQuantity - stars[i][2]);
			
			//	Inverse the value
			var c:int = int(jump);
			
			return combineRGB(c, c, c);
		}
		
		private function combineRGB(red:Number, green:Number, blue:Number):Number
		{
			var RGB:Number;

			if ( red > 255 ){ red = 255; }
			if ( green > 255 ) { green = 255; }
			if ( blue > 255 ) { blue = 255; }

			if ( red < 0 ) { red = 0; }
			if ( green < 0 ) { green = 0;}
			if ( blue < 0 ) { blue = 0;}

			RGB = (red<<16) | (green<<8) | blue;

			return RGB;
		}
		
		public function get xPower():int
		{
			return powerX;
		}
		
		public function get yPower():int
		{
			return powerY;
		}
		
		public function set xPower(x:int):void
		{
			powerX = x;
		}
		
		public function set yPower(y:int):void
		{
			powerY = y;
		}
		
		public function get xCenter():int
		{
			return centerX;
		}
		
		public function get yCenter():int
		{
			return centerY;
		}
		
		public function set xCenter(x:int):void
		{
			centerX = x;
		}
		
		public function set yCenter(y:int):void
		{
			centerY = y;
		}
		
		public function get minSpeed():int
		{
			return starMinSpeed;
		}
		
		public function get maxSpeed():int
		{
			return starMaxSpeed;
		}
		
		public function set minSpeed(speed:int):void
		{
			starMinSpeed = speed;
		}
		
		public function set maxSpeed(speed:int):void
		{
			starMaxSpeed = speed;
		}
	}
}