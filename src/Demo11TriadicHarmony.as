package  
{
	import org.flixel.*;

	public class Demo11TriadicHarmony extends FlxState
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
		
		public function Demo11TriadicHarmony() 
		{
		}
		
		override public function create():void
		{
			//	Demonstrates the Triadic Color Harmony
			
			color1 = FlxColor.getRandomColor(50);
			
			var triadic:Object = FlxColor.getTriadicHarmony(color1);
			
			color1S = new FlxSprite(0, 0).createGraphic(32, 32, color1);
			color2S = new FlxSprite(0, 64).createGraphic(32, 32, triadic.color2);
			color3S = new FlxSprite(0, 128).createGraphic(32, 32, triadic.color3);
			
			colorInfo1 = new FlxText(64, 0, 600, FlxColor.getColorInfo(color1));
			colorInfo2 = new FlxText(64, 64, 600, FlxColor.getColorInfo(triadic.color2));
			colorInfo3 = new FlxText(64, 128, 600, FlxColor.getColorInfo(triadic.color3));
			
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
			
				var triadic:Object = FlxColor.getTriadicHarmony(color1);
				
				color1S.fill(color1);
				color2S.fill(triadic.color2);
				color3S.fill(triadic.color3);
				
				colorInfo1.text = FlxColor.getColorInfo(color1);
				colorInfo2.text = FlxColor.getColorInfo(triadic.color2);
				colorInfo3.text = FlxColor.getColorInfo(triadic.color3);
			}
			
		}
		
	}

}