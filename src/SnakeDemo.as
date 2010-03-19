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
	import org.flixel.*;
	
	public class SnakeDemo extends FlxState
	{
		[Embed(source = '../assets/snake.png')] private var snakeTiles:Class;
		[Embed(source = "../assets/snake_map.txt", mimeType = "application/octet-stream")] public var snakeMapCSV:Class;
		
		private var debug:FlxText;
		private var map:FlxTilemap;
		private var safeLocations:Array;
		private var fruit:FlxSprite;
		private var snake:theSnake;
		
		public function SnakeDemo() 
		{
		}
		
		override public function create():void
		{
			snake = new theSnake();
			
			map = new FlxTilemap();
			map.loadMap(new snakeMapCSV(), snakeTiles, 16, 16);
			map.collideIndex = 2;
			
			//	Put all dirt tiles into the safeLocations array (as these are valid places to put fruit)
			safeLocations = new Array();
			
			for (var t:int = 0; t < map.totalTiles; t++)
			{
				if (map.getTileByIndex(t) == 1)
				{
					safeLocations.push(t);
				}
			}
			
			//	Create our fruit sprite (there will only be 1 on-screen at once)
			fruit = new FlxSprite(0, 0, snakeTiles);
			fruit.loadGraphic(snakeTiles, true, false, 16, 16);
			fruit.addAnimation("fruit", [ 8 ], 0, true);
			fruit.play("fruit");
			
			debug = new FlxText(0, 0, 320, "Debug");
			debug.scrollFactor.x = debug.scrollFactor.y = 0;
			
			placeFruit();
			
			FlxG.follow(snake.theHead, 2);
			FlxG.followBounds(0, 0, map.width, map.height);
			
			add(map);
			add(snake);
			add(debug);
		}
		
		private function placeFruit():void
		{
			//	Pick a random bit of dirt from the map :)
			//map.
			//
			//fruit = safeLocations[int(Math.random() * safeLocations.length - 1)];
			//
			//map.setTileByIndex(fruit, 8);
			
			//map.setCallback(
			
		}
		
		override public function update():void
		{
			//debug.text = "snake x: " + snake.theHead.x + " y: " + snake.theHead.y + " tile: " + map.getTileByScreenXY(snake.theHead.x, snake.theHead.y);
			
			//var dx:Object = map.getTileByXY(snake.theHead.x, snake.theHead.y);
			//debug.text = "snake x: " + snake.theHead.x + " y: " + snake.theHead.y + " tile xy: " + dx.x + " y: " + dx.y;
			
			var currentTile:uint = map.getTileByXY(snake.theHead.x, snake.theHead.y);
			
			var currentTileXY:FlxPoint = map.getTileXY(currentTile);
			
			debug.text = "snake x: " + snake.theHead.x + " y: " + snake.theHead.y + " tile: " + currentTile + " x: " + currentTileXY.x + " y: " + currentTileXY.y;
			
			if (snake.isAlive)
			{
				if (FlxG.keys.UP)
				{
					snake.theHead.facing = FlxSprite.UP;
					snake.moveSnakeParts();
				}
				else if (FlxG.keys.DOWN)
				{
					snake.theHead.facing = FlxSprite.DOWN;
					snake.moveSnakeParts();
				}
				else if (FlxG.keys.LEFT)
				{
					snake.theHead.facing = FlxSprite.LEFT;
					snake.moveSnakeParts();
				}
				else if (FlxG.keys.RIGHT)
				{
					snake.theHead.facing = FlxSprite.RIGHT;
					snake.moveSnakeParts();
				}
			}
			
			//if (map.overlaps(snake.theHead))
			//{
				//	Fruit or Block?
				//if (map.get
				//trace("DEAD!");
				//snake.isAlive = false;
			//}
			
			super.update();
			
		}
		
	}

}