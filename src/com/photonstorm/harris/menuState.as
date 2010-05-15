package com.photonstorm.harris 
{
	import com.photonstorm.centipede.playerSprite;
	import org.flixel.*;
	import org.flixel.FlxGame;
	
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
				FlxG.fade.start(0xff00FFFF, 1, playGame);
			}
		}
		
		private function playGame():void
		{
			FlxG.state = new playState();
		}
		
	}

}