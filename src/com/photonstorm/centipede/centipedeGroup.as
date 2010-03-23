package com.photonstorm.centipede 
{
	import flash.utils.getTimer;
	
	import org.flixel.*;
	
	public class centipedeGroup extends FlxGroup
	{
		private var mushrooms:mushroomGroup;
		private var centiHead:centipedeSprite;
		private var heads:Array;
		private var nextMove:int;
		private var centiSpeed:int;
		private var segmentsLeft:uint;
		
		public function centipedeGroup(segments:uint, mushroomsRef:mushroomGroup) 
		{
			super();
			
			mushrooms = mushroomsRef;
			centiSpeed = 250;
			segmentsLeft = segments;
			nextMove = getTimer() + centiSpeed * 2;
			
			//	One head to rule them all, at the very start
			//var centiHead:centipedeSprite = getFirstAlive() as centipedeSprite;
			heads = new Array();
			
			add(new centipedeSprite(this, 312 + (c * 12), 0, c));
			centiHead = getFirstAlive() as centipedeSprite;
			centiHead.facing = FlxSprite.LEFT;
			centiHead.turnIntoHead();
			
			for (var c:uint = 0; c < segments; c++)
			{
				add(new centipedeSprite(this, centiHead, 312 + (c * 12), 0, c));
			}
			
			//heads.push(centiHead);
			
			//add(centiHead);
			
		}
		
		public function segmentShot(segment:centipedeSprite):void
		{
			//	1) Kill the segment
			//	2) Promote the next in chain to a head
			//	3) Attach children below the head, to the head
			//	4) Reverse the new head direction
			
			//var segmentId:uint = getSegmentId(segment);
			
			trace("shot: " + segment.name);
			
			segment.kill();
			
			segmentsLeft--;
			
			if (segmentsLeft == 0)
			{
				trace("Level Complete!");
			}
		}
		
		/*
		private function getSegmentId(segment:centipedeSprite):uint
		{
			var result:uint;
			
			for (var i:uint = 0; i < members.length; i++)
			{
				if (segment == centipedeSprite(members[i]))
				{
					result = i;
					continue;
				}
			}
			
			return result;
		}
		*/
		
		override public function update():void
		{
			super.update();
			
			if (getTimer() > nextMove)
			{
				move();
				nextMove = getTimer() + centiSpeed;
			}
		}
	
		private function move():void
		{
			//	Move the head in the direction it is facing
			//	If it hits the edge of the screen it wraps around, or hits a mushroom it drops down 1, then carries on
			
			var oldX:int = centiHead.x;
			var oldY:int = centiHead.y;
			
			switch (centiHead.facing)
			{
				case FlxSprite.LEFT:
					if (centiHead.x == 0)
					{
						centiHead.y += 8;
						centiHead.facing = FlxSprite.RIGHT;
					}
					else
					{
						//	Check it won't hurt a mushroom
						for each (var m:mushroomSprite in mushrooms.members)
						{
							if (m.exists)
							{
								if (m.x == centiHead.x - 12 && m.y == centiHead.y)
								{
									//	It will, so drop down
									centiHead.y += 8;
									centiHead.facing = FlxSprite.RIGHT;
									continue;
								}
							}
						}
						
						//	It didn't change direction
						if (centiHead.facing == FlxSprite.LEFT)
						{
							centiHead.x -= 12;
							
							if (centiHead.x < 0)
							{
								centiHead.x = 0;
							}
						}
					}
					break;
					
				case FlxSprite.RIGHT:
					
					if (centiHead.x == 312)
					{
						centiHead.y += 8;
						centiHead.facing = FlxSprite.LEFT;
					}
					else
					{
						//	Check it won't hurt a mushroom
						for each (var m2:mushroomSprite in mushrooms.members)
						{
							if (m2.exists)
							{
								if (m2.x == centiHead.x + 12 && m2.y == centiHead.y)
								{
									//	It will, so drop down
									centiHead.y += 8;
									centiHead.facing = FlxSprite.LEFT;
									continue;
								}
							}
						}
						
						//	It didn't change direction
						if (centiHead.facing == FlxSprite.RIGHT)
						{
							centiHead.x += 12;
						}
					}
					break;
			}
			
			//	And now interate the movement down to the rest of the body parts
			//	The easiest way to do this is simply to work our way backwards through the body pieces!
			
			for (var s:int = members.length - 1; s > 0; s--)
			{
				//	We need to keep the x/y/facing values from the head part, to pass onto the next one in the chain
				if (s == 1)
				{
					members[s].x = oldX;
					members[s].y = oldY;
				}
				else
				{
					members[s].x = members[s - 1].x;
					members[s].y = members[s - 1].y;
				}
			}
			
		}
		
	}

}