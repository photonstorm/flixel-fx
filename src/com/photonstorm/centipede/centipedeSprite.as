package com.photonstorm.centipede 
{
	import org.flixel.*;
	
	public class centipedeSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/centipede/centipede.png')] private var centipedePNG:Class;
		
		//	do i need either of these?
		public var index:uint;
		public var name:String;
		
		private var group:centipedeGroup;
		public var head:centipedeSprite;
		
		public var isHead:Boolean;

		public function centipedeSprite(_group:centipedeGroup, _head:centipedeSprite, _x:uint, _y:uint, _id:uint) 
		{
			super(_x, _y);
			
			index = _id;
			name = "segment" + _id;
			
			isHead = false;
			
			group = _group;
			head = _head;
			
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
		
		public function shot():void
		{
			group.segmentShot(this);
		}
		
	}

}