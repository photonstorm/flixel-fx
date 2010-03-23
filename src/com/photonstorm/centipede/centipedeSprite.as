package com.photonstorm.centipede 
{
	import org.flixel.*;
	
	public class centipedeSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/centipede/centipede.png')] private var centipedePNG:Class;
		
		private var group:centipedeGroup;
		
		public var isHead:Boolean;

		public function centipedeSprite(parent:centipedeGroup, _x:uint, _y:uint) 
		{
			super(_x, _y);
			
			isHead = false;
			
			group = parent;
			
			loadGraphic(centipedePNG, true, false, 12, 8);
			
			addAnimation("headRight", [ 0 ], 0, true);
			addAnimation("headLeft", [ 1 ], 0, true);
			addAnimation("walkLeft", [ 2, 3, 4, 5 ], 10, true);
			addAnimation("walkRight", [ 5, 4, 3, 2 ], 10, true);
			
			play("walkLeft");
		}
		
		public function turnIntoHead():void
		{
			isHead = true;
			
			play("headRight");
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function kill():void
		{
			group.segmentShot(this);
		}
		
		public function killedByParent():void
		{
			exists = false;
			dead = true;
		}
		
	}

}