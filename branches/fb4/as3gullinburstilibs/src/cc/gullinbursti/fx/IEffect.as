/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	IEffect		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	06-09-09
 * 
 * Purpose	:	Provides an interface for the fx package.	
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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	
	/**
	 * The interface definition for an effect.
	 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
	 * <p>The <code>IEffect</code> implementor provides access to 
	 * <code>IEffect</code> objects.</p>
	 * 
	 * <p>An <code>IEffect</code> assumes these responsibilities:<ul>
	 * <li>Provides <code>applyFX</code> for rendering the effect</li>
	 * <li>Provides accessor <code>get mappingPoint</code> returning the filter's mapping point</li>
	 * <li>Provides accessor <code>set mappingPoint</code> for setting the filter's mapping point</li>
	 * </ul></p>
	 */
	// <[!] interface delaration [!]>
	public interface IEffect {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
	
		/**
		 * Applies the effect to bitmap data.
		**/
		function applyFX(obj:Object, rect:Rectangle=null):void;
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		
		/**
		 * Gets the mapping point.
		**/
		function get mappingPoint():Point;
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		/**
		 * Sets the mapping point.
		**/
		function set mappingPoint(val:Point):void;
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		
		/**
		 * Gets the rectange area to apply filter on.
		**/
		function get renderRect():Rectangle;
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		/**
		 * Sets the rendered area rectangle.
		**/
		function set renderRect(val:Rectangle):void;
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
	}
}