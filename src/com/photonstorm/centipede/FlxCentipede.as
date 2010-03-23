/**
 * FlxCentipede for Flixel 2.23 - 19th March 2010
 * 
 * Cursor keys to move. Ctrl to Fire.
 * 
 * @author Richard Davey, Photon Storm <rich@photonstorm.com>
 */

package com.photonstorm.centipede
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
		
		[Embed(source = '../../../../assets/centipede/player.png')] private var playerPNG:Class;
		
		private var player:FlxSprite;
		private var bullets:bulletGroup;
		private var centipede:centipedeGroup;
		private var mushrooms:mushroomGroup;
		private var background:FlxSprite;
		private var score:FlxText;
		
		private var lastFired:int;
		
		public function FlxCentipede() 
		{
		}
		
		override public function create():void
		{
			player = new FlxSprite(FlxG.width / 2, FlxG.height - 10, playerPNG);
			
			bullets = new bulletGroup();
			mushrooms = new mushroomGroup(50);
			centipede = new centipedeGroup(12, mushrooms);
			
			score = new FlxText(0, 0, 200);
			FlxG.score = 0;
			
			background = FlxGradient.createGradientFlxSprite(320, 240, [0x0000FF, 0x8000FF, 0x800000], 4);
			
			add(background);
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
			
			if (FlxG.keys.RIGHT && player.x < FlxG.width - player.width)
			{
				player.x += FlxG.elapsed * 150;
			}
			
			if (FlxG.keys.UP && player.y >= 192)
			{
				player.y -= FlxG.elapsed * 150;
				
				if (player.y < 192)
				{
					player.y = 192;
				}
			}
			
			if (FlxG.keys.DOWN && player.y < FlxG.height - player.height)
			{
				player.y += FlxG.elapsed * 150;
			}
			
			//	Need to adds bound checking to these (as it can probably go too far left right now)
			
			if (FlxG.keys.CONTROL && getTimer() > lastFired + 75)
			{
				if (bullets.fire(player.x, player.y))
				{
					lastFired = getTimer();
				}
			}
			
			//	We've over-ridden the kill method of the mushrooms to handle the custom death!
			
			FlxU.overlap(bullets, mushrooms);
			FlxU.overlap(bullets, centipede);
			
			//	If player overlaps with mushrooms now, then move him back - shit solution, but will work for now
			if (FlxU.overlap(player, mushrooms, noKill))
			{
				player.x = oldX;
				player.y = oldY;
			}
			
			player.collide(mushrooms);
		}
		
		private function noKill(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			//trace("no kill");
			return true;
		}
	}

}