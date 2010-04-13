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
		private var slideX:uint = 16;
		private var slideY:uint = 16;
		private var segmentsLeft:uint;
		public var isDead:Boolean;
		
		public function centipedeGroup(segments:uint, mushroomsRef:mushroomGroup, speed:uint, startRight:Boolean) 
		{
			super();
			
			mushrooms = mushroomsRef;
			centiSpeed = speed;
			segmentsLeft = segments;
			isDead = false;
			nextMove = getTimer() + centiSpeed * 2;
			
			//	One head to rule them all, at the very start
			heads = new Array();
			
			if (startRight)
			{
				add(new centipedeSprite(this, null, 320, 0, 0, startRight));
				centiHead = getFirstAlive() as centipedeSprite;
				centiHead.turnIntoHead();
				centiHead.faceLeft();
			}
			else
			{
				add(new centipedeSprite(this, null, 0, 0, 0, startRight));
				centiHead = getFirstAlive() as centipedeSprite;
				centiHead.turnIntoHead();
				centiHead.faceRight();
			}
			
			heads.push(centiHead);
			
			//	Body Segments
			for (var c:uint = 1; c < segments; c++)
			{
				if (startRight)
				{
					add(new centipedeSprite(this, centiHead, 320 + (c * slideX), 0, c, startRight));
				}
				else
				{
					add(new centipedeSprite(this, centiHead, 0 - (c * slideX), 0, c, startRight));
				}
			}
			
			rebuildChildren();
		}
		
		public function segmentShot(segment:centipedeSprite):void
		{
			//	1) Kill the segment
			//	2) Promote the next in chain to a head
			//	3) Attach children below the head, to the head
			//	4) Reverse the new head direction
			
			trace("------------------------------------------------------------------------------------");
			
			if (segment.isHead == false)
			{
				trace("You killed segment " + segment.index + " whos head is " + segment.head.index);
			}
			else
			{
				trace("You killed head piece segment " + segment.index);
			}
			
			//	Head? Then remove it from the heads array
			
			var orphans:Array = new Array();
			
			if (segment.isHead)
			{
				trace("You shot a head piece");
				orphans = getChildren(segment);
				behead(segment);
				FlxG.score += 100;
			}
			else
			{
				orphans = getChildrenBelowSegment(segment);
				FlxG.score += 10;
			}
			
			//	There are kids to take care of
			if (orphans.length > 0)
			{
				if (segment.isHead == false)
				{
					trace("You shot a normal piece");
				}
				
				splitCentipede(orphans);
			}
			else
			{
				//	If there are no orphans and this wasn't a head piece, then you shot the end of the centipede
				if (segment.isHead == false)
				{
					trace("You shot the last piece of the centipede, and it wasn't a head, so don't do anything");
				}
			}
			
			segment.kill();
				
			rebuildChildren();
			
			//	Win condition?
			segmentsLeft--;
			
			if (segmentsLeft == 0)
			{
				isDead = true;
			}
		}
		
		private function behead(rip:centipedeSprite):void
		{
			trace(rip.index + " was a head, so removing it from the heads array (heads length: " + heads.length + ")");
			
			for (var i:uint = 0; i < heads.length; i++)
			{
				if (rip == heads[i])
				{
					heads.splice(i, 1);
					continue;
				}
			}
			
			trace("Heads length now : " + heads.length);
		}
		
		private function splitCentipede(segments:Array):void
		{
			trace("Creating a new centipede from " + segments.length + " orphans");
			
			//	The first one becomes a head, no matter what
			var newHead:centipedeSprite = segments[0] as centipedeSprite;
			
			newHead.turnIntoHead();
			
			heads.push(newHead);
			
			//	Turn the new head around, no matter what
			if (newHead.facing == FlxSprite.LEFT)
			{
				newHead.faceRight();
			}
			else
			{
				newHead.faceLeft();
			}
			
			if (segments.length > 1)
			{
				for (var i:uint = 1; i < segments.length; i++)
				{
					segments[i].head = newHead;
				}
			}
		}
		
		private function getChildrenBelowSegment(segment:centipedeSprite):Array
		{
			var kids:Array = new Array();
			
			for (var i:uint = segment.index + 1; i < members.length; i++)
			{
				if (members[i].exists && members[i].head == segment.head)
				{
					kids.push(members[i]);
				}
			}
			
			return kids;
		}
		
		private function getChildren(head:centipedeSprite):Array
		{
			var kids:Array = new Array();
			
			for (var i:uint = 0; i < members.length; i++)
			{
				if (members[i].exists && members[i].head == head)
				{
					kids.push(members[i]);
				}
			}
			
			return kids;
		}
		
		private function rebuildChildren():void
		{
			for each (var head:centipedeSprite in heads)
			{
				head.children = getChildren(head);
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (isDead == false)
			{
				if (getTimer() > nextMove)
				{
					move();
					nextMove = getTimer() + centiSpeed;
				}
			}
		}
	
		private function move():void
		{
			//	Move the head in the direction it is facing
			//	If it hits the edge of the screen it wraps around, or hits a mushroom it drops down 1, then carries on
			
			for each (var centiHead:centipedeSprite in heads)
			{
				var oldX:int = centiHead.x;
				var oldY:int = centiHead.y;
				
				switch (centiHead.facing)
				{
					case FlxSprite.LEFT:
						if (centiHead.x == 0)
						{
							centiHead.y += slideY;
							centiHead.faceRight();
						}
						else
						{
							//	Check it won't hit a mushroom
							for each (var m:mushroomSprite in mushrooms.members)
							{
								if (m.exists)
								{
									if (m.x == centiHead.x - slideX && m.y == centiHead.y)
									{
										//	It will, so drop down
										centiHead.y += slideY;
										centiHead.faceRight();
										continue;
									}
								}
							}
							
							//	It didn't change direction
							if (centiHead.facing == FlxSprite.LEFT)
							{
								centiHead.x -= slideX;
								
								if (centiHead.x < 0)
								{
									centiHead.x = 0;
								}
							}
						}
						break;
						
					case FlxSprite.RIGHT:
						
						if (centiHead.x == 320)
						{
							centiHead.y += slideY;
							centiHead.faceLeft();
						}
						else
						{
							//	Check it won't hit a mushroom
							for each (var m2:mushroomSprite in mushrooms.members)
							{
								if (m2.exists)
								{
									if (m2.x == centiHead.x + slideX && m2.y == centiHead.y)
									{
										//	It will, so drop down
										centiHead.y += slideY;
										centiHead.faceLeft();
										continue;
									}
								}
							}
							
							//	It didn't change direction
							if (centiHead.facing == FlxSprite.RIGHT)
							{
								centiHead.x += slideX;
							}
						}
						break;
				}
				
				//	And now iterate the movement down to the rest of the body parts
				//	The easiest way to do this is simply to work our way backwards through the body pieces!
				//	Technically you could take the final piece, and move it to where the head piece WAS, but this works, so sod it
				
				if (centiHead.children.length > 0)
				{
					for (var s:int = centiHead.children.length - 1; s >= 0; s--)
					{
						var newX:uint;
						var newY:uint;
						
						//	If this is the final segment before the actual head then we need the coords from the head instead
						if (s == 0)
						{
							newX = oldX;
							newY = oldY;
						}
						else
						{
							newX = centiHead.children[s - 1].x;
							newY = centiHead.children[s - 1].y;
						}
						
						//	Has the Y value changed?
						if (newY != centiHead.children[s].y)
						{
							//	Yes
							centiHead.children[s].y += slideY;
						}
						else
						{
							//	No, so we only need to move on the X axis
							if (newX < centiHead.children[s].x)
							{
								centiHead.children[s].x -= slideX;
							}
							else
							{
								centiHead.children[s].x += slideX;
							}
						}
					}
				}
				
			}
			
		}
		
	}

}