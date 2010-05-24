/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	TintFX.as		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	06-09-09
 * 
 * Purpose	:	Provides a color tint to a UI element.	
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


package cc.gullinbursti.fx {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
     * Renders a tint fx.</p>
    **/
    // <[!] class delaration [!]>
	public class TintFX extends AbstractFX implements IEffect {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		// RGB to Luminance conversion constants as found on
		// Charles A. Poynton's colorspace-faq:
		// http://www.faqs.org/faqs/graphics/colorspace-faq/
		
		private static const RED_MULT:Number = 0.212671;
		private static const GREEN_MULT:Number = 0.715160;
		private static const BLUE_MULT:Number = 0.072169;
		
		
		private var _rgb:uint;
		private var _red_val:Number;
		private var _green_val:Number;
		private var _blue_val:Number;
		private var _amt:Number;
		
		private var _color_arr:Array;
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		/**
		 * 
		 **/
		// <*] class constructor [*>
		public function TintFX(rgb:uint=0x00, amt:Number=0) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			_rgb = rgb;
			_amt = amt;
			
			super();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		override public function applyFX(obj:Object, rect:Rectangle=null):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			calcColors();
			
			super.applyFX(obj, rect);
			
			// create a new blur filter
			var filter:ColorMatrixFilter = spawnFilter();
			
			// the type of object
			if (obj as DisplayObject) {
				
				// cast as a display object
				var dispObj:DisplayObject = obj as DisplayObject;
					dispObj.filters = [filter];
					
			} else {
				
				// cast as bmp data & apply
				var matte:BitmapData = obj as BitmapData;
					matte.applyFilter(matte, this.renderRect, this.mappingPoint, filter);
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private function calcColors():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			_red_val   = (( _rgb >> 16 ) & 0xff) / 255;
			_green_val = (( _rgb >> 8  ) & 0xff) / 255;
			_blue_val  = (  _rgb         & 0xff) / 255;
			
			var inv_amt:Number = 1 - _amt;
			
			_color_arr = new Array(
				inv_amt+_amt*_red_val*RED_MULT, _amt*_red_val*GREEN_MULT, _amt*_red_val*BLUE_MULT, 0, 0, 
				_amt*_green_val*RED_MULT, inv_amt+_amt*_green_val*GREEN_MULT, _amt*_green_val*BLUE_MULT, 0, 0, 
				_amt*_blue_val*RED_MULT, _amt*_blue_val*GREEN_MULT, inv_amt+_amt*_blue_val*BLUE_MULT, 0, 0, 
				0, 0, 0, 1, 0
			);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		private function spawnFilter():ColorMatrixFilter {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			return (new ColorMatrixFilter(_color_arr));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function get color():uint {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			return (_rgb);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set color(val:uint):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			_rgb = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function get amount():Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (_amt);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function set amount(val:Number):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			_amt = val;
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}