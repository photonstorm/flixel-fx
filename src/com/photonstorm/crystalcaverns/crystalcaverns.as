package com.photonstorm.crystalcaverns
{
	import org.flixel.*;

	public class crystalcaverns extends FlxState
	{
		[Embed(source = '../../../../assets/crystalcaverns/tiles.png')] private var mapTiles:Class;
		[Embed(source = '../../../../assets/crystalcaverns/mapdata.txt', mimeType = "application/octet-stream")] private var mapData:Class;
		
		private var map:FlxTilemap;
		private var player:FlxSprite;
		
		public function crystalcaverns() 
		{
		}
		
		override public function create():void
		{
			player = new FlxSprite(90, 90).createGraphic(16, 16);
			player.velocity.x = 0;
			player.velocity.y = 0;
			player.maxVelocity.x = 200;
			player.maxVelocity.y = 200;
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			
			map = new FlxTilemap();
			map.loadMap(new mapData(), mapTiles, 16, 16);
			
			FlxG.follow(player, 1.5);
			FlxG.followBounds(0, 0, map.width, map.height);
			
			add(map);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			//player.velocity.x = 0;
			//player.velocity.y = 0;
			
			if (FlxG.keys.UP)
			{
				player.velocity.y -= FlxG.elapsed * 300;
			}
			
			if (FlxG.keys.DOWN)
			{
				player.velocity.y += FlxG.elapsed * 300;
			}
			
			if (FlxG.keys.LEFT)
			{
				player.velocity.x -= FlxG.elapsed * 300;
			}
			
			if (FlxG.keys.RIGHT)
			{
				player.velocity.x += FlxG.elapsed * 300;
			}
			
			map.collide(player);
		}
		
	}

}