package  
{
	import flash.display.BitmapData;
	import org.flixel.*;
	
	import flash.display.Shape; 
	import flash.display.GradientType; 
	import flash.geom.Matrix; 


	public class Demo8 extends FlxState
	{
		private var testA:FlxSprite;
		private var testB:FlxSprite;
		
		
		public function Demo8() 
		{
		}
		
		override public function create():void
		{
			testA = FlxGradient.createGradientFlxSprite(100, 200, [0xFF0000, 0xFF8000, 0xFFFF00], 4 );
			testA.x = 0;
			
			testB = FlxGradient.createGradientFlxSprite(100, 200, [0x00FF00, 0x00FFFF, 0xFF0080], 4 );
			testB.x = 104;
			
			add(testA);
			add(testB);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}