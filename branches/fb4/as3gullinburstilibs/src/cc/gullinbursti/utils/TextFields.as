/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	TextFields.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	06-02-09
 * 
 * Purpose	:	Does some things on TextFields.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/


/*
Licensed under the MIT License
Copyright (c) 2009 Matt Holcombe (matt@gullinbursti.cc)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://code.gullinbursti.cc/
http://en.wikipedia.org/wiki/MIT_license/

[]~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~[].
*/



package cc.gullinbursti.utils {
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	// <[!] class delaration [¡]>
	public class TextFields {
	//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function TextFields() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		// Returns an object with the xMin, xMax, yMin, and yMax, x, y, textWidth, 
		// and textHeight of the TEXT inside of a TextField (not the TextField box)
		public static function getTextBounds(tf:TextField):Object {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var fmt:TextFormat = tf.getTextFormat();
			var bounds:Object = {};
			
			if (fmt.align == "right")
				bounds.xMax = tf.x + tf.width - 2; //There's a 2-pixel margin on TextFields.
			
			else if (fmt.align == "center")
				bounds.xMax = tf.x + (tf.width / 2) + (tf.textWidth / 2);
				
			else
				bounds.xMax = tf.x + tf.textWidth + 2; //There's a 2-pixel margin on TextFields.
			
			bounds.xMin = bounds.xMax - tf.textWidth;
			bounds.yMax = tf.y + tf.textHeight + 2; //There's a 2-pixel margin on TextFields.
			bounds.yMin = tf.y + 2;
			bounds.y = bounds.yMin;
			bounds.x = bounds.xMin;
			bounds.textWidth = tf.textWidth;
			bounds.textHeight = tf.textHeight;
			
			/*
			trace ("<[: [bounds.xMin:["+bounds.xMin+"] bounds.xMax:["+bounds.xMax+"]")
			trace ("<[: [tf.textWidth:["+tf.textWidth+"] tf.textHeight:["+tf.textHeight+"]");
			trace ("<[: [bounds.yMin:["+bounds.yMin+"] bounds.yMax:["+bounds.yMax+"]");
			trace ("<[: [bounds.x:["+bounds.x+"] bounds.y:["+bounds.y+"]");
			trace ("<[: [bounds.textWidth:["+bounds.textWidth+"] bounds.textHeight:["+bounds.textHeight+"]");
			*/
			
			return (bounds);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function buildCSS(css_arr:Array):StyleSheet {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// style sheet to return
			var css:StyleSheet = new StyleSheet();
			
			// loop thru array
			for (var i:int=0; i<css_arr.length; i++) {
				
				// pull elements as an obj
				var style_obj:Object = css_arr[i] as Object;
				
				// set the style from obj
				css.setStyle(style_obj['prop'], style_obj['vals']);
			}
			
			return (css);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/*
		// Goes through each line of a TextField, measures its textWidth and textHeight 
		// and it's x and y coordinate and returns an array of objects (one for each line). 
		// The objects have the following properties: x, y,width, height, leading, ascent, descent, and text.
		public static function getLineMetrics(tf:TextField):Object {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var final_array:Array = []; //Measurements array - one for each line of text.
			var format:TextFormat = tf.getTextFormat(0,1);
			var originalLeading:Object = format.leading;
			var originalExtent:Object = format.getTextExtent("Mg");
			
			format.leading = 0;
			tf.setNewTextFormat(format); //Otherwise the formatting got lost on dynamically-created TextFields!
			
			var lines_array:Array = tf.text.split(String.fromCharCode(13)); //Takes hard-coded line breaks into consideration. We split the string apart at each of them.
			var originalText:String = tf.text; 
			var originalHeight:Number = tf.height;
			
			tf.text = "Mg";
			
			var textHeight:Number = tf.textHeight;
			
			format.leading = originalLeading;
			tf.setNewTextFormat(format); //Otherwise the formatting got lost on dynamically-created TextFields!
			tf.text = "M\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM\nM"; //Just needed something with a tall ascender and a low descender for measurement purposes.
			
			var lineHeight:Number = tf.textHeight / 20 + (format.leading / 20); //We used 20 lines and averaged them to find a more accurate space between. When we only used one, it started drifting slightly after a few lines (more and more as the number of lines increased).
			var padY:int = 3; //To accommodate the 3 pixel margin at the top of the TextField.
			var lastWidth:Number = 0; 
			var lastText:String = "";
			
			tf.text = "";
			tf._height = lineHeight + 6;//Just give it some breathing room - we don't want to risk cutting off the first line.
			
			var words_array:Array;
			var x:Number;
			var i:int;
			var j:int;
			
			for (i = 0; i < lines_array.length; i++) {
				words_array = lines_array[i].split(" ");
				
				//Loop through and add each word to the TextField one by one until the line breaks (maxscroll > 1).
				for (j = 0; j < words_array.length; j++) { 
					tf.text += words_array[j] + " ";
					
					if (tf.maxscroll != 1) {
						
						if (format.align == "right")
							x = tf._x + tf._width - lastWidth - 2; //There's a 2-pixel margin on TextFields.
						
						else if (format.align == "center")
							x = tf._x + (tf._width / 2) - (lastWidth / 2);
						
						else
							x = tf._x + 2; //There's a 2-pixel margin on TextFields.
						
						final_array.push({text:lastText, x:x, y:padY + tf._y + Math.round(final_array.length * (lineHeight)), width:lastWidth, height:textHeight, lineHeight:lineHeight, leading:originalLeading, ascent:originalExtent.ascent, descent:originalExtent.descent});
						tf.text = words_array[j] + " ";
					}
					
					lastWidth = tf.textWidth; 
					lastText = tf.text;
				}
				
				 //Just get rid of the extra space at the end.
				lastText = lastText.substr(0, lastText.length - 1);
				
				//I realize this is duplicate code from above which could be wrapped into a function, but doing so would hurt performance and since this function demands a lot from the processor, I thought it best to prioritize performance.				
				if (format.align == "right") 
					x = tf._x + tf._width - lastWidth - 2; //There's a 2-pixel margin on TextFields.
				
				else if (format.align == "center")
					x = tf._x + (tf._width / 2) - (lastWidth / 2);
					
				else
					x = tf._x + 2; //There's a 2-pixel margin on TextFields.
				
				final_array.push({text:lastText, x:x, y:padY + tf._y + Math.round(final_array.length * (lineHeight)), width:lastWidth, height:textHeight, lineHeight:lineHeight, leading:originalLeading, ascent:originalExtent.ascent, descent:originalExtent.descent});
				
				tf.text = "";
				lastWidth = 0;
				lastText = "";
			}
			
			tf._height = originalHeight;
			tf.text = originalText;
			
			return (final_array);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		// Finds the x, y, width, height, leading, ascent, descent, and 
		// lineHeight of all of the instances of a given string within a TextField
		public static function getSubstringMetrics(tf:TextField):Object {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var instances_array:Array = new Array;
			var lines_array:Array = getLineMetrics(tf);
			var ascent:Number = lines_array[0].ascent;
			var descent:Number = lines_array[0].descent;
			var lineHeight:Number = lines_array[0].lineHeight;
			var leading:Number = lines_array[0].leading;
			var format:TextFormat = tf.getTextFormat(0,1);
			
			tf.setNewTextFormat(format); //Otherwise the formatting got lost on dynamically-created TextFields!
			
			var originalText:String = tf.text; 
			var originalHeight:Number = tf.height;
			
			tf.text = text_str;
			
			var te:Number = format.getTextExtent(text_str);
			var textWidth:Number = Math.max(te.width, tf.textWidth); //Sometimes one is slightly more accurate than the other - we'll always use the bigger number though.
			var textHeight:Number = lines_array[0].height;
			
			tf.text = "M";
			
			var mWidth:Number = tf.textWidth;
			var i:int;
			var j:int;
			var ia:Array;
			var line
			var index:Number;
			var x:Number;
			
			for (i = 0; i < lines_array.length; i++) {
				line = lines_array[i];
				ia = line.text.split(text_str);
				ia.pop();
				tf.text = "";
				
				for (j = 0; j < ia.length; j++) {
					tf.text += ia[j] + "M"; //We pad the end with an "M" in case there is one or more spaces at the end (which Flash ignores in measurements in center- and right-aligned TextFields		
					instances_array.push({x:line.x + tf.textWidth - mWidth, y:line.y, width:textWidth, height:textHeight, lineHeight:lineHeight, leading:leading, ascent:ascent, descent:descent});
					tf.text = tf.text.substr(0, -1) + text_str;
				}
			}
			
			tf._height = originalHeight;
			tf.text = originalText;
			
			return (instances_array);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		*/
	}
}