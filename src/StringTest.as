package  
{
	import org.flixel.FlxState;

	public class StringTest extends FlxState
	{
		
		public function StringTest() 
		{
		}
		
		override public function create():void
		{
			var a:Number = 23.99;
			var b:String = "23";
			
			trace(b + a);
			
			b += a;
			
			trace(b);
			
			
		}
		
	}

}