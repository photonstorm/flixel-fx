package com.photonstorm.harris 
{
	import org.flixel.*;

	public class outOfMoneyState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/no-money-page.png')] private var noMoneyPNG:Class;
		
		private var pic:FlxSprite;
		
		public function outOfMoneyState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			pic = new FlxSprite(0, 0, noMoneyPNG);
			
			add(pic);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.SPACE)
			{
				FlxG.fade.start(0xff00a0e0, 0.5, returnToMenu);
			}
		}
		
		private function returnToMenu():void
		{
			FlxG.state = new menuState();
		}
		
	}

}