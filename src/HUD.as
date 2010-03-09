package  
{
	import org.flixel.*;
	
	public class HUD extends FlxGroup
	{
		private var _bkgrnd:FlxSprite;
		private var _power_bg:FlxSprite;
		private var _power_fg:FlxSprite;
		private var _power_txt:FlxSprite;
		private var debug:FlxText;
		
		private var s:int = 1;
		
		public function HUD() 
		{
			_bkgrnd = new FlxSprite();
			_power_bg = new FlxSprite();
			_power_fg = new FlxSprite();
			
			_bkgrnd.createGraphic(640, 30, 0xff000000);
			_power_bg.createGraphic(80, 15, 0xff670000);
			_power_fg.createGraphic(1, 15, 0xffff0000);
			
			_bkgrnd.scrollFactor.x = _bkgrnd.scrollFactor.y = 0;
			_power_bg.scrollFactor.x = _power_bg.scrollFactor.y = 0;
			_power_fg.scrollFactor.x = _power_fg.scrollFactor.y = 0;
			
			_power_fg.scale.x = s;
			
			_power_bg.x = 20;
			_power_fg.x = 20 + (_power_fg.scale.x / 2);
			
			debug = new FlxText(0, 32, 100, "Scale: 1");

			add(_bkgrnd);
			add(_power_bg);
			add(_power_fg);
			add(debug);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.UP)
			{
				s++;
				
				debug.text = "Scale: " + s;
			
				_power_fg.scale.x = s;
				_power_fg.x = 20 + (_power_fg.scale.x / 2);
			}
			
			if (FlxG.keys.DOWN)
			{
				s--;
				
				debug.text = "Scale: " + s;
				
				if (s < 1)
				{
					s = 1;
				}
			
				_power_fg.scale.x = s;
				_power_fg.x = 20 + (_power_fg.scale.x / 2);
			}
		}
		
	}
}