package com.photonstorm.harris 
{
	import org.flixel.*;
	
	public class menuState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/title-page.png')] private var titlePNG:Class;
		
		private var pic:FlxSprite;
		
		public function menuState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			pic = new FlxSprite(0, 0, titlePNG);
			
			add(pic);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.SPACE)
			{
				FlxG.fade.start(0xff00a0e0, 0.5, playGame);
			}
		}
		
		private function playGame():void
		{
			FlxG.score = 30;
			
			FlxG.state = new roadState();
			//FlxG.state = new skiState();
		}
		
	}

}