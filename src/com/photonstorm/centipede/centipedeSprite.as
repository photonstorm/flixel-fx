package com.photonstorm.centipede 
{
	import org.flixel.*;
	
	public class centipedeSprite extends FlxSprite
	{
		[Embed(source = '../../../../assets/centipede/centipede.png')] private var centipedePNG:Class;
		
		public var index:uint;
		private var group:centipedeGroup;
		private var _head:centipedeSprite;
		public var isHead:Boolean;
		private var _children:Array;

		public function centipedeSprite(Group:centipedeGroup, Head:centipedeSprite, X:uint, Y:uint, Index:uint, startRight:Boolean)
		{
			super(X, Y);
			
			index = Index;
			
			isHead = false;
			
			group = Group;
			
			if (Head != null)
			{
				_head = Head;
			}
			
			loadGraphic(centipedePNG, true, false, 16, 16);
			
			addAnimation("headRight", [ 0 ], 0, true);
			addAnimation("headLeft", [ 1 ], 0, true);
			addAnimation("walkLeft", [ 2, 3, 4, 5 ], 10, true);
			addAnimation("walkRight", [ 5, 4, 3, 2 ], 10, true);
			
			if (startRight)
			{
				play("walkRight");
			}
			else
			{
				play("walkLeft");
			}
		}
		
		public function get head():centipedeSprite
		{
			return _head;
		}
		
		public function set head(head:centipedeSprite):void
		{
			_head = head;
			
			if (_head.facing == FlxSprite.LEFT)
			{
				faceLeft();
			}
			else
			{
				faceRight();
			}
		}
		
		public function faceLeft():void
		{
			facing = FlxSprite.LEFT;
			
			if (isHead)
			{
				play("headLeft");
			}
			else
			{
				play("walkLeft");
			}
		}
		
		public function faceRight():void
		{
			facing = FlxSprite.RIGHT;
			
			if (isHead)
			{
				play("headRight");
			}
			else
			{
				play("walkRight");
			}
		}
		
		public function set children(kids:Array):void
		{
			_children = kids;
			
			debugKids();
		}
		
		public function get children():Array
		{
			return _children;
		}
		
		private function debugKids():void
		{
			var s:String = "";

			if (_children.length > 0)
			{
				s = "Head " + index + " has children: ";
				
				for (var i:uint = 0; i < _children.length; i++)
				{
					s = s.concat(_children[i].index + ", ");
				}
			}
			else
			{
				s = "Head " + index + " has no children";
			}
			
			trace(s);
			
		}
		
		public function turnIntoHead():void
		{
			trace(index + " has been promoted to a head!");
			
			isHead = true;
			_head = null;
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