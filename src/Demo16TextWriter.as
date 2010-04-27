package  
{
	import org.flixel.*;
	
	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	import com.greensock.easing.*;

	public class Demo16TextWriter extends FlxState
	{
		private var cursor:FlxSprite;
		private var cursorTimeline:TimelineMax;
		
		public function Demo16TextWriter() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			cursor = new FlxSprite(20, 120).createGraphic(8, 12);
			
			//logo = new FlxText(-100, 80, 38, "Melon");
			//logo.alignment = "right";
			
			add(cursor);
			
			cursorTimeline = new TimelineMax();
			cursorTimeline.repeat = -1;
			cursorTimeline.append(new TweenMax(cursor, 4, { bezierThrough: [ { x:160, y:200 }, { x:280, y:120 }, { x:160, y: 0 }, { x:20, y:120 } ], ease: Linear.easeNone } ));
			cursorTimeline.play();
		}
		
		override public function update():void
		{
			super.update();
			
		}
		
	}

}