package com.photonstorm.harris 
{
	import org.flixel.*;

	public class carSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/harris/car1.png')] private var car1PNG:Class;
		[Embed(source = '../../../../assets/harris/car2.png')] private var car2PNG:Class;
		[Embed(source = '../../../../assets/harris/car3.png')] private var car3PNG:Class;
		[Embed(source = '../../../../assets/harris/car4.png')] private var car4PNG:Class;
		[Embed(source = '../../../../assets/harris/car5.png')] private var car5PNG:Class;
		[Embed(source = '../../../../assets/harris/car6.png')] private var car6PNG:Class;
		[Embed(source = '../../../../assets/harris/car7.png')] private var car7PNG:Class;
		[Embed(source = '../../../../assets/harris/car8.png')] private var car8PNG:Class;
		
		public var hasCrashed:Boolean;
		public var lane:int;
		private var speed:int;
		private var minSpeed:int;
		private var maxSpeed:int;
		
		//	All PNGs are facing left by default
		
		public function carSprite(_minSpeed:int, _maxSpeed:int) 
		{
			super();
			
			hasCrashed = false;
			minSpeed = _minSpeed;
			maxSpeed = _maxSpeed;
			
			switch (int(Math.random() * 7))
			{
				case 0:
					loadGraphic(car1PNG, false, true);
					break;
				case 1:
					loadGraphic(car2PNG, false, true);
					break;
				case 2:
					loadGraphic(car3PNG, false, true);
					break;
				case 3:
					loadGraphic(car4PNG, false, true);
					break;
				case 4:
					loadGraphic(car5PNG, false, true);
					break;
				case 5:
					loadGraphic(car6PNG, false, true);
					break;
				case 6:
					loadGraphic(car7PNG, false, true);
					break;
				case 7:
					loadGraphic(car8PNG, false, true);
					break;
			}
					
			offset.y = height - 10;
			height = 10;
		}
		
		public function activate(_lane:int):void
		{
			lane = _lane;
			speed = minSpeed + int(Math.random() * (maxSpeed - minSpeed));
			hasCrashed = false;
			
			//	46   70   95   126    159
			switch (lane)
			{
				case 1:
					y = 46 - height;
					facing = FlxSprite.RIGHT;
					x = 0 - width;
					break;
					
				case 2:
					y = 70 - height;
					facing = FlxSprite.RIGHT;
					x = 0 - width;
					break;
					
				case 3:
					y = 95 - height;
					facing = FlxSprite.LEFT;
					x = FlxG.width;
					break;
					
				case 4:
					y = 126 - height;
					facing = FlxSprite.LEFT;
					x = FlxG.width;
					break;
					
				case 5:
					y = 159 - height;
					facing = FlxSprite.RIGHT;
					x = 0 - width;
					break;
			}
			
			exists = true;
		}
		
		public function crash():void
		{
			hasCrashed = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if (hasCrashed == false)
			{
				if (facing == FlxSprite.LEFT)
				{
					x -= FlxG.elapsed * speed;
					
					if (x < 0 - width)
					{
						exists = false;
					}
				}
				else
				{
					x += FlxG.elapsed * speed;
					
					if (x > FlxG.width)
					{
						exists = false;
					}
				}
			}
			
		}
		
	}

}