package com.photonstorm.centipede 
{
	import org.flixel.*;

	public class bulletGroup extends FlxGroup
	{
		
		public function bulletGroup() 
		{
			super();
			
			for (var b:uint = 0; b < 40; b++)
			{
				var tempBullet:FlxSprite = new FlxSprite().createGraphic(2, 4, 0xFFFFFFFF);
				tempBullet.dead = true;
				tempBullet.exists = false;

				add(tempBullet);
			}
		}
		
		public function fire(px:uint, py:uint):Boolean
		{
			//	Fire
			if (countDead() > 0)
			{
				var tempBullet:FlxSprite = getFirstAvail() as FlxSprite;
				
				tempBullet.x = px + 4;
				tempBullet.y = py;
				tempBullet.exists = true;
				tempBullet.velocity.y = -400;
				tempBullet.acceleration.y = -10;
				
				return true;
			}
			
			return false;
		}
		
		//public function bulletsVsMushrooms(mushrooms:):void
		//{
		//}
		
		/**
		 * Call this function to see if one <code>FlxObject</code> overlaps another.
		 * Can be called with one object and one group, or two groups, or two objects,
		 * whatever floats your boat!  It will put everything into a quad tree and then
		 * check for overlaps.  For maximum performance try bundling a lot of objects
		 * together using a <code>FlxGroup</code> (even bundling groups together!)
		 * NOTE: does NOT take objects' scrollfactor into account.
		 * 
		 * @param	Object1		The first object or group you want to check.
		 * @param	Object2		The second object or group you want to check.  If it is the same as the first, flixel knows to just do a comparison within that group.
		 * @param	Callback	A function with two <code>FlxObject</code> parameters - e.g. <code>myOverlapFunction(Object1:FlxObject,Object2:FlxObject);</code>  If no function is provided, <code>FlxQuadTree</code> will call <code>kill()</code> on both objects.
		 */
		/*
		static public function overlap(Object1:FlxObject, Object2:FlxObject, Callback:Function = null):Boolean
		{
			if (Object1 == null || Object1.exists == false || Object2 == null || Object2.exists == false)
			{
				return false;
			}
			
			var quadTree:FlxQuadTree = new FlxQuadTree(quadTreeBounds.x, quadTreeBounds.y, quadTreeBounds.width, quadTreeBounds.height);
			
			quadTree.add(Object1, FlxQuadTree.A_LIST);
			
			if (Object1 === Object2)
			{
				return quadTree.overlap(false, Callback);
			}
			
			quadTree.add(Object2, FlxQuadTree.B_LIST);
			
			return quadTree.overlap(true, Callback);
		}
		*/
		
		override public function update():void
		{
			super.update();
			
			//	Kill bullets off the screen
			for each (var aliveBullet:FlxObject in members)
			{
				if (aliveBullet.exists && aliveBullet.y < 0)
				{
					aliveBullet.kill();
				}
			}
		}
		
	}

}