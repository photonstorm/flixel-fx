/**
 * Toe Fluff Paint
 * @author Richard Davey, Photon Storm
 */

package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Main extends Sprite 
	{
		private var painter:Paint;
		private var stageRef:Stage;
		
		public function Main(stageRef:Stage):void 
		{
			this.stageRef = stageRef;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			painter = new Paint();
			
			addChild(painter);
			
			painter.init(stageRef);
		}
		
	}
	
}