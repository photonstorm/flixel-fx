package com.photonstorm.harris 
{
	import org.flixel.*;

	public class skisDamagedState extends FlxState
	{
		[Embed(source = '../../../../assets/harris/skis-broken-page.png')] private var skisBrokenPNG:Class;
		
		private var pic:FlxSprite;
		
		public function skisDamagedState() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			pic = new FlxSprite(0, 0, skisBrokenPNG);
			
			add(pic);
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