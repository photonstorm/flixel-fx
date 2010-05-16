package com.photonstorm.harris 
{
	import org.flixel.*;

	public class levelWonState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/level-won-page.png')] private var levelWonPNG:Class;
		
		private var pic:FlxSprite;
		
		public function levelWonState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			pic = new FlxSprite(0, 0, levelWonPNG);
			
			add(pic);
			
			FlxG.score += 40;
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.SPACE)
			{
				FlxG.fade.start(0xff00a0e0, 0.5, returnToRoad);
			}
		}
		
		private function returnToRoad():void
		{
			FlxG.state = new roadState();
		}
		
	}

}