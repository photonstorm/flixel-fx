package  
{
	import org.flixel.*;

	public class Demo13SplitComplementHarmony extends FlxState
	{
		private var color1:int;
		private var color2:int;
		private var color3:int;
		
		private var color1S:FlxSprite;
		private var color2S:FlxSprite;
		private var color3S:FlxSprite;
		
		private var colorInfo1:FlxText;
		private var colorInfo2:FlxText;
		private var colorInfo3:FlxText;
		
		public function Demo13SplitComplementHarmony() 
		{
		}
		
		override public function create():void
		{
			//	Demonstrates the Split Complement Color Harmony
			
			color1 = FlxColor.getRandomColor(50);
			
			var split:Object = FlxColor.getSplitComplementHarmony(color1);
			
			color1S = new FlxSprite(320, 240).createGraphic(200, 8, color1);
			color1S.angle = split.hue1;
			
			color2S = new FlxSprite(320, 240).createGraphic(200, 8, split.color2);
			color2S.angle = split.hue2;
			
			color3S = new FlxSprite(320, 240).createGraphic(200, 8, split.color3);
			color3S.angle = split.hue3;
			
			colorInfo1 = new FlxText(0, 0, 600, FlxColor.getColorInfo(color1));
			colorInfo2 = new FlxText(0, 64, 600, FlxColor.getColorInfo(split.color2));
			colorInfo3 = new FlxText(0, 128, 600, FlxColor.getColorInfo(split.color3));
			
			colorInfo1.color = color1;
			colorInfo2.color = split.color2;
			colorInfo3.color = split.color3;
			
			add(color1S);
			add(color2S);
			add(color3S);
			
			add(colorInfo1);
			add(colorInfo2);
			add(colorInfo3);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.mouse.justPressed())
			{
				color1 = FlxColor.getRandomColor(50);
			
				var split:Object = FlxColor.getSplitComplementHarmony(color1);
				
				color1S.fill(color1);
				color2S.fill(split.color2);
				color3S.fill(split.color3);
			
				color1S.angle = split.hue1;
				color2S.angle = split.hue2;
				color3S.angle = split.hue3;
				
				colorInfo1.text = FlxColor.getColorInfo(color1);
				colorInfo2.text = FlxColor.getColorInfo(split.color2);
				colorInfo3.text = FlxColor.getColorInfo(split.color3);
				
				colorInfo1.color = color1;
				colorInfo2.color = split.color2;
				colorInfo3.color = split.color3;
			}
			
		}
		
	}

}