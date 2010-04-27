package  
{
	import org.flixel.*;
	
	import com.greensock.TweenMax;
	import com.greensock.TimelineMax;
	import com.greensock.easing.*;

	public class Demo15Melon extends FlxState
	{
		private var logo:FlxText;
		private var fullstop:FlxText;
		private var logoTimeline:TimelineMax;
		
		public function Demo15Melon() 
		{
		}
		
		override public function create():void
		{
			super.create();
			
			logo = new FlxText(-100, 80, 38, "Melon");
			logo.alignment = "right";
			
			fullstop = new FlxText(140, 80, 6, ".");
			fullstop.alignment = "left";
			
			add(logo);
			add(fullstop);
			
			logoTimeline = new TimelineMax();
			logoTimeline.append(new TweenMax(logo, 1, { x: 320-logo.width, ease: Linear.easeIn } ));
			logoTimeline.append(new TweenMax(logo, 0.4, { y: "-64", ease: Sine.easeInOut } ));
			logoTimeline.append(new TweenMax(logo, 1, { y: 240 - 12, ease: Bounce.easeOut } ));
			
			logoTimeline.play();
		}
		
		override public function update():void
		{
			super.update();
			
			if (logo.x >= 140-30 && logo.text == "Melon")
			{
				logo.text = "Melon.";
				fullstop.visible = false;
			}
		}
		
	}
		

}