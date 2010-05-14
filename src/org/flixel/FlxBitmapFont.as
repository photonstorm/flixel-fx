package org.flixel 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class FlxBitmapFont
	{
		private var fontSet:BitmapData;
		private var offsetX:uint;
		private var offsetY:uint;
		private var characterWidth:uint;
		private var characterHeight:uint;
		private var characterSpacingX:uint;
		private var characterSpacingY:uint;
		private var characterPerRow:uint;
		private var grabData:Array
		
		/**
		 * Stores the 'on' or highlighted button state label.
		 */
		public static const ALIGN_LEFT:String = "left";
		public static const ALIGN_RIGHT:String = "right";
		public static const ALIGN_CENTER:String = "center";
		
		public static const TEXT_SET1:String = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
		public static const TEXT_SET2:String = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		public static const TEXT_SET3:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ";
		public static const TEXT_SET4:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789";
		public static const TEXT_SET5:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,/() '!?-*:0123456789";
		public static const TEXT_SET6:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?:;0123456789\"(),-.' ";
		public static const TEXT_SET7:String = "AGMSY+:4BHNTZ!;5CIOU.?06DJPV,(17EKQW\")28FLRX-'39";
		public static const TEXT_SET8:String = "0123456789 .ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		public static const TEXT_SET9:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ()-0123456789.:,'\"?!";
		public static const TEXT_SET10:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		public static const TEXT_SET11:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,\"-+!?()':;0123456789";
		
		/**
		 * Loads a bitmap font set into memory and creates a new <code>FlxBitmapFont</code> object, for future use by the getLine, getMultiLine, getCharacter methods and dependant classes.
		 * 
		 * @param	font		The font set graphic.
		 * @param	width		The width of each character in the font set.
		 * @param	height		The height of each character in the font set.
		 * @param	chars		The characters used in the font set, in display order. You can use the TEXT_SET consts for common font set arrangements.
		 * @param	charsPerRow	The number of characters per row in the font set.
		 * @param	xSpacing	If the characters in the font set have horizontal spacing between them set the required amount here.
		 * @param	ySpacing	If the characters in the font set have vertical spacing between them set the required amount here
		 * @param	xOffset		If the font set doesn't start at the top left of the given image, specify the X coordinate offset here.
		 * @param	yOffset		If the font set doesn't start at the top left of the given image, specify the Y coordinate offset here.
		 */
        public function FlxBitmapFont(font:Class, width:uint, height:uint, chars:String, charsPerRow:uint, xSpacing:uint = 0, ySpacing:uint = 0, xOffset:uint = 0, yOffset:uint = 0):void
        {
			//	Take a copy of the font for internal use
			fontSet = (new font).bitmapData;
			
			characterWidth = width;
			characterHeight = height;
			characterSpacingX = xSpacing;
			characterSpacingY = ySpacing;
			characterPerRow = charsPerRow;
			offsetX = xOffset;
			offsetY = yOffset;
			
			grabData = new Array();
			
			//	Now generate our rects for faster copyPixels later on
			var currentX:uint = offsetX;
			var currentY:uint = offsetY;
			var r:uint = 0;
			
			for (var c:uint = 0; c < chars.length; c++)
			{
				//	The rect is hooked to the ASCII value of the character
				grabData[chars.charCodeAt(c)] = new Rectangle(currentX, currentY, characterWidth, characterHeight);
				
				r++;
				
				if (r == characterPerRow)
				{
					r = 0;
					currentX = offsetX;
					currentY += characterHeight + characterSpacingY;
				}
				else
				{
					currentX += characterWidth + characterSpacingX;
				}
			}
        }
		
		/**
		 * Return an <code>FlxSprite</code> containing 1 line of text, drawn using the currently loaded bitmap font.
		 * 
		 * @param	text			The string of text to return. Carriage returns are automatically stripped out.
		 * @param	customSpacingX	To add extra horizontal spacing between each character specify the amount here.
		 * @param	autoUpperCase	Lots of bitmap font sets only include upper-case characters, if yours supports lower case then set this to false.
		 * 
		 * @return	An <code>FlxSprite</code> containing the given line of text.
		 */
		public function getLine(text:String, customSpacingX:uint = 0, autoUpperCase:Boolean = true):FlxSprite
		{
			if (autoUpperCase)
			{
				text = text.toUpperCase();
			}
			
			//	Remove all characters not supported by this font set (excluding spaces)
			text = removeUnsupportedCharacters(text);
			
			var output:BitmapData = new BitmapData(text.length * (characterWidth + customSpacingX), characterHeight, true, 0xf);
			
			var s:FlxSprite = new FlxSprite();
			
			pasteLine(output, text, 0, 0, customSpacingX);
			
			s.pixels = output;
			
			return s;
		}
		
		/**
		 * Return an <code>FlxSprite</code> containing 1 line of text, drawn using the currently loaded bitmap font.
		 * 
		 * @param	text			The string of text to return. Carriage returns are automatically stripped out.
		 * @param	customSpacingX	To add extra horizontal spacing between each character specify the amount here.
		 * @param	customSpacingY	To add extra vertical spacing between each line of text specify the amount here.
		 * @param	align			Align each line of text. Either ALIGN_LEFT (default), ALIGN_RIGHT or ALIGN_CENTER.
		 * @param	autoUpperCase	Lots of bitmap font sets only include upper-case characters, if yours supports lower case then set this to false.
		 * 
		 * @return	An <code>FlxSprite</code> containing the given lines of text.
		 */
		public function getMultiLine(text:String, customSpacingX:uint = 0, customSpacingY:uint = 0, align:String = "left", autoUpperCase:Boolean = true):FlxSprite
		{
			if (autoUpperCase)
			{
				text = text.toUpperCase();
			}
			
			//	Remove all characters not supported by this font set (excluding carriage-returns & spaces)
			text = removeUnsupportedCharacters(text, false);
			
			//	Count how many lines there now are in the text
			var lines:Array = text.split("\n");
			
			var lineCount:uint = lines.length;
			
			//	Work out the longest line
			var longestLine:uint = getLongestLine(text);
			
			var x:int = 0;
			var y:int = 0;
			var output:FlxSprite = new FlxSprite();
			var temp:BitmapData = new BitmapData(longestLine * (characterWidth + customSpacingX), (lineCount * (characterHeight + customSpacingY)) - customSpacingY, true, 0xf);
			
			//	Loop through each line of text
			for (var i:uint = 0; i < lines.length; i++)
			{
				//	This line of text is held in lines[i] - need to work out the alignment
				switch (align)
				{
					case ALIGN_LEFT:
						x = 0;
						break;
						
					case ALIGN_RIGHT:
						x = temp.width - (lines[i].length * (characterWidth + customSpacingX));
						break;
						
					case ALIGN_CENTER:
						x = (temp.width / 2) - ((lines[i].length * (characterWidth + customSpacingX)) / 2);
						x += customSpacingX / 2;
						break;
				}
				
				pasteLine(temp, lines[i], x, y, customSpacingX);
				
				y += characterHeight + customSpacingY;
			}
			
			output.pixels = temp;
			
			return output;
		}
		
		//	Gets a single character and returns it without the overhead of calling getLine with a string of length 1
		
		/**
		 * Returns a single character from the font set as an FlxsSprite. Avoids the overhead of calling getLine() with a string of length 1.
		 * 
		 * @param	char	The character you wish to have returned.
		 * 
		 * @return	An <code>FlxSprite</code> containing a single character from the font set.
		 */
		public function getCharacter(char:String):FlxSprite
		{
			var output:FlxSprite = new FlxSprite();
			
			var temp:BitmapData = new BitmapData(characterWidth, characterHeight, true, 0xf);

			if (grabData[char.charCodeAt(0)] is Rectangle && char.charCodeAt(0) != 32)
			{
				temp.copyPixels(fontSet, grabData[char.charCodeAt(0)], new Point(0, 0));
			}
			
			output.pixels = temp;
			
			return output;
		}
		
		/**
		 * Internal function that takes a single line of text (2nd parameter) and pastes it into the BitmapData at the given coordinates.
		 * Used by getLine and getMultiLine
		 * 
		 * @param	output			The BitmapData that the text will be drawn onto
		 * @param	text			The single line of text to paste
		 * @param	x				The x coordinate
		 * @param	y
		 * @param	customSpacingX
		 */
		private function pasteLine(output:BitmapData, text:String, x:uint = 0, y:uint = 0, customSpacingX:uint = 0):void
		{
			for (var c:uint = 0; c < text.length; c++)
			{
				//	If it's a space then there is no point copying, so leave a blank space
				if (text.charAt(c) == " ")
				{
					x += characterWidth + customSpacingX;
				}
				else
				{
					//	If the character doesn't exist in the font then we don't want a blank space, we just want to skip it
					if (grabData[text.charCodeAt(c)] is Rectangle)
					{
						output.copyPixels(fontSet, grabData[text.charCodeAt(c)], new Point(x, y));
						x += characterWidth + customSpacingX;
					}
				}
			}
		}
		
		/**
		 * Works out the longest line of text in the given String and returns its length
		 * 
		 * @param	text	The string of text to check
		 * 
		 * @return	A value
		 */
		private function getLongestLine(text:String):uint
		{
			var longestLine:uint = 0;
			
			if (text.length > 0)
			{
				var lines:Array = text.split("\n");
				
				for (var i:uint = 0; i < lines.length; i++)
				{
					if (lines[i].length > longestLine)
					{
						longestLine = lines[i].length;
					}
				}
			}
			
			return longestLine;
		}
		
		/**
		 * Internal helper function that removes all unsupported characters from the String, leaving only characters contained in the font set.
		 * 
		 * @param	text		The string to check
		 * @param	stripCR		Should it strip carriage returns as well? (default = true)
		 * 
		 * @return	A clean version of the string
		 */
		private function removeUnsupportedCharacters(text:String, stripCR:Boolean = true):String
		{
			var newString:String = "";
			
			for (var c:uint = 0; c < text.length; c++)
			{
				if (grabData[text.charCodeAt(c)] is Rectangle || text.charCodeAt(c) == 32 || (stripCR == false && text.charAt(c) == "\n"))
				{
					newString = newString.concat(text.charAt(c));
				}
			}
			
			return newString;
		}
		
	}

}