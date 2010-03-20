/**
 * FlxCentipede for Flixel 2.23 - 19th March 2010
 * 
 * Cursor keys to move. Ctrl to Fire.
 * 
 * @author Richard Davey, Photon Storm <rich@photonstorm.com>
 */

package  
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	import flash.utils.getTimer;
	
	public class FlxCentipede extends FlxState
	{
		//	We need you (ship), bullets, mushrooms and the centipede
		//	As the centipede moves left, down, right (loop) if he hits a mushroom he drops directly down
		//	If a bullet hits the centipede he splits in two (the part you hit dies), the tail end moves the opposite direction but becomes an independant centipede
		//	Mushrooms are like space invader bases, they take a few shots before they vanish
		//	There is a spider dropping down from time to time
		
		private var player:FlxSprite;
		private var bullets:FlxGroup;
		private var centiHead:FlxSprite;
		private var centipede:FlxGroup;
		private var mushrooms:FlxGroup;
		private var score:FlxText;
		
		private var lastFired:int;
		private var nextMove:int;
		private var centiSpeed:int;
		
		public function FlxCentipede() 
		{
		}
		
		override public function create():void
		{
			centiSpeed = 40;
			nextMove = getTimer() + centiSpeed * 2;
			
			player = new FlxSprite(FlxG.width / 2, FlxG.height - 8).createGraphic(8, 8);
			
			//	Create bullet pool
			
			bullets = new FlxGroup();
			
			for (var b:uint = 0; b < 40; b++)
			{
				var tempBullet:FlxSprite = new FlxSprite().createGraphic(2, 4, 0xFFFFFFFF);
				tempBullet.dead = true;
				tempBullet.exists = false;
				
				bullets.add(tempBullet);
			}
			
			//	Mushrooms
			
			mushrooms = new FlxGroup();
			
			for (var m:uint = 0; m < 40; m++)
			{
				var tx:int = (1 + int(Math.random() * FlxG.width / 8) - 1) * 8;
				var ty:int = (3 + int(Math.random() * FlxG.height / 8) - 6) * 8; // -+3 to stop them appearing at very top/bottom rows
				
				var tempMushroom:FlxSprite = new FlxSprite(tx, ty).createGraphic(8, 8, 0xFFFF0080);
				tempMushroom.health = 8; // 8 shots to kill
				
				mushrooms.add(tempMushroom);
			}
			
			//	Centipede (an array of them, as they split in two?) Or just an array of heads? :)
			//	Let's start with one and see how we get on, it can be 12 long
			
			centipede = new FlxGroup();
			
			for (var c:uint = 0; c < 24; c++)
			{
				var tempCentipede:FlxSprite = new FlxSprite(tx, ty).createGraphic(8, 8, 0xFF00CECE);
				tempCentipede.x = 320 + (c * 8);
				tempCentipede.y = 0;
				
				centipede.add(tempCentipede);
			}
			
			//	Get the head?
			centiHead = centipede.getFirstAlive() as FlxSprite;
			centiHead.facing = FlxSprite.LEFT;
			centiHead.createGraphic(8, 8, 0xFF0FFFFF);
			
			score = new FlxText(0, 0, 200);
			FlxG.score = 0;
			
			add(centipede);
			add(player);
			add(bullets);
			add(mushrooms);
			add(score);
		}
		
		override public function update():void
		{
			super.update();
				
			score.text = "Score: " + FlxG.score.toString();
			
			var oldX:uint = player.x;
			var oldY:uint = player.y;
			
			if (FlxG.keys.LEFT && player.x > 0)
			{
				player.x -= FlxG.elapsed * 150;
			}
			
			if (FlxG.keys.RIGHT && player.x < FlxG.width - 8)
			{
				player.x += FlxG.elapsed * 150;
			}
			
			if (FlxG.keys.UP && player.y > 8)
			{
				player.y -= FlxG.elapsed * 150;
			}
			
			if (FlxG.keys.DOWN && player.y < FlxG.height - 8)
			{
				player.y += FlxG.elapsed * 150;
			}
			
			if (FlxG.keys.CONTROL && getTimer() > lastFired + 75)
			{
				//	Fire
				if (bullets.countDead() > 0)
				{
					var tempBullet:FlxSprite = bullets.getFirstAvail() as FlxSprite;
					
					tempBullet.x = player.x + 4;
					tempBullet.y = player.y;
					tempBullet.exists = true;
					tempBullet.velocity.y = -400;
					tempBullet.acceleration.y = -10;
					
					lastFired = getTimer();
				}
			}
			
			//	Kill bullets off the screen
			for each (var aliveBullet:FlxObject in bullets.members)
			{
				if (aliveBullet.exists && aliveBullet.y < 0)
				{
					aliveBullet.kill();
				}
			}
			
			FlxU.overlap(bullets, mushrooms, bulletVsMushroom);
			
			FlxU.overlap(bullets, centipede);
			
			//	If player overlaps with mushrooms now, then move him back - shit solution, but will work for now
			if (FlxU.overlap(player, mushrooms, noKill))
			{
				player.x = oldX;
				player.y = oldY;
			}
			
			if (getTimer() > nextMove)
			{
				moveCentipede();
				nextMove = getTimer() + centiSpeed;
			}
			
			player.collide(mushrooms);
		}
		
		private function bulletVsMushroom(obj1:FlxObject, obj2:FlxObject):void
		{
			obj1.kill();
			
			obj2.health--;
			
			if (obj2.health == 0)
			{
				obj2.kill();
			}
			else
			{
				//	Eat away at the gfx :)
				
				//obj2 = obj2 as FlxSprite;
				
				//var mushy:FlxSprite = obj2 as FlxSprite;
				
				//var b:BitmapData = obj2.pixels;
				//
				//b.fillRect(new Rectangle(0, 0, 8, obj2.health), 0xFFFF0080);
				//
				//obj2.pixels = b;
			}
		}
		
		private function noKill(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			//trace("no kill");
			return true;
		}
	
		private function moveCentipede():void
		{
			//	Move the head in the direction it is facing
			//	If it hits the edge of the screen it wraps around, or hits a mushroom it drops down 1, then carries on
			
			var oldX:int = centiHead.x;
			var oldY:int = centiHead.y;
			
			switch (centiHead.facing)
			{
				case FlxSprite.LEFT:
					if (centiHead.x == 0)
					{
						centiHead.y += 8;
						centiHead.facing = FlxSprite.RIGHT;
					}
					else
					{
						//	Check it won't hurt a mushroom
						for each (var m:FlxSprite in mushrooms.members)
						{
							if (m.exists)
							{
								if (m.x == centiHead.x - 8 && m.y == centiHead.y)
								{
									//	It will, so drop down
									centiHead.y += 8;
									centiHead.facing = FlxSprite.RIGHT;
									continue;
								}
							}
						}
						
						//	It didn't change direction
						if (centiHead.facing == FlxSprite.LEFT)
						{
							centiHead.x -= 8;
						}
					}
					break;
					
				case FlxSprite.RIGHT:
					if (centiHead.x == FlxG.width - 8)
					{
						centiHead.y += 8;
						centiHead.facing = FlxSprite.LEFT;
					}
					else
					{
						//	Check it won't hurt a mushroom
						for each (var m2:FlxSprite in mushrooms.members)
						{
							if (m2.exists)
							{
								if (m2.x == centiHead.x + 8 && m2.y == centiHead.y)
								{
									//	It will, so drop down
									centiHead.y += 8;
									centiHead.facing = FlxSprite.LEFT;
									continue;
								}
							}
						}
						
						//	It didn't change direction
						if (centiHead.facing == FlxSprite.RIGHT)
						{
							centiHead.x += 8;
						}
					}
					break;
			}
			
			//	And now interate the movement down to the rest of the body parts
			//	The easiest way to do this is simply to work our way backwards through the body pieces!
			
			for (var s:int = centipede.members.length - 1; s > 0; s--)
			{
				//	We need to keep the x/y/facing values from the head part, to pass onto the next one in the chain
				if (s == 1)
				{
					centipede.members[s].x = oldX;
					centipede.members[s].y = oldY;
				}
				else
				{
					centipede.members[s].x = centipede.members[s - 1].x;
					centipede.members[s].y = centipede.members[s - 1].y;
				}
			}
			
		}
		
	}

}