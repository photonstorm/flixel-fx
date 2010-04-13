/**
 * FlxCentipede for Flixel 2.23 - 19th March 2010
 * 
 * Cursor keys to move. Ctrl to Fire.
 * 
 * @author Richard Davey, Photon Storm <rich@photonstorm.com>
 */

package com.photonstorm.centipede
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	import flash.utils.getTimer;
	
	public class FlxCentipede extends FlxState
	{
		//	We need you (ship), bullets, mushrooms and the centipede
		//	As the centipede moves left, down, right (loop) if he hits a mushroom he drops directly down
		//	If a bullet hits the centipede he splits in two (the part you hit dies), the tail end moves the opposite direction but becomes an independant centipede
		//	Mushrooms are like space invader bases, they take a few shots before they vanish
		//	There is a spider dropping down from time to time, collision kills
		[Embed(source = '../../../../assets/centipede/ground.png')] private var groundPNG:Class;
		
		private var player:playerSprite;
		private var bullets:bulletGroup;
		private var centipede:centipedeGroup;
		private var centipede2:centipedeGroup;
		private var mushrooms:mushroomGroup;
		private var background:FlxSprite;
		private var score:FlxText;
		
		public function FlxCentipede() 
		{
		}
		
		override public function create():void
		{
			bullets = new bulletGroup();
			player = new playerSprite(bullets);
			mushrooms = new mushroomGroup(40);
			centipede = new centipedeGroup(8, mushrooms, 160, true);
			//centipede2 = new centipedeGroup(6, mushrooms, 200, false);
			
			score = new FlxText(0, 0, 200);
			FlxG.score = 0;
			
			//background = FlxGradient.createGradientFlxSprite(320, 240, [0x0000FF, 0x8000FF, 0x800000], 4);
			
			var ground:Bitmap = new groundPNG();
			
			background = new FlxSprite(0, 0).createGraphic(FlxG.width, FlxG.height, 0x00000000, true);
			
			var tempB:BitmapData = background.pixels;
			
			for (var by:uint = 0; by < FlxG.height; by += 16)
			{
				for (var bx:uint = 0; bx < FlxG.width; bx += 16)
				{
					var t:uint = int(Math.random() * 7) * 16;
					
					tempB.copyPixels(ground.bitmapData, new Rectangle(t, 0, 16, 16), new Point(bx, by));
				}
			}
			
			background.pixels = tempB;
			
			add(background);
			add(bullets);
			add(centipede);
			//add(centipede2);
			add(player);
			add(mushrooms);
			add(score);
		}
		
		override public function update():void
		{
			super.update();
				
			score.text = "Score: " + FlxG.score.toString();
			
			FlxU.collide(player, mushrooms);
			
			FlxU.overlap(bullets, mushrooms, bulletsVsMushrooms);
			
			FlxU.overlap(bullets, centipede, bulletsVsCentipede);
			
			//FlxU.overlap(bullets, centipede2, bulletsVsCentipede);
		}
		
		/**
		 * Run collision between a bullet and a mushroom
		 * 
		 * @param	obj1	The Bullet
		 * @param	obj2	The Mushroom (cast to mushroomSprite)
		 * @return	boolean
		 */
		private function bulletsVsMushrooms(bullet:FlxObject, obj2:FlxObject):Boolean
		{
			var mushroom:mushroomSprite = obj2 as mushroomSprite;
			
			mushroom.shot();
			
			bullet.kill();
			
			return true;
		}
		
		/**
		 * Run collision between a bullet and a centipede segment
		 * 
		 * @param	obj1	The Bullet
		 * @param	obj2	The Centipede (cast to centipedeSprite)
		 * @return	boolean
		 */
		private function bulletsVsCentipede(bullet:FlxObject, obj2:FlxObject):Boolean
		{
			var segment:centipedeSprite = obj2 as centipedeSprite;
			
			//	Incase two or more bullets are overlapping with this segment
			if (segment.exists)
			{
				//	Spawn a mushroom at the segments x/y
				mushrooms.spawnMushroom(segment.x, segment.y, true);
				
				//	Kill the segment (spawning a new head perhaps? handled by centipedeGroup)
				segment.shot();
			}
			
			bullet.kill();
			
			return true;
		}
		
	}

}