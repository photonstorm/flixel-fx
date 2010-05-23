package com.photonstorm.harris 
{
	import org.flixel.FlxSprite;

	public class slopeItemSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/harris/billboard.png')] private var billboardPNG:Class;
		[Embed(source = '../../../../assets/harris/finish.png')] private var finishPNG:Class;
		[Embed(source = '../../../../assets/harris/flag_zone.png')] private var flagZonePNG:Class;
		[Embed(source = '../../../../assets/harris/flag_blue.png')] private var flagBluePNG:Class;
		[Embed(source = '../../../../assets/harris/flag_red.png')] private var flagRedPNG:Class;
		[Embed(source = '../../../../assets/harris/hole.png')] private var holePNG:Class;
		[Embed(source = '../../../../assets/harris/snowman.png')] private var snowmanPNG:Class;
		[Embed(source = '../../../../assets/harris/tree.png')] private var treePNG:Class;
		
		public var type:String;
		private var startingX:int;
		private var startingY:int;
		
		public function slopeItemSprite(_x:int, _y:int, _type:String) 
		{
			super(_x, _y);
			
			type = _type;
			startingX = _x;
			startingY = _y;
			
			switch (type)
			{
				case "billboard":
					loadGraphic(billboardPNG);
					break;
				
				case "finish":
					loadGraphic(finishPNG);
					height = 8;
					offset.y = 36-8;
					break;
				
				case "flagBlue":
					loadGraphic(flagBluePNG);
					width = 2;
					height = 16;
					offset.y = 16;
					break;
					
				case "flagZone":
					loadGraphic(flagZonePNG);
					this.visible = false;
					break;
				
				case "hole":
					loadGraphic(holePNG);
					break;
				
				case "snowman":
					loadGraphic(snowmanPNG);
					break;
				
				case "tree":
					loadGraphic(treePNG);
					width = 13;
					height = 25;
					offset.x = 6;
					offset.y = 4;
					break;
			}
		}
		
		public function slopeReset():void
		{
			x = startingX;
			y = startingY;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}