package  
{
	import org.flixel.*;

	public class Demo12AnalogousHarmony extends FlxState
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
		
		public function Demo12AnalogousHarmony() 
		{
		}
		
		override public function create():void
		{
			//	Demonstrates the Analogous Color Harmony
			
			color1 = FlxColor.getRandomColor(50);
			
			var analogous:Object = FlxColor.getAnalogousHarmony(color1);
			
			color1S = new FlxSprite(0, 0).createGraphic(32, 32, color1);
			color2S = new FlxSprite(0, 64).createGraphic(32, 32, analogous.color2);
			color3S = new FlxSprite(0, 128).createGraphic(32, 32, analogous.color3);
			
			colorInfo1 = new FlxText(64, 0, 600, FlxColor.getColorInfo(color1));
			colorInfo2 = new FlxText(64, 64, 600, FlxColor.getColorInfo(analogous.color2));
			colorInfo3 = new FlxText(64, 128, 600, FlxColor.getColorInfo(analogous.color3));
			
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
			
				var analogous:Object = FlxColor.getAnalogousHarmony(color1);
				
				color1S.fill(color1);
				color2S.fill(analogous.color2);
				color3S.fill(analogous.color3);
				
				colorInfo1.text = FlxColor.getColorInfo(color1);
				colorInfo2.text = FlxColor.getColorInfo(analogous.color2);
				colorInfo3.text = FlxColor.getColorInfo(analogous.color3);
			}
			
		}
		
	}

}