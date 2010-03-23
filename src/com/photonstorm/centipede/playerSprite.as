package com.photonstorm.centipede 
{
	import org.flixel.*;
	
	import flash.utils.getTimer;
	
	public class playerSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/centipede/player.png')] private var playerPNG:Class;
		
		private var bullets:bulletGroup;
		private var lastFired:int;
		
		public function playerSprite(bulletsRef:bulletGroup) 
		{
			super(FlxG.width / 2, FlxG.height - 10, playerPNG);
			
			bullets = bulletsRef;
			
			velocity.x = 0;
			velocity.y = 0;
			maxVelocity.x = 100;
			maxVelocity.y = 100;
			acceleration.x = 0;
			acceleration.y = 0;
		}
		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
				
			//	Need to adds bound checking to these (as it can probably go too far left right now)
			if (FlxG.keys.LEFT && x > 0)
			{
				velocity.x -= 150;
			}
			
			if (FlxG.keys.RIGHT && x < FlxG.width - width)
			{
				velocity.x += 150;
			}
			
			if (FlxG.keys.UP && y >= 192)
			{
				velocity.y -= 150;
				
				if (y < 192)
				{
					y = 192;
				}
			}
			
			if (FlxG.keys.DOWN && y < FlxG.height - height)
			{
				velocity.y += 150;
			}
			
			//	Evaluate everything else
			super.update();
			
			if (FlxG.keys.CONTROL && getTimer() > lastFired + 75)
			{
				if (bullets.fire(x, y))
				{
					lastFired = getTimer();
				}
			}
		}
		
	}

}