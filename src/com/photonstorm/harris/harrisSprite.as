package com.photonstorm.harris 
{
	import org.flixel.*;

	public class harrisSprite extends FlxGroup
	{
		[Embed(source = '../../../../assets/harris/harris_walk.png')] private var harrisWalkPNG:Class; // 23x20
		[Embed(source = '../../../../assets/harris/harris_ski.png')] private var harrisSkiingPNG:Class; // 25x28
		[Embed(source = '../../../../assets/harris/harris_dead.png')] private var harrisRIPPNG:Class;
		[Embed(source = '../../../../assets/harris/harris_angel.png')] private var harrisAngelPNG:Class;
		[Embed(source = '../../../../assets/harris/skis.png')] private var skisPNG:Class;
		
		private var isFrogger:Boolean;
		
		public var harrisWalking:FlxSprite;
		public var harrisSkiing:FlxSprite;
		public var harrisRIP:FlxSprite;
		public var harrisAngel:FlxSprite;
		public var theSkis:FlxSprite;
		
		private var skiSpeed:int = 80;
		private var moveSpeed:int = 80;
		
		public var hasSkis:Boolean = false;
		public var isDead:Boolean = false;
		
		public function harrisSprite() 
		{
			super();
		}
		
		public function setupRoadSprites():void
		{
			isFrogger = true;
			
			harrisWalking = new FlxSprite(64, 0).loadGraphic(harrisWalkPNG, true, false, 23, 20, true);
			harrisWalking.addAnimation("left", [ 0,1 ], 10, true);
			harrisWalking.addAnimation("right", [ 2,3 ], 10, true);
			harrisWalking.addAnimation("up", [ 5 ], 0, false);
			harrisWalking.addAnimation("down", [ 4 ], 0, false);
			harrisWalking.facing = FlxSprite.DOWN;
			
			setupRIPSprites();
			
			theSkis = new FlxSprite().loadGraphic(skisPNG, true, false, 3, 19, true);
			theSkis.addAnimation("left", [ 0 ] );
			theSkis.addAnimation("right", [ 1 ] );
			theSkis.visible = false;
			
			add(harrisWalking);
			add(theSkis);
			add(harrisRIP);
			add(harrisAngel);
		}
		
		private function setupRIPSprites():void
		{
			harrisRIP = new FlxSprite(0, 0, harrisRIPPNG);
			harrisAngel = new FlxSprite(0, 0, harrisAngelPNG);
			
			harrisRIP.visible = false;
			harrisAngel.visible = false;
		}
		
		public function setupSkiingSprites():void
		{
			isFrogger = false;
			
			harrisSkiing = new FlxSprite(140, 16).loadGraphic(harrisSkiingPNG, true, false, 25, 28, true);
			harrisSkiing.addAnimation("down", [ 0 ]);
			harrisSkiing.addAnimation("left", [ 1 ]);
			harrisSkiing.addAnimation("right", [ 2 ]);
			harrisSkiing.addAnimation("snowdown", [ 0 ]);
			harrisSkiing.addAnimation("snowleft", [ 1 ]);
			harrisSkiing.addAnimation("snowright", [ 2 ]);
			harrisSkiing.facing = FlxSprite.DOWN;
			
			setupRIPSprites();
			
			add(harrisSkiing);
			add(harrisRIP);
			add(harrisAngel);
		}
		
		public function get X():int
		{
			return harrisWalking.x;
		}
		
		public function get Y():int
		{
			return harrisWalking.y;
		}
		
		public function get activeSprite():FlxSprite
		{
			if (isFrogger)
			{
				return harrisWalking;
			}
			
			return harrisSkiing;
		}
		
		public function get bottomY():int
		{
			return activeSprite.y + activeSprite.height;
		}
		
		public function rip():void
		{
			isDead = true;
			
			harrisRIP.x = activeSprite.x + 4;
			harrisRIP.y = activeSprite.y + 6;
			
			harrisAngel.x = activeSprite.x;
			harrisAngel.y = activeSprite.y - harrisAngel.height;
			
			activeSprite.visible = false;
			harrisRIP.visible = true;
			harrisAngel.visible = true;
			
			if (isFrogger)
			{
				theSkis.visible = false;
			}
		}
		
		public function pickUpSkis():void
		{
			theSkis.visible = true;
		}
		
		public function dropSkis():void
		{
			theSkis.visible = false;
		}
		
		private function movement():void
		{
			var isMoving:Boolean = false;
			
			if (FlxG.keys.LEFT && harrisWalking.x > 0)
			{
				if (harrisWalking.facing != FlxSprite.LEFT)
				{
					harrisWalking.facing = FlxSprite.LEFT;
					harrisWalking.play("left");
					theSkis.play("left");
				}
				
				harrisWalking.x -= FlxG.elapsed * moveSpeed;
				theSkis.x = harrisWalking.x - 2;
				isMoving = true;
			}
			
			if (FlxG.keys.RIGHT && harrisWalking.x < FlxG.width - 23)
			{
				if (harrisWalking.facing != FlxSprite.RIGHT)
				{
					harrisWalking.facing = FlxSprite.RIGHT;
					harrisWalking.play("right");
					theSkis.play("right");
				}
				
				harrisWalking.x += FlxG.elapsed * moveSpeed;
				theSkis.x = harrisWalking.right;
				isMoving = true;
			}
			
			if (isMoving == false && FlxG.keys.UP && harrisWalking.y > 0)
			{
				if (harrisWalking.facing != FlxSprite.UP)
				{
					harrisWalking.facing = FlxSprite.UP;
					harrisWalking.play("up");
				}
				
				harrisWalking.y -= FlxG.elapsed * moveSpeed;
				theSkis.y = harrisWalking.y;
				isMoving = true;
			}
			
			if (isMoving == false && FlxG.keys.DOWN && harrisWalking.y < FlxG.height - 20)
			{
				if (harrisWalking.facing != FlxSprite.DOWN)
				{
					harrisWalking.facing = FlxSprite.DOWN;
					harrisWalking.play("down");
				}
				
				harrisWalking.y += FlxG.elapsed * moveSpeed;
				theSkis.y = harrisWalking.y;
				isMoving = true;
			}
			
			if (isMoving == false && harrisWalking.frame != 4)
			{
				harrisWalking.facing = FlxSprite.DOWN;
				harrisWalking.play("down");
			}
		}
		
		private function backToStart():void
		{
			harrisWalking.x = 64;
			harrisWalking.y = 0;
			harrisWalking.visible = true;
			harrisWalking.facing = FlxSprite.DOWN;
			
			harrisRIP.visible = false;
			harrisAngel.visible = false;
			
			isDead = false;
			hasSkis = false;
		}
		
		private function roadUpdate():void
		{
			if (isDead)
			{
				harrisAngel.y -= FlxG.elapsed * 30;
				
				if (harrisAngel.y < -60)
				{
					//	Check if they can afford an ambulance?
					backToStart();
				}
			}
			else
			{
				movement();
			}
		}
		
		private function skiUpdate():void
		{
			if (isDead)
			{
				harrisAngel.y -= FlxG.elapsed * 30;
				
				if (harrisAngel.y < -60)
				{
					//	Check if they can afford an ambulance?
					//backToStart();
					
				}
			}
			else
			{
				var isMoving:Boolean = false;
				
				if (FlxG.keys.LEFT && harrisSkiing.x > 0)
				{
					if (harrisSkiing.facing != FlxSprite.LEFT)
					{
						harrisSkiing.facing = FlxSprite.LEFT;
						harrisSkiing.play("left");
					}
					
					harrisSkiing.x -= FlxG.elapsed * skiSpeed;
					isMoving = true;
				}
				
				if (FlxG.keys.RIGHT && harrisSkiing.x < FlxG.width - 25)
				{
					if (harrisSkiing.facing != FlxSprite.RIGHT)
					{
						harrisSkiing.facing = FlxSprite.RIGHT;
						harrisSkiing.play("right");
					}
					
					harrisSkiing.x += FlxG.elapsed * skiSpeed;
					isMoving = true;
				}
				
				if (isMoving == false && harrisSkiing.frame != 0)
				{
					harrisSkiing.facing = FlxSprite.DOWN;
					harrisSkiing.play("down");
				}
			}
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (isFrogger)
			{
				roadUpdate();
			}
			else
			{
				skiUpdate();
			}
		}
		
	}

}