package  
{
	import org.flixel.*;

	public class Demo17BitmapFont extends FlxState
	{
		[Embed(source = '../assets/bitmap fonts/bluepink_font.png')] private var bluepinkFont:Class;
		[Embed(source = '../assets/bitmap fonts/bubbles_font.png')] private var bubblesFont:Class;
		[Embed(source = '../assets/bitmap fonts/deltaforce_font.png')] private var deltaForceFont:Class;
		[Embed(source = '../assets/bitmap fonts/knighthawks_font.png')] private var knighthawksFont:Class;
		[Embed(source = '../assets/bitmap fonts/naos_font.png')] private var naosFont:Class;
		[Embed(source = '../assets/bitmap fonts/spaz_font.png')] private var spazFont:Class;
		[Embed(source = '../assets/bitmap fonts/robocop_font.png')] private var robocopFont:Class;
		
		private var fb1:FlxBitmapFont;
		private var text1:FlxSprite;
		
		private var fb2:FlxBitmapFont;
		private var text2:FlxSprite;
		
		private var fb3:FlxBitmapFont;
		private var text3:FlxSprite;
		
		private var fb4:FlxBitmapFont;
		private var text4:FlxSprite;
		
		private var fb5:FlxBitmapFont;
		private var text5:FlxSprite;
		
		private var fb6:FlxBitmapFont;
		private var text6:FlxSprite;
		
		private var fb7:FlxBitmapFont;
		private var text7:FlxSprite;

		public function Demo17BitmapFont() 
		{
		}
		
		
		/**
					font.init(new tskFontBD(0, 0), 32, 25, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?{}.:-,'0123456789", 10);
					font.init(new tbjFontBD(0, 0), 32, 32, BlitzFont.SET10 + " 1234567890,.:'-<>!", 9, 2, 2, 1, 1);
					font.init(new goldFontBD(0, 0), 16, 16, "!     :() ,?." + BlitzFont.SET10, 20);
		 */
		
		override public function create():void
		{
			super.create();
			
			fb1 = new FlxBitmapFont(bluepinkFont, 32, 32, FlxBitmapFont.TEXT_SET2, 10);
			text1 = fb1.getLine("flixel bitmap fonts");
			text1.x = (FlxG.width / 2) - (text1.width / 2);
			text1.y = 0;

			fb2 = new FlxBitmapFont(knighthawksFont, 31, 25, FlxBitmapFont.TEXT_SET2, 10, 1, 0);
			text2 = fb2.getMultiLine("bought to you by\nphoton storm", 0, 8, FlxBitmapFont.ALIGN_CENTER);
			text2.x = (FlxG.width / 2) - (text2.width / 2);
			text2.y = text1.y + text1.height + 32;
			
			fb3 = new FlxBitmapFont(bubblesFont, 32, 32, " FLRX!AGMSY?BHNTZ-CIOU. DJPV, EKQW' ", 6);
			text3 = fb3.getLine("lovely bubbles!");
			text3.x = (FlxG.width / 2) - (text3.width / 2);
			text3.y = text2.y + text2.height + 32;
			
			fb4 = new FlxBitmapFont(naosFont, 31, 32, FlxBitmapFont.TEXT_SET10 + "4()!45789", 6, 16, 1);
			text4 = fb4.getLine("atari rocks da house");
			text4.x = (FlxG.width / 2) - (text4.width / 2);
			text4.y = text3.y + text3.height + 32;
			
			fb5 = new FlxBitmapFont(spazFont, 32, 32, FlxBitmapFont.TEXT_SET11 + "#", 9, 1, 1);
			text5 = fb5.getLine("lost boys forever");
			text5.x = (FlxG.width / 2) - (text5.width / 2);
			text5.y = text4.y + text4.height + 32;
			
			fb6 = new FlxBitmapFont(deltaForceFont, 16, 16, FlxBitmapFont.TEXT_SET4 + ".:;!?\"'()^-,/abcdefghij", 20, 0, 1);
			text6 = fb6.getMultiLine("IF THE FONT CONTAINS COOL CHARACTERS\n^a THEN b USE b THEM! ^a", 0, 8, FlxBitmapFont.ALIGN_CENTER, false);
			text6.x = (FlxG.width / 2) - (text6.width / 2);
			text6.y = text5.y + text5.height + 32;
			
			fb7 = new FlxBitmapFont(robocopFont, 26, 32, " !\"aao '()  ;-./          :; = ?*ABCDEFGHIJKLMNOPQRSTUVWXYZ", 10, 6, 0, 3, 0);
			text7 = fb7.getLine("go have fun!");
			text7.x = (FlxG.width / 2) - (text7.width / 2);
			text7.y = text6.y + text6.height + 32;
			
			add(text1);
			add(text2);
			add(text3);
			add(text4);
			add(text5);
			add(text6);
			add(text7);
		}
		
		override public function render():void
		{
			super.render();
		}
		
	}

}