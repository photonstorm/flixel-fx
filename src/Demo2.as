﻿/**
 * Demo 2
 * @author Richard Davey
 */

package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.BlendMode;
	import flash.utils.getTimer;
	
	import org.flixel.*;
	
	public class Demo2 extends FlxState
	{
		[Embed(source = '../assets/test1.png')] public var picPNG:Class;
		
		private var a:FlxSprite;
		private var b:FlxSprite;
		private var tmp:BitmapData;
		private var t:uint;
		
		public function Demo2() 
		{
		}
		
		override public function create():void
		{
			var t:FlxText = new FlxText(0, 0, 100, "- FlxColor Demo 2 -");
			
			a = new FlxSprite(0, 0, picPNG);
			
			//a = new FlxSprite().createGraphic(100, 100, 0xffffffff);
			
			b = new FlxSprite().createGraphic(320, 240);

			var colors:Array = new Array();
			
			//colors.push( { start: 0xFF0000, end: 0xFFFF00, distance: 8 } );
			colors.push( { start: 0xFFFF00, end: 0x80FF00, distance: 8 } );
			colors.push( { start: 0x80FF00, end: 0x00FFFF, distance: 50 } );
			colors.push( { start: 0x00FFFF, end: 0xFF0080, distance: 50 } );
			
			verticalGradient(b, colors, 0);
			//verticalGradient(b, [ { start: FlxColor.getRandomColor24(), end: FlxColor.getRandomColor24(), distance: 240 } ], 10 + Math.random() * 50);
			
			//add(b);
			
			//add(a);
			
			var txt:FlxText = new FlxText(0, 0, 200, "Photon Storm");
			
			add(txt);
			
			//tmp = a.pixels;
			tmp = txt.pixels;
			
			tmp.draw(b.pixels, null, null, BlendMode.SUBTRACT);
			
			//tmp.fillRect(new Rectangle(0, 0, 16, 16), 0xFFFF8000);
			
			//a.pixels = tmp;
			txt.pixels = tmp;
		}
		
		override public function update():void
		{
			//	Let's randomise the colours :)
			
			//if (getTimer() > t)
			//{
				//verticalGradient(b, [ { start: FlxColor.getRandomColor24(), end: FlxColor.getRandomColor24(), distance: 240 } ], 10 + Math.random() * 50);
				//t = getTimer() + 2000;
			//}
			//
			//tmp.draw(b.pixels, null, null, BlendMode.SUBTRACT);
			//
			//a.pixels = tmp;
			
			super.update();
		}
		
		
		
		private function verticalGradient (destImage:FlxSprite, colors:Array, steps:uint = 0, destX:uint = 0, destY:uint = 0, destWidth:uint = 0, destHeight:uint = 0):void
		{
			//	If width or height are 0 we use the full width/height of the source Sprite
			
			if (destWidth == 0)
			{
				destWidth = destImage.width;
			}
			
			if (destHeight == 0)
			{
				destHeight = destImage.height;
			}
			
			if (steps == 0)
			{
				steps = 1;
			}
			else
			{
				steps = destHeight / steps;
			}
			
			//	Divide by zero sanity checks
			if (destWidth == 0 || destHeight == 0)
			{
				if (FlxG.debug)
				{
					FlxG.log("FlxGradient: Divide by zero failure");
				}
				
				return;
			}
			
			//	colors is an Array of Objects, each Object contains a colour value and a distance (in pixels)
			
			var distanceCheck:int = 0;
			var distanceScale:Number = 0;
			
			for each (var color:Object in colors)
			{
				distanceCheck += color.distance;
			}
			
			if (distanceCheck != destHeight)
			{
				distanceScale = destHeight / distanceCheck;
			}
			
			var offset:int = 0;
			
			for each (color in colors)
			{
				if (distanceScale != 0)
				{
					color.distance *= distanceScale;
				}
				
				offset = drawVerticalGradient(destImage, color, steps, offset, destX, destY, destWidth);
			}
			
		}
		
		private function drawVerticalGradient (destImage:FlxSprite, color:Object, steps:uint, offset:uint, destX:uint, destY:uint, destWidth:uint):uint
		{
			var imageData:BitmapData = destImage.pixels;
			
			for (var dy:int = 0; dy < color.distance; dy += steps)
			{
				var drawColor:int = FlxColor.interpolateColor(color.start, color.end, color.distance, dy);
				
				imageData.fillRect(new Rectangle(destX, destY + dy + offset, destX + destWidth, destY + dy + offset + steps), drawColor);
			}
			
			offset += color.distance;
			
			destImage.pixels = imageData;
			
			return offset;
		}
		
		
		
		
	}

}