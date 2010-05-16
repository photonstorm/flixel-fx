package com.photonstorm.harris 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import org.flixel.*;

	public class skiSlopeGroup extends FlxGroup
	{
		[Embed(source = '../../../../assets/harris/billboard.png')] private var billboardPNG:Class;
		[Embed(source = '../../../../assets/harris/finish.png')] private var finishPNG:Class;
		[Embed(source = '../../../../assets/harris/flags_blue.png')] private var flagsBluePNG:Class;
		[Embed(source = '../../../../assets/harris/flags_red.png')] private var flagsRedPNG:Class;
		[Embed(source = '../../../../assets/harris/hole.png')] private var holePNG:Class;
		[Embed(source = '../../../../assets/harris/snowman.png')] private var snowmanPNG:Class;
		[Embed(source = '../../../../assets/harris/tree.png')] private var treePNG:Class;
		
		private var scrollSpeed:uint = 40;
		
		public var finishY:int;
		
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
			
			//trace("build level");
			//trace(source.numChildren);
			
			for (var i:uint = 0; i < source.numChildren; i++)
			{
				var t:DisplayObject = DisplayObject(source.getChildAt(i));
				
				//trace(FlxU.getClassName(t, true));
				//trace(FlxU.getClassName(source.getChildAt(i), true));
				
				var tempSprite:FlxSprite;
				
				switch (FlxU.getClassName(source.getChildAt(i), true))
				{
					case "billboard":
						tempSprite = new FlxSprite(t.x, t.y, billboardPNG);
						break;
					
					case "finish":
						tempSprite = new FlxSprite(t.x, t.y, finishPNG);
						finishY = t.y + t.height;
						break;
					
					case "flagsBlue":
						tempSprite = new FlxSprite(t.x, t.y, flagsBluePNG);
						break;
					
					case "flagsRed":
						tempSprite = new FlxSprite(t.x, t.y, flagsRedPNG);
						break;
					
					case "hole":
						tempSprite = new FlxSprite(t.x, t.y, holePNG);
						break;
					
					case "snowman":
						tempSprite = new FlxSprite(t.x, t.y, snowmanPNG);
						break;
					
					case "tree":
						tempSprite = new FlxSprite(t.x, t.y, treePNG);
						break;
				}
				
				tempSprite.sname = FlxU.getClassName(source.getChildAt(i), true);
				add(tempSprite);
				
			}
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (ripSequence == false)
			{
				for each (var s:FlxSprite in members)
				{
					s.y -= FlxG.elapsed * scrollSpeed;
				}
			}
			
		}
		
	}

}