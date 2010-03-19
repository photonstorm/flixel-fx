package  
{
	import flash.utils.getTimer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.*;
	
	public class theSnake extends FlxGroup
	{
		[Embed(source = '../assets/snake.png')] private var snakeBits:Class;
		
		public var isAlive:Boolean;
		public var theHead:FlxSprite;
		private var body:Array;
		private var snakeHeadGraphic:BitmapData;
		private var snakeBodyGraphic:BitmapData;
		private var nextMove:int;
		private var snakeSpeed:int;
		
		public function theSnake() 
		{
			super();
			
			isAlive = true;
			
			body = new Array();
			
			/*
			 * 1 = dirt, 2 - 7 are the walls, 8 = fruit, 9 = snake head, 10 = snake body
			 */
			var tiles:BitmapData = Bitmap(new snakeBits).bitmapData;
			
			snakeHeadGraphic = new BitmapData(16, 16);
			snakeBodyGraphic = new BitmapData(16, 16);
			
			snakeHeadGraphic.copyPixels(tiles, new Rectangle(16 * 9, 0, 16, 16), new Point(0, 0));
			snakeBodyGraphic.copyPixels(tiles, new Rectangle(16 * 10, 0, 16, 16), new Point(0, 0));
			
			snakeSpeed = 150;
			
			//	Let's create the body pieces, we'll start with 3 pieces and they will appear in the center of the map
			
			spawnNewBody(128, 128);
			spawnNewBody(144, 128);
			spawnNewBody(160, 128);
			spawnNewBody(176, 128);
			
			//	For easy later reference
			theHead = body[0];
			theHead.pixels = snakeHeadGraphic;
			theHead.facing = FlxSprite.LEFT;
			
			nextMove = getTimer() + snakeSpeed * 2;
		}
		
		private function spawnNewBody(_x:int, _y:int):void
		{
			var newBit:SnakeBit = new SnakeBit(_x, _y, snakeBodyGraphic);
			
			body.push(newBit);
			
			add(newBit);
		}
		
		override public function update():void
		{
			super.update();
			
			//if (isAlive)
			//{
				//if (getTimer() > nextMove)
				//{
					//moveSnakeParts();
					//nextMove = getTimer() + snakeSpeed;
				//}
			//}
		}
		
		public function moveSnakeParts():void
		{
			//	Move the head in the direction it is facing
			
			var oldX:int = theHead.x;
			var oldY:int = theHead.y;
			
			switch (theHead.facing)
			{
				case FlxSprite.LEFT:
					theHead.x -= 16;
					//theHead.x -= 4;
					break;
					
				case FlxSprite.RIGHT:
					theHead.x += 16;
					//theHead.x += 4;
					break;
					
				case FlxSprite.UP:
					theHead.y -= 16;
					//theHead.y -= 4;
					break;
					
				case FlxSprite.DOWN:
					theHead.y += 16;
					//theHead.y += 4;
					break;
			}
			
			//	And now interate the movement down to the rest of the body parts
			//	The easiest way to do this is simply to work our way backwards through the body pieces!
			
			for (var s:int = body.length - 1; s > 0; s--)
			{
				//trace("snake bit " + s + " moving from x: " + body[s].x + " y: " + body[s].y + " to x: " + body[s - 1].x + " y: " + body[s - 1].y);
				
				//	We need to keep the x/y/facing values from the snake part, to pass onto the next one in the chain
				
				if (s == 1)
				{
					body[s].x = oldX;
					body[s].y = oldY;
				}
				else
				{
					body[s].x = body[s - 1].x;
					body[s].y = body[s - 1].y;
				}
			}
			
		}
		
	}

}