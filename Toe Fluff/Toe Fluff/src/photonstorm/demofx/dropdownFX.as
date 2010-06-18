/**
* Photon Storm - Demo FX - Image Drop Down
* http://www.photonstorm.com
* @author Richard Davey
*/

package photonstorm.demofx
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.EventDispatcher;
	
	public class dropdownFX extends Sprite
	{
		private var source:BitmapData;
		private var output:Bitmap;
		private var offset:int;
		private var y2:int;
		private var isReady:Boolean = false;
		private var hasComplete:Boolean = false;
		private var backgroundColor:int;
		private var dispatchOnComplete:Boolean;
		public static const DEMOFX_DROPDOWN_COMPLETE:String = "demoFXDropDownComplete";
		
		/**
		 * The Drop Down effect object. Use init() to set-up the values for the effect
		 * 
		 * @return void
		 */
		public function dropdownFX():void
		{
		}
		
		/**
		 * This method initialises the effect. Call the "go" method to start the effect running.
		 * 
		 * @param picture This is the source Bitmap you wish to perform the effect on
		 * @param dropSize The size (in pixels) of each drop segment. Defaults to 1 (for a smooth drop). Use a larger value for a faster drop.
		 * @param dispatch A boolean. If set to true the effect will dispatch the DEMOFX_DROPDOWN_COMPLETE on completion
		 * @param useSourceTransparency Preserve transparent areas of the source image (if set to false see backgroundColor)
		 * @param backgroundColor If the source image contains transparency, but useSourceTransparency is set to false, this is the colour that appears in the background
		 * @return Bitmap A bitmap image containng the effect
		 */
		public function init(picture:Bitmap, dropSize:uint = 1, dispatch:Boolean = false, useSourceTransparency:Boolean = false, backgroundColor:int = 0):Bitmap
		{
			offset = dropSize;
			
			//	Sanity check
			if (offset > picture.bitmapData.height)
			{
				offset = 1;
			}
			
			if (useSourceTransparency)
			{
				source = picture.bitmapData;
			}
			else
			{
				source = new BitmapData(picture.width, picture.height, false, backgroundColor);
				source.copyPixels(picture.bitmapData, new Rectangle(0, 0, picture.width, picture.height), new Point(0, 0));
			}
		
			dispatchOnComplete = dispatch;
			
			output = new Bitmap(new BitmapData(source.width, source.height, useSourceTransparency, backgroundColor));
			
			y2 = source.height;
			
			isReady = true;
			
			return output;
		}
		
		/**
		 * Starts the effect running (if init() has already been called). Use "stop" to pause the effect if needed, or "restart" to start the effect from the beginning.
		 * 
		 * @return void
		 */
		public function go():void
		{
			if (isReady)
			{
				addEventListener(Event.ENTER_FRAME, mainLoop, false, 0, true);
			}
		}
		
		/**
		 * Re-starts the effect from the beginning (init must have already been called)
		 * 
		 * @return void
		 */
		public function restart():void
		{
			if (isReady)
			{
				y2 = source.height;
				
				addEventListener(Event.ENTER_FRAME, mainLoop, false, 0, true);
			}
		}
		
		/**
		 * Stops the effect running. Use "go" to continue the effect from where you stopped it, or call "restart" to start the effect from the beginning.
		 * 
		 * @return void
		 */
		public function stop():void
		{
			if (isReady)
			{
				removeEventListener(Event.ENTER_FRAME, mainLoop);
			}
		}

		/**
		 * The main loop for the effect. Dispatches an event on complete (if set) otherwise terminates the enter frame event listener
		 * 
		 * @return void
		 * @private
		 */
		private function mainLoop(event:Event):void
		{
			//	 If transparency is on then we need to clean the output
			output.bitmapData.lock();
			
			for (var y:int = 0; y < y2; y += offset)
			{
				//	Get a pixel strip from the picture (starting at the bottom and working way up)
				output.bitmapData.copyPixels(source, new Rectangle(0, y2 - offset, source.width, offset), new Point(0, y));
			}
			
			output.bitmapData.unlock();
			
			y2 -= offset;
			
			if (y2 <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, mainLoop);
				
				if (dispatchOnComplete)
				{
					dispatchEvent(new Event(dropdownFX.DEMOFX_DROPDOWN_COMPLETE));
				}
			}
		}
	}
}