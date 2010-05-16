package com.photonstorm.harris 
{
	import org.flixel.*;
	import org.flixel.FlxGame;

	public class roadState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/road.png')] private var roadPNG:Class;
		[Embed(source = '../../../../assets/harris/ski-hire.png')] private var skiHirePNG:Class;
		
		private var road:FlxSprite;
		private var traffic:trafficGroup;
		private var skiHire1:FlxSprite;
		private var skiHire2:FlxSprite;
		private var player:harrisSprite;
		
		private var stats:FlxText;
		
		private var accident:Boolean = false;
		private var needsSkis:Boolean = true;
		
		private var skiHireHitZone:FlxSprite;
		
		public function roadState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			player = new harrisSprite();
			player.setupRoadSprites();

			road = new FlxSprite(0, 0, roadPNG);
			
			traffic = new trafficGroup();
			
			skiHire1 = new FlxSprite(252, 146, skiHirePNG); // Player appears over the top of this one
			skiHire2 = new FlxSprite(252, 146, skiHirePNG); // Player appears behind this one
			skiHire1.visible = false;
			
			skiHireHitZone = new FlxSprite(273, 161).createGraphic(20, 10, 0xffFF0080);
			
			stats = new FlxText(8, 180, 200, "Money: £" + FlxG.score.toString());
			stats.color = 0xffFF0000;
			
			add(road);
			add(traffic);
			add(skiHire1);
			add(player);
			add(skiHire2);
			add(stats);
		}
		
		private function carHitHarris(obj1:FlxObject, obj2:FlxObject):Boolean
		{
			//trace("hit types: " + FlxU.getClassName(obj1, true) + " 2: " + FlxU.getClassName(obj2, true));
			
			//	obj2 is always the car
			if (player.activeSprite.bottom > obj2.bottom + 6)
			{
				return false;
			}
			
			accident = true;
			
			player.rip();
			
			traffic.crash(carSprite(obj2).lane);
					
			if (FlxG.score < 10)
			{
				FlxG.fade.start(0xffFF0000, 0.5, runOutOfMoney);
			}
			else
			{
				FlxG.score -= 10;
			}
			
			return true;
		}
		
		override public function update():void
		{
			super.update();
			
			stats.text = "Money: £" + FlxG.score.toString();
			
			if (player.isDead == false)
			{
				FlxU.overlap(player.activeSprite, traffic, carHitHarris);
			}
			
			//	Start-up that lane of traffic again :)
			if (accident && player.isDead == false)
			{
				accident = false;
				needsSkis = true;
				traffic.restart();
			}
			
			//	Simple depth sort
			if (player.Y < 160 && skiHire1.visible == true)
			{
				skiHire1.visible = false;
				skiHire2.visible = true;
			}
			else if (player.Y >= 160 && skiHire1.visible == false)
			{
				skiHire1.visible = true;
				skiHire2.visible = false;
			}
			
			//	They needs skis and are in the right place
			if (needsSkis && skiHire1.visible == true)
			{
				if (player.activeSprite.overlaps(skiHireHitZone))
				{
					player.pickUpSkis();
					needsSkis = false;
					
					if (FlxG.score < 20)
					{
						FlxG.fade.start(0xffFF0000, 0.5, runOutOfMoney);
					}
					else
					{
						FlxG.score -= 20;
					}
				}
			}
			
			if (needsSkis == false && player.Y < 16)
			{
				FlxG.fade.start(0xffffffff, 0.5, goSkiing);
			}
		}
		
		private function runOutOfMoney():void
		{
			FlxG.state = new outOfMoneyState();
		}
		
		private function goSkiing():void
		{
			FlxG.state = new skiState();
		}
		
	}

}