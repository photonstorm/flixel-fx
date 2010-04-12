package com.photonstorm.centipede 
{
	import org.flixel.*;

	public class mushroomGroup extends FlxGroup
	{
		
		public function mushroomGroup(totalMushrooms:uint) 
		{
			super();
			
			var slots:Array = uniqueGrid();
			
			//	Create mushrooms, all in unique 12x8 locations
			for (var m:uint = 0; m < totalMushrooms; m++)
			{
				var idx:uint = int(Math.random() * slots.length - 1);
				var obj:Object = slots[idx];
				
				slots.splice(idx, 1);
				
				spawnMushroom(obj.x, obj.y);
			}
			
			//	For testing
			spawnMushroom(12, 0);
		}
		
		public function spawnMushroom(X:uint, Y:uint, actualPixels:Boolean = false):void
		{
			if (actualPixels)
			{
				add(new mushroomSprite(X, Y));
			}
			else
			{
				add(new mushroomSprite(X * 12, Y * 8));
			}
		}
		
		override public function update():void
		{
			super.update();
		}
		
		//	Game is all 12x8 - which equals 26 x 30 (312 x 240)
		private function uniqueGrid():Array
		{
			var slots:Array = new Array();
			
			for (var gy:uint = 1; gy < 28; gy++)
			{
				for (var gx:uint = 0; gx < 26; gx++)
				{
					slots.push( { x: gx, y: gy } );
				}
			}
			
			return slots;
		}
		
	}

}