/**
 * A super-simple Snake clone
 * 
 * Use the cursor keys to move the snake, eat the fruit and see how long you
 * can go for! (and yes I know the snake looks like a load of testicles :)
`* 
 * @author Richard Davey
 */

package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class SnakeDemo extends FlxState
	{
		[Embed(source = '../assets/snake.png')] private var snakeBits:Class;
		
		private var map:FlxTilemap;
		private var dirt:FlxSprite;
		
		public function SnakeDemo() 
		{
		}
		
		override public function create():void
		{
			var tiles:BitmapData = Bitmap(new snakeBits).bitmapData;
			
			/*
			 * 1 - 6 are the walls, 7 = fruit, 8 = dirt, 9 = snake
			 */
			
			var mapData:String = "";
			mapData = mapData.concat("1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5\n");
			mapData = mapData.concat("2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1\n");
			mapData = mapData.concat("3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2\n");
			mapData = mapData.concat("4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3\n");
			mapData = mapData.concat("5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4\n");
			mapData = mapData.concat("1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n");
			mapData = mapData.concat("2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1\n");
			mapData = mapData.concat("3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2\n");
			mapData = mapData.concat("4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3\n");
			mapData = mapData.concat("5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4\n");
			mapData = mapData.concat("1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5\n");
			mapData = mapData.concat("2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1\n");
			mapData = mapData.concat("3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2\n");
			mapData = mapData.concat("4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3\n");
			mapData = mapData.concat("1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5");
			
			map = new FlxTilemap();
			map.loadMap(mapData, snakeBits, 16, 16);
			
			
			dirt = new FlxSprite(0, 0).createGraphic(320, 240);
			
			var bmd:BitmapData = dirt.pixels;
			
			for (var ty:int = 0; ty <= 240; ty = ty + 16)
			{
				for (var tx:int = 0; tx <= 320; tx = tx + 16)
				{
					bmd.copyPixels(tiles, new Rectangle(16 * 8, 0, 16, 16), new Point(tx, ty));
				}
			}
			
			dirt.pixels = bmd;
			
			add(dirt);
			add(map);
			
		}
		
		
		
	}

}