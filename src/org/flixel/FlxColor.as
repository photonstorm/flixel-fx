/**
 * FlxColor - Adds a set of fast color manipulation specific functions
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel 
{
	/**
	 * <code>FlxColor</code> is a set of fast color manipulation functions.
	 * It can be used for creating gradient maps or general color translation.
	 */
	public class FlxColor
	{
		
		public function FlxColor() 
		{
		}
		
        /**
         * This function converts a standard Flash color value into an Array of HSL values
		 * 
         * @param	color	The integer RGB color value (0xRRGGBB), excluding Alpha
		 * 
         * @return The HSL color values in a 3 dimensional array
         */
		static public function colorToHSL(color:uint):Array
        {
			var rgb:Array = getRGB(color);
			
			return toHSL(rgb[0], rgb[1], rgb[2]);
        }
		
        static public function RGBToHSL(red:uint, green:uint, blue:uint):Array
        {
			return toHSL(red, green, blue);
        }
		
		static public function getGradientAsArray(color1:uint, color2:uint, steps:uint):Array
		{
			var result:Array = new Array(steps);
			
			for (var s:int = 0; s < steps; s++)
			{
				result.push(interpolateColor(color1, color2, steps, s));
			}
			
			return result;
		}
		
		static public function getHSVColorWheel():Array
		{
			var colours:Array = new Array();
			
			for (var c:int = 0; c <= 359; c++)
			{
				colours[c] = HSVtoRGB(c, 1.0, 1.0);
			}
			
			return colours;
		}
		
		static public function HSVtoRGB(h:Number, s:Number, v:Number):uint
		{
			var result:uint;
			
			if (s == 0.0)
			{
				result = getColor24(v * 255, v * 255, v * 255);
			}
			else
			{
				h = h / 60.0;
				var f:Number = h - int(h);
				var p:Number = v * (1.0 - s);
				var q:Number = v * (1.0 - s * f);
				var t:Number = v * (1.0 - s * (1.0 - f));
				
				switch (int(h))
				{
					case 0:
						result = getColor24(v * 255, t * 255, p * 255);
						break;
						
					case 1:
						result = getColor24(q * 255, v * 255, p * 255);
						break;
						
					case 2:
						result = getColor24(p * 255, v * 255, t * 255);
						break;
						
					case 3:
						result = getColor24(p * 255, q * 255, v * 255);
						break;
						
					case 4:
						result = getColor24(t * 255, p * 255, v * 255);
						break;
						
					case 5:
						result = getColor24(v * 255, p * 255, q * 255);
						break;
						
					default:
						FlxG.log("unknown colour");
				}
			}
			
			return result;
		}
		
		static private function toHSL(r:uint, g:uint, b:uint):Array
		{
			var red:Number = r / 255;
			var green:Number = g / 255;
			var blue:Number = b / 255;
			
			var min:Number = Math.min(red, green, blue);
            var max:Number = Math.max(red, green, blue);
            var delta:Number = max - min;
            var lightness:Number = (max + min) / 2;
			var hue:Number;
			var saturation:Number;
			
            //  Grey color, no chroma
            if (delta == 0)
            {
                hue = 0;
                saturation = 0;
            }
            else
            {
                if (lightness < 0.5)
                {
                    saturation = delta / (max + min);
                }
                else
                {
                    saturation = delta / (2 - max - min);
                }
                
                var delta_r:Number = (((max - red) / 6) + (delta / 2)) / delta;
                var delta_g:Number = (((max - green) / 6) + (delta / 2)) / delta;
                var delta_b:Number = (((max - blue) / 6) + (delta / 2)) / delta;
                
                if (red == max)
                {
                    hue = delta_b - delta_g;
                }
                else if (green == max)
                {
                    hue = (1 / 3) + delta_r - delta_b;
                }
                else if (blue == max)
                {
                    hue = (2 / 3) + delta_g - delta_r;
                }
                
                if (hue < 0)
                {
                    hue += 1;
                }
                
                if (hue > 1)
                {
                    hue -= 1;
                }
            }
            
            return [hue, saturation, lightness];
		}
		
        static public function interpolateColor(color1:uint, color2:uint, steps:uint, currentStep:uint, alpha:uint = 255):uint
        {
			var src1:Array = getRGB(color1);
			var src2:Array = getRGB(color2);
			
            var r:uint = (((src2[0] - src1[0]) * currentStep) / steps) + src1[0];
            var g:uint = (((src2[1] - src1[1]) * currentStep) / steps) + src1[1];
            var b:uint = (((src2[2] - src1[2]) * currentStep) / steps) + src1[2];

			return getColor32(alpha, r, g, b);
        }
		
        static public function interpolateColorWithRGB(color:uint, r2:uint, g2:uint, b2:uint, steps:uint, currentStep:uint):uint
        {
			var src:Array = getRGB(color);
			
            var r:uint = (((r2 - src[0]) * currentStep) / steps) + src[0];
            var g:uint = (((g2 - src[1]) * currentStep) / steps) + src[1];
            var b:uint = (((b2 - src[2]) * currentStep) / steps) + src[2];
        
			return getColor24(r, g, b);
        }
		
        static public function interpolateRGB(r1:uint, g1:uint, b1:uint, r2:uint, g2:uint, b2:uint, steps:uint, currentStep:uint):uint
        {
            var r:uint = (((r2 - r1) * currentStep) / steps) + r1;
            var g:uint = (((g2 - g1) * currentStep) / steps) + g1;
            var b:uint = (((b2 - b1) * currentStep) / steps) + b1;
        
			return getColor24(r, g, b);
        }
		
		static public function getRandomColor24():uint
		{
			return getColor24(Math.random() * 255, Math.random() * 255, Math.random() * 255);
		}
		
		/**
		 * Given an alpha and 3 color values this will return an integer representation of it
		 * 
		 * @param	alpha	The Alpha value (between 0 and 255)
		 * @param	red		The Red channel value (between 0 and 255)
		 * @param	green	The Green channel value (between 0 and 255)
		 * @param	blue	The Blue channel value (between 0 and 255)
		 * 
		 * @return	A native color value integer (format: 0xAARRGGBB)
		 */
		static public function getColor32(alpha:uint, red:uint, green:uint, blue:uint):uint
		{
			return alpha << 24 | red << 16 | green << 8 | blue;
		}
		
		/**
		 * Given 3 colors values this will return an integer representation of it
		 * 
		 * @param	red		The Red channel value (between 0 and 255)
		 * @param	green	The Green channel value (between 0 and 255)
		 * @param	blue	The Blue channel value (between 0 and 255)
		 * 
		 * @return	A native color value integer (format: 0xRRGGBB)
		 */
		static public function getColor24(red:uint, green:uint, blue:uint):uint
		{
			return red << 16 | green << 8 | blue;
		}
		
		static public function getARGB(color:uint):Array
		{
			var alpha:uint = color >>> 24;
			var red:uint = color >> 16;
			var green:uint = color >> 8 & 0xFF;
			var blue:uint = color & 0xFF;
			
			return [ alpha, red, green, blue ];
		}
		
		static public function getRGB(color:uint):Array
		{
			var red:uint = color >> 16;
			var green:uint = color >> 8 & 0xFF;
			var blue:uint = color & 0xFF;
			
			return [ red, green, blue ];
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Alpha component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Alpha component of the color, will be between 0 and 255 (0 being no Alpha, 255 full Alpha)
		 */
		static public function getAlpha(color:uint):uint
		{
			return color >>> 24;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Red component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Red component of the color, will be between 0 and 255 (0 being no color, 255 full Red)
		 */
		static public function getRed(color:uint):uint
		{
			return color >> 16;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Green component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Green component of the color, will be between 0 and 255 (0 being no color, 255 full Green)
		 */
		static public function getGreen(color:uint):uint
		{
			return color >> 8 & 0xFF;
		}
		
		/**
		 * Given a native color value (in the format 0xAARRGGBB) this will return the Blue component, as a value between 0 and 255
		 * 
		 * @param	color	In the format 0xAARRGGBB
		 * 
		 * @return	The Blue component of the color, will be between 0 and 255 (0 being no color, 255 full Blue)
		 */
		static public function getBlue(color:uint):uint
		{
			return color & 0xFF;
		}
		
	}

}