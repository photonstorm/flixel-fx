/**
 * Demo 3
 * @author Richard Davey
 */

package  
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import org.flixel.*;

	public class Demo3 extends FlxState
	{
		[Embed(source = "../assets/100x100map.txt", mimeType = "application/octet-stream")] public var mapData:Class;
		
		private var player:FlxSprite;
		private var map:FlxTilemap;
		private var sky:FlxSprite;
		private var _jumpPower:int;
		private var t:int;
 
		public function Demo3()
		{
		}
		
		override public function create():void
		{
			//	Player
			player = new FlxSprite().createGraphic(8, 8);
			player.x = 64;
			player.y = 64;
			//basic player physics
			var runSpeed:uint = 80;
			player.drag.x = runSpeed * 8;
			player.acceleration.y = 420;
			_jumpPower = 260;
			player.maxVelocity.x = runSpeed;
			player.maxVelocity.y = _jumpPower;

			//	Map
			map = new FlxTilemap();
			map.auto = FlxTilemap.AUTO;
			map.loadMap(new mapData(), FlxTilemap.ImgAuto, 8, 8);
			
			//	Sky
			sky = new FlxSprite().createGraphic(320, map.height);
			sky.scrollFactor.x = 0;
			sky.scrollFactor.y = 1;

			var colors:Array = new Array();
			
			colors.push( { start: 0xFF0000, end: 0xFFFF00, distance: 50 } );
			colors.push( { start: 0xFFFF00, end: 0x80FF00, distance: 50 } );
			colors.push( { start: 0x80FF00, end: 0x00FFFF, distance: 50 } );
			colors.push( { start: 0x00FFFF, end: 0xFF0080, distance: 50 } );
			
			verticalGradient(sky, colors, 0);
			
			FlxG.follow(player);
			FlxG.followAdjust(0.5, 0.0);
			FlxG.followBounds(0, 0, map.width, map.height);
			
			add(sky);
			add(map);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			map.collide(player);
			
			player.acceleration.x = 0;
			
			if (FlxG.keys.LEFT)
			{
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				player.acceleration.x += player.drag.x;
			}
			
			if (FlxG.keys.UP && !player.velocity.y)
			{
				player.velocity.y = -_jumpPower;
			}
			
			if (getTimer() > t)
			{
				var r1:int = FlxColor.getRandomColor24();
				var r2:int = FlxColor.getRandomColor24();
				var sp:int = 10 + Math.random() * 50;
				
				FlxG.log("Gradient from " + r1 + " to " + r2 + " Steps: " + sp);
				
				verticalGradient(sky, [ { start: r1, end: r2, distance: map.height } ], sp);
				t = getTimer() + 3000;
			}

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