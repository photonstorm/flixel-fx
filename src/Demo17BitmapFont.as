package  
{
	import org.flixel.*;
	import flash.utils.getTimer;

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
		private var fb2:FlxBitmapFont;
		private var fb3:FlxBitmapFont;
		private var fb4:FlxBitmapFont;
		private var fb5:FlxBitmapFont;
		private var fb6:FlxBitmapFont;
		private var fb7:FlxBitmapFont;

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
			fb1.text = "flixel bitmap fonts";
			fb1.x = (FlxG.width / 2) - (fb1.width / 2);
			fb1.y = 0;

			fb2 = new FlxBitmapFont(knighthawksFont, 31, 25, FlxBitmapFont.TEXT_SET2, 10, 1, 0);
			fb2.setText("bought to you\nby photon storm", true, 0, 8, FlxBitmapFont.ALIGN_CENTER);
			fb2.x = (FlxG.width / 2) - (fb2.width / 2);
			fb2.y = fb1.y + fb1.height + 32;
			
			fb3 = new FlxBitmapFont(bubblesFont, 32, 32, " FLRX!AGMSY?BHNTZ-CIOU. DJPV, EKQW' ", 6);
			fb3.text = "lovely bubbles!";
			fb3.x = (FlxG.width / 2) - (fb3.width / 2);
			fb3.y = fb2.y + fb2.height + 32;
			
			fb4 = new FlxBitmapFont(naosFont, 31, 32, FlxBitmapFont.TEXT_SET10 + "4()!45789", 6, 16, 1);
			fb4.text = "atari rocks the house";
			fb4.x = (FlxG.width / 2) - (fb4.width / 2);
			fb4.y = fb3.y + fb3.height + 32;
			
			fb5 = new FlxBitmapFont(spazFont, 32, 32, FlxBitmapFont.TEXT_SET11 + "#", 9, 1, 1);
			fb5.text = "lost boys forever";
			fb5.x = (FlxG.width / 2) - (fb5.width / 2);
			fb5.y = fb4.y + fb4.height + 32;
			
			fb6 = new FlxBitmapFont(deltaForceFont, 16, 16, FlxBitmapFont.TEXT_SET4 + ".:;!?\"'()^-,/abcdefghij", 20, 0, 1);
			fb6.setText("IF THE FONT CONTAINS CbbL CHARACTERS\n^a THEN c USE d THEM! ^a", true, 0, 8, FlxBitmapFont.ALIGN_CENTER, true);
			fb6.x = (FlxG.width / 2) - (fb6.width / 2);
			fb6.y = fb5.y + fb5.height + 32;
			
			fb7 = new FlxBitmapFont(robocopFont, 26, 32, " !\"aao '()  ;-./          :; = ?*ABCDEFGHIJKLMNOPQRSTUVWXYZ", 10, 6, 0, 3, 0);
			fb7.text = "go have fun!";
			fb7.x = (FlxG.width / 2) - (fb7.width / 2);
			fb7.y = fb6.y + fb6.height + 32;
			
			add(fb1);
			add(fb2);
			add(fb3);
			add(fb4);
			add(fb5);
			add(fb6);
			add(fb7);
		}
		
		override public function render():void
		{
			//fb1.text = "rock on! " + getTimer().toString();
			
			super.render();
		}
		
	}

}