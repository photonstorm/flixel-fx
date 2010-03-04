/**
 * FlxGradient - Adds a set of gradient creation / rendering functions
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel 
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.GradientType; 
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	
	public class FlxGradient
	{
		
		public function FlxGradient() 
		{
		}
		
		static public function createGradientMatrix(width:int, height:int, colors:Array, chunkSize:int = 1, rotation:int = 90):Object
		{
			var gradientMatrix:Matrix = new Matrix();
			
			//	Rotation (in radians) that the gradient is rotated
			var rot:Number = FlxMath.asRadians(rotation);
			
			//	Last 2 values = horizontal and vertical shift (in pixels)
			if (chunkSize == 1)
			{
				gradientMatrix.createGradientBox(width, height, rot, 0, 0);
			}
			else
			{
				gradientMatrix.createGradientBox(width, height / chunkSize, rot, 0, 0);
			}
			
			//	Create the alpha and ratio arrays
			
			var alpha:Array = new Array();
			
			for (var ai:int = 0; ai < colors.length; ai++)
			{
				alpha.push(1);
			}
			
			var ratio:Array = new Array();
			
			if (colors.length == 2)
			{
				ratio[0] = 0;
				ratio[1] = 255;
			}
			else
			{
				//	Spread value
				var spread:int = 255 / (colors.length - 1);
				
				ratio.push(0);
				
				for (var ri:int = 1; ri < colors.length - 1; ri++)
				{
					ratio.push(ri * spread);
				}
				
				ratio.push(255);
			}
			
			return { matrix: gradientMatrix, alpha: alpha, ratio: ratio };
		}
		
		static public function createGradientArray(width:int, height:int, colors:Array, chunkSize:int = 1, rotation:int = 90, interpolate:Boolean = true):Array
		{
			var sprite:FlxSprite = createGradientFlxSprite(width, height, colors, chunkSize, rotation, interpolate);
			
			var data:BitmapData = sprite.pixels;
			
			var result:Array = new Array();
			
			for (var y:int = 0; y <= data.height; y++)
			{
				result.push(data.getPixel(0, y));
			}
			
			return result;
		}
		
		static public function createGradientFlxSprite(width:int, height:int, colors:Array, chunkSize:int = 1, rotation:int = 90, interpolate:Boolean = true):FlxSprite
		{
			//	Sanity checks
			if (width < 1)
			{
				width = 1;
			}
			
			if (height < 1)
			{
				height = 1;
			}
			
			var gradient:Object = createGradientMatrix(width, height, colors, chunkSize, rotation);
			
			var s:Shape = new Shape();
			
			if (interpolate)
			{
				s.graphics.beginGradientFill(GradientType.LINEAR, colors, gradient.alpha, gradient.ratio, gradient.matrix, SpreadMethod.PAD, InterpolationMethod.RGB, 0);
			}
			else
			{
				s.graphics.beginGradientFill(GradientType.LINEAR, colors, gradient.alpha, gradient.ratio, gradient.matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 0);
			}
			
			if (chunkSize == 1)
			{
				s.graphics.drawRect(0, 0, width, height);
			}
			else
			{
				s.graphics.drawRect(0, 0, width, height / chunkSize);
			}

			var dest:FlxSprite = new FlxSprite().createGraphic(width, height);
			
			var data:BitmapData = dest.pixels;
			
			if (chunkSize == 1)
			{
				data.draw(s);
			}
			else
			{
				var tempBitmap:Bitmap = new Bitmap(new BitmapData(width, height / chunkSize));
				tempBitmap.bitmapData.draw(s);
				tempBitmap.scaleY = chunkSize;
				
				var sM:Matrix = new Matrix();
				sM.scale(tempBitmap.scaleX, tempBitmap.scaleY);
				
				data.draw(tempBitmap, sM);
			}
			
			dest.pixels = data;
			
			return dest;
		}
		
		//static public function createGradientSprite():FlxSprite
		//{
		//}
		
	}

}