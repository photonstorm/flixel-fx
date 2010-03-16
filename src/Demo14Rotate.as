package  
{
	import flash.geom.Point;
	
	import org.flixel.*;

	public class Demo14Rotate extends FlxState
	{
		private var d:Number = 0;
		private var s:FlxSprite;
		private var p:FlxSprite;
		private var t:FlxText;
		
		public function Demo14Rotate() 
		{
		}
		
		override public function create():void
		{
			t = new FlxText(0, 0, 320, "");
			
			s = new FlxSprite(160, 120).createGraphic(4, 4, 0xFFFF8000);
			
			p = new FlxSprite(160, 120).createGraphic(4, 4, 0xffFF0080);
			
			FlxG.mouse.show();
			
			add(s);
			add(t);
			add(p);
		}

		override public function update():void
		{
			//	The final value is the AMOUNT to be added to the rotation each update, not the actual angle itself!
			//rotateAboutPoint(s, 150, 110, FlxMath.asRadians(10));
			
			rotateAroundFlxSprite(s, p, 10, FlxMath.asRadians(4));
			
			//rotateAboutPoint(s, 150, 110, FlxMath.asRadians(10));
			
			//d = d + 0.01;
			//d++;
			
			//t.text = d.toString();
			
			if (FlxG.keys.UP)
			{
				p.y -= FlxG.elapsed * 40;
			}
			
			if (FlxG.keys.DOWN)
			{
				p.y += FlxG.elapsed * 40;
			}
			
			//if (d > 180)
			//{
				//d = 0;
				//FlxG.pause = true;
			//}
		}
		
		public function rotateAroundFlxSprite(target:FlxSprite, anchor:FlxSprite, distance:uint, speed:Number):void
		{
			var rx:Number = anchor.x + distance;
			var ry:Number = anchor.y + distance;
			
			var dx:Number = target.x - rx;
			var dy:Number = target.y - ry;
			
			var cos:Number = Math.cos(speed);
			var sin:Number = Math.sin(speed);
			
			t.text = dx.toString();

			target.x = (rx + dx * cos) - (dy * sin);
			target.y = (ry + dy * cos) + (dx * sin);
		}
		
		public function rotateAboutPoint(m:FlxSprite, rx:Number, ry:Number, P:Number):void
		{	
			var dx:Number = m.x - rx;
			var dy:Number = m.y - ry;
			var cos:Number = Math.cos(P);
			var sin:Number = Math.sin(P);

			m.x = rx + dx * cos - dy * sin;
			m.y = ry + dy * cos + dx * sin;
		}


		
	}

}