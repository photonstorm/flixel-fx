package  
{
	import org.flixel.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class Demo18SWCBitmap extends FlxState
	{
		private var pic:FlxSprite;
		
		
		public function Demo18SWCBitmap() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			pic = new FlxSprite(0, 0);
			pic.pixels = new testPicture(0, 0);
			
			add(pic);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}