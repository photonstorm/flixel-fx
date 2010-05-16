package com.photonstorm.harris 
{
	import org.flixel.*;

	public class skiState extends FlxState
	{
		private var snow:FlxSprite;
		private var player:harrisSprite;
		private var slope:skiSlopeGroup;
		
		private var stats:FlxText;
		
		private var skiDamage:int;
		private var accident:Boolean;
		
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
			
			skiDamage = 3;
			accident = false;
			
			add(snow);
			add(player);
			add(slope);
			add(stats);
		}
		
		private function slopeHitHarris(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			if (accident)
			{
				return false;
			}
			
			//	obj2 is always the slope item
			if (player.activeSprite.bottom > obj2.bottom + 6)
			{
				return false;
			}
			
			var i:slopeItemSprite = slopeItemSprite(obj2);
			
			switch (i.type)
			{
				case "tree":
				case "billboard":
				case "flagBlue":
				case "flagRed":
					player.rip();
					slope.ripSequence = true;
					break;
					
				case "finish":
					if (player.activeSprite.left < i.left + 2 || (player.activeSprite.left > i.right - 12 && player.activeSprite.left < i.right))
					{
						player.rip();
						slope.ripSequence = true;
					}
					else
					{
						FlxG.fade.start(0xff00a0e0, 0.5, levelWon);
						return false;
					}
					break;
					
				case "flagZone":
					FlxG.scores[0] += 10;
					return false;
					break;
				
				case "hole":
					break;
					
				case "snowman":
					if (player.isSnow == false)
					{
						player.isSnow = true;
					}
					return false;
					break;
			}
			
			accident = true;
			return true;
		}
		
		override public function update():void
		{
			super.update();
			
			stats.text = "Money: £" + FlxG.score.toString() + "     Score: " + FlxG.scores[0].toString();
			
			if (player.isDead == false)
			{
				FlxU.overlap(player.activeSprite, slope, slopeHitHarris);
			}
			
			//	Start-up the slope again!
			if (accident && player.isDead == false)
			{
				accident = false;
				skiDamage--;
				if (skiDamage == 0)
				{
					//	End skiing
					FlxG.fade.start(0xff00a0e0, 0.5, skisDamaged);
				}
				else
				{
					slope.restart();
				}
			}
			
			//	Check end of level
			if (slope.finishFlag.bottom < 0)
			{
				//	Missed the finish flag!
				FlxG.fade.start(0xff00a0e0, 0.5, returnToRoad);
			}
		}
		
		private function levelWon():void
		{
			FlxG.state = new levelWonState();
		}
		
		private function returnToRoad():void
		{
			FlxG.state = new roadState();
		}
		
		private function skisDamaged():void
		{
			FlxG.state = new skisDamagedState();
		}
		
	}

}