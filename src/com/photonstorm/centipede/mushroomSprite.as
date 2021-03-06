﻿package com.photonstorm.centipede 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.flixel.*;

	public class mushroomSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/centipede/mushroom.png')] private var mushroomPNG:Class;
		
		public function mushroomSprite(_x:uint, _y:uint) 
		{
			super(_x, _y);
			
			this.loadGraphic(mushroomPNG, false, false, 16, 16, true);
			
			health = 16;
			
			//	Remove this and the mushrooms can be "pushed" by you :)
			fixed = true;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function shot():void
		{
			//	Eat away at the gfx :)
			health -= 2;
			
			if (health > 0)
			{
				var bmd:BitmapData = pixels;
				
				bmd.fillRect(new Rectangle(0, health, 16, 2), 0x00000000);
				
				pixels = bmd;
			}
			else
			{
				//	Actual kill! :)
				exists = false;
				dead = true;
			}
			
		}
		
	}

}