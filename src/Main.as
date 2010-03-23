/**
 * Flixel 2.23 Tests
 * @author Richard Davey
 */

package 
{
	import org.flixel.*;
	import com.photonstorm.centipede.FlxCentipede;
		
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#000000")]
	
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			super(320, 240, FlxCentipede, 2);
		}
		
	}
	
}