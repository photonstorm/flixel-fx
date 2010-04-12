package  
{
	import flash.geom.Point;
	
	import org.flixel.*;

	public class TextInput extends FlxState
	{
		private var bg:FlxSprite;
		private var t:FlxInputText;
		
		public function TextInput() 
		{
		}
		
		override public function create():void
		{
			bg = new FlxSprite(0, 0).createGraphic(100, 100, 0xFFFF8000);
			
			t = new FlxInputText(0, 0, 200, 100, "Wibble", 0xFFFFFFFF);
			
			add(bg);
			add(t);
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();
		}
		
		
	}

}