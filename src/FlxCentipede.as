/**
 * FlxCentipede for Flixel 2.23 - 19th March 2010
 * 
 * Cursor keys to move. Ctrl to Fire.
 * 
 * @author Richard Davey, Photon Storm <rich@photonstorm.com>
 */

package  
{
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
		private var centipede:FlxGroup;
		private var mushrooms:FlxGroup;
		private var score:FlxText;
		
		private var lastFired:int;
		private var nextMove:int;
		private var snakeSpeed:int;
		
		public function FlxCentipede() 
		{
		}
		
		override public function create():void
		{
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
				tempMushroom.health = 6; // 6 shots to kill
				
				mushrooms.add(tempMushroom);
			}
			
			//	Centipede (an array of them, as they split in two?) Or just an array of heads? :)
			
			score = new FlxText(0, 0, 200);
			FlxG.score = 0;
			
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
					tempBullet.velocity.y = -100;
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
			
			//	If player overlaps with mushrooms now, then move him back - shit solution, but will work for now
			if (FlxU.overlap(player, mushrooms, noKill))
			{
				player.x = oldX;
				player.y = oldY;
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
		}
		
		private function noKill(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			trace("no kill");
			return true;
		}
		
	}

}