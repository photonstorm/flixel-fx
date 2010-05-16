package com.photonstorm.harris 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import org.flixel.*;

	public class skiSlopeGroup extends FlxGroup
	{
		private var scrollSpeed:uint = 40;
		
		public var finishFlag:slopeItemSprite;
		
		public var ripSequence:Boolean = false;
		
		public function skiSlopeGroup() 
		{
			super();
			
			buildLevel();
		}
		
		private function buildLevel():void
		{
			var source:MovieClip;
			
			source = new level1();
			
			for (var i:uint = 0; i < source.numChildren; i++)
			{
				var t:DisplayObject = DisplayObject(source.getChildAt(i));
				
				add(new slopeItemSprite(t.x, t.y, FlxU.getClassName(source.getChildAt(i), true)));
				
				if (FlxU.getClassName(source.getChildAt(i), true) == "finish")
				{
					finishFlag = members[members.length - 1];
				}
			}
		}
		
		public function restart():void
		{
			for each (var s:slopeItemSprite in members)
			{
				s.slopeReset();
			}
			
			ripSequence = false;
		}
		
		override public function update():void
		{
			super.update();
			
			if (ripSequence == false)
			{
				for each (var s:slopeItemSprite in members)
				{
					s.y -= FlxG.elapsed * scrollSpeed;
				}
			}
			
		}
		
	}

}