package com.photonstorm.harris 
{
	import org.flixel.*;
	import org.flixel.FlxGame;

	public class playState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/road.png')] private var roadPNG:Class;
		
		private var road:FlxSprite;
		
		
		
		public function playState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			road = new FlxSprite(0, 0, roadPNG);
			
			add(road);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}