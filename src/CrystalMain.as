/**
 * Crystal Caverns
 * @author Richard Davey
 */

package 
{
	import org.flixel.*;
	import com.photonstorm.crystalcaverns.crystalcaverns;
		
	[SWF(width="640", height="400", frameRate="60", backgroundColor="#000000")]
	
	public class CrystalMain extends FlxGame
	{
		public function CrystalMain():void 
		{
			super(320, 240, crystalcaverns, 2);
		}
		
	}
	
}