package  
{
	import org.flixel.*;

	public class Demo17BitmapFont extends FlxState
	{
		[Embed(source = '../assets/bitmap fonts/bluepink_font.png')] private var bluepinkFont:Class;
		[Embed(source = '../assets/bitmap fonts/knighthawks_font.png')] private var knighthawksFont:Class;
		
		private var fb1:FlxBitmapFont;
		private var text1:FlxSprite;
		
		private var fb2:FlxBitmapFont;
		private var text2:FlxSprite;

		public function Demo17BitmapFont() 
		{
		}
		
		
		/**
					font.init(new tskFontBD(0, 0), 32, 25, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?{}.:-,'0123456789", 10);
					font.init(new deltaforceFontBD(0, 0), 16, 16, BlitzFont.SET4 + ".:;!?\"'()^-,/abcdefghij", 20, 0, 1);
					font.init(new naosFontBD(0, 0), 31, 32, BlitzFont.SET10 + "4()!45789", 6, 16, 1);
					font.init(new spazTLBFontBD(0, 0), 32, 32, BlitzFont.SET11 + "#", 9, 1, 1);
					font.init(new knighthawksFontBD(0, 0), 31, 25, BlitzFont.SET2, 10, 1, 0);
					font.init(new tbjFontBD(0, 0), 32, 32, BlitzFont.SET10 + " 1234567890,.:'-<>!", 9, 2, 2, 1, 1);
					font.init(new goldFontBD(0, 0), 16, 16, "!     :() ,?." + BlitzFont.SET10, 20);
					font.init(new bluepinkFontBD(0, 0), 32, 32, BlitzFont.SET2, 10);
					font.init(new bubblesFontBD(0, 0), 32, 32, " FLRX!AGMSY?BHNTZ-CIOU. DJPV, EKQW' ", 6);
		 */
		
		override public function create():void
		{
			super.create();
			
			fb1 = new FlxBitmapFont(bluepinkFont, 32, 32, FlxBitmapFont.TEXT_SET2, 10);
			text1 = fb1.getLine("photon storm");
			text1.x = (FlxG.width / 2) - (text1.width / 2);
			text1.y = 64;

			fb2 = new FlxBitmapFont(knighthawksFont, 31, 25, FlxBitmapFont.TEXT_SET2, 10, 1, 0);
			text2 = fb2.getMultiLine("photon storm\nrocks the house!", 0, 8, FlxBitmapFont.ALIGN_CENTER);
			text2.x = (FlxG.width / 2) - (text2.width / 2);
			text2.y = 128;
			
			add(text1);
			add(text2);
		}
		
		override public function render():void
		{
			super.render();
		}
		
	}

}