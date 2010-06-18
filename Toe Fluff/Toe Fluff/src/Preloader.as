/**
 * Toefluff
 * @author Richard Davey, Photon Storm
 */

package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import photonstorm.demofx.starfield3D;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	public class Preloader extends MovieClip 
	{
		private var stars:starfield3D;
		private var logo:photonStormLogo = new photonStormLogo();
		
		public function Preloader() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			MochiBot.track(this, "e22e8c8e");
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			stars = new starfield3D();
			stars.init(stage.stageWidth, stage.stageHeight);
			stars.x = stage.stageWidth / 2;
			stars.y = stage.stageHeight / 2;
			
			logo.x = stage.stageWidth / 2;
			logo.y = stage.stageHeight + logo.height;
			
			addChild(new Bitmap(new BitmapData(560, 560, false, 0x0)));
			addChild(stars);
			addChild(logo);
			
			stars.go();
			
			TweenMax.to(logo, 4, { y: stage.stageHeight / 2, ease: Elastic.easeOut } );
		}
		
		private function progress(e:ProgressEvent):void 
		{
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames)
			{
				if (TweenMax.isTweening(logo) == false)
				{
					removeEventListener(Event.ENTER_FRAME, checkFrame);
					
					fadeOut();
				}
			}
		}
		
		private function fadeOut():void
		{
			TweenMax.to(stars, 1, { alpha: 0, delay: 0.5, onComplete: startup } );
			TweenMax.to(logo, 0.7, { alpha: 0 } );
		}
		
		private function startup():void 
		{
			stop();
			
			stars.stop();
			
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			
			var mainClass:Class = getDefinitionByName("Main") as Class;
			
			addChild(new mainClass(this.stage) as DisplayObject);
			
			removeChild(logo);
			removeChild(stars);
		}
		
	}
	
}