package com.photonstorm.harris 
{
	import org.flixel.*;
	import flash.utils.getTimer;
	
	public class trafficGroup extends FlxGroup
	{
		private var lane1Timer:int;
		private var lane2Timer:int;
		private var lane3Timer:int;
		private var lane4Timer:int;
		private var lane5Timer:int;
		
		public var lane1Crash:Boolean;
		public var lane2Crash:Boolean;
		public var lane3Crash:Boolean;
		public var lane4Crash:Boolean;
		public var lane5Crash:Boolean;
		
		private var releaseRate:int;
		
		public function trafficGroup() 
		{
			super();
			
			lane1Timer = getTimer() + int(Math.random() * 1500);
			lane2Timer = getTimer() + int(Math.random() * 1500);
			lane3Timer = getTimer() + int(Math.random() * 1500);
			lane4Timer = getTimer() + int(Math.random() * 1500);
			lane5Timer = getTimer() + int(Math.random() * 1500);
			
			lane1Crash = false;
			lane2Crash = false;
			lane3Crash = false;
			lane4Crash = false;
			lane5Crash = false;
			
			var minSpeed:int;
			var maxSpeed:int;
			
			switch (FlxG.level)
			{
				case 1:
					minSpeed = 60;
					maxSpeed = 80;
					releaseRate = 5000;
					break;
					
				case 2:
					minSpeed = 70;
					maxSpeed = 90;
					releaseRate = 4500;
					break;
					
				case 3:
					minSpeed = 80;
					maxSpeed = 100;
					releaseRate = 4000;
					break;
					
				case 4:
					minSpeed = 90;
					maxSpeed = 110;
					releaseRate = 3500;
					break;
					
				case 5:
					minSpeed = 100;
					maxSpeed = 120;
					releaseRate = 3000;
					break;
			}
			
			for (var c:uint = 0; c < 25; c++)
			{
				var tempCar:carSprite = new carSprite(minSpeed, maxSpeed);
				
				tempCar.exists = false;
				
				add(tempCar);
			}
		}
		
		public function crash(lane:int):void
		{
			for each (var c:carSprite in members)
			{
				if (c.lane == lane)
				{
					//c.crash();
					c.exists = false;
				}
			}
			
			switch (lane)
			{
				case 1:
					lane1Crash = true; break;
					
				case 2:
					lane2Crash = true; break;
					
				case 3:
					lane3Crash = true; break;
					
				case 4:
					lane4Crash = true; break;
					
				case 5:
					lane5Crash = true; break;
			}
		}
		
		public function restart():void
		{
			if (lane1Crash)
			{
				lane1Crash = false;
			}
			
			if (lane2Crash)
			{
				lane2Crash = false;
			}
			
			if (lane3Crash)
			{
				lane3Crash = false;
			}
			
			if (lane4Crash)
			{
				lane4Crash = false;
			}
			
			if (lane5Crash)
			{
				lane5Crash = false;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (getTimer() > lane1Timer && lane1Crash == false)
			{
				carSprite(getFirstAvail()).activate(1);
				lane1Timer = getTimer() + 3000 + int(Math.random() * releaseRate);
			}
			
			if (getTimer() > lane2Timer && lane2Crash == false)
			{
				carSprite(getFirstAvail()).activate(2);
				lane2Timer = getTimer() + 3000 + int(Math.random() * releaseRate);
			}
			
			if (getTimer() > lane3Timer && lane3Crash == false)
			{
				carSprite(getFirstAvail()).activate(3);
				lane3Timer = getTimer() + 3000 + int(Math.random() * releaseRate);
			}
			
			if (getTimer() > lane4Timer && lane4Crash == false)
			{
				carSprite(getFirstAvail()).activate(4);
				lane4Timer = getTimer() + 3000 + int(Math.random() * releaseRate);
			}
			
			if (getTimer() > lane5Timer && lane5Crash == false)
			{
				carSprite(getFirstAvail()).activate(5);
				lane5Timer = getTimer() + 3000 + int(Math.random() * releaseRate);
			}
		}
		
		
	}

}