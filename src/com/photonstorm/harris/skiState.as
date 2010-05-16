package com.photonstorm.harris 
{
	import org.flixel.*;

	public class skiState extends FlxState
	{
		private var snow:FlxSprite;
		private var player:harrisSprite;
		private var slope:skiSlopeGroup;
		
		private var stats:FlxText;
		
		public function skiState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			snow = new FlxSprite().createGraphic(FlxG.width, FlxG.height);
			
			player = new harrisSprite();
			player.setupSkiingSprites();
			
			slope = new skiSlopeGroup();
			
			stats = new FlxText(8, 180, 200, "Money: £" + FlxG.score.toString());
			stats.color = 0xffFF0000;

			add(snow);
			add(slope);
			add(player);
			add(stats);
		}
		
		private function slopeHitHarris(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			//trace("hit types: " + FlxU.getClassName(obj1, true) + " 2: " + FlxU.getClassName(obj2, true));
			
			//	obj2 is always the slope item
			if (player.activeSprite.bottom > obj2.bottom + 6)
			{
				return false;
			}
			
			switch (obj2.sname)
			{
				case "tree":
				case "billboard":
					player.rip();
					slope.ripSequence = true;
					break;
					
				case "finish":
					break;
				
				case "flagsBlue":
					FlxG.score += 10;
					return false;
					break;
				
				case "flagsRed":
					FlxG.score += 10;
					return false;
					break;
				
				case "hole":
					break;
					
				case "snowman":
					break;
			}
			
			return true;
		}
		
		override public function update():void
		{
			super.update();
			
			stats.text = "Money: £" + FlxG.score.toString();
			
			if (player.isDead == false)
			{
				FlxU.overlap(player.activeSprite, slope, slopeHitHarris);
			}
		}
			
		
	}

}