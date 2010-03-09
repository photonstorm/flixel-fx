package  
{
	import org.flixel.*;

	public class Demo10ColorTests extends FlxState
	{
		private var color1:int;
		private var color2:int;
		
		private var color1S:FlxSprite;
		private var color2S:FlxSprite;
		
		private var colorInfo1:FlxText;
		private var colorInfo2:FlxText;
		
		public function Demo10ColorTests() 
		{
		}
		
		override public function create():void
		{
			//	Demonstrates the Complement Color Harmony
			
			color1 = FlxColor.getRandomColor(50);
			color2 = FlxColor.getComplementHarmony(color1);
			
			color1S = new FlxSprite(0, 0).createGraphic(32, 32, color1);
			color2S = new FlxSprite(0, 64).createGraphic(32, 32, color2);
			
			colorInfo1 = new FlxText(64, 0, 600, FlxColor.getColorInfo(color1));
			colorInfo2 = new FlxText(64, 64, 600, FlxColor.getColorInfo(color2));
			
			add(color1S);
			add(color2S);
			
			add(colorInfo1);
			add(colorInfo2);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.mouse.justPressed())
			{
				color1 = FlxColor.getRandomColor(50);
				color2 = FlxColor.getComplementHarmony(color1);
				
				color1S.fill(color1);
				color2S.fill(color2);
				
				colorInfo1.text = FlxColor.getColorInfo(color1);
				colorInfo2.text = FlxColor.getColorInfo(color2);
			}
			
		}
		
	}

}