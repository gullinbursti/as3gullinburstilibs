/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	ScrollBarUI		
 * Version	: 	1.0
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	05-23-09
 * 
 * Purpose	:	Provides a flexible scroll bar UI component.	
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


package cc.gullinbursti.ui {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import caurina.transitions.Tweener;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[


	/**
     * <p>Renders a scroll bar.</p>
    **/
    // <[!] class delaration [!]>
	public class ScrollBarUI extends Sprite {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._

		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		private var track_size:int;
		private var content_size:int;
		private var view_size:int;
		private var scroll_ratio:Number;
		private var contentTo_pos:int;
		
		private var knob_rect:Rectangle;
		private var idleKnobStroke:int;
		private var overKnobStroke:int;
		private var knob_fill:int;
		
		private var track_sprite:Sprite = new Sprite();
		private var knob_sprite:Sprite = new Sprite();
		
		private var content_sprite:Sprite;
		private var mask_sprite:Sprite;
		
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>

		/**
		 * The scroll bar's contructor.
		 * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		 * <p>Calls the superclass, and sets up the class props.</p>
		 * 
		 * @param isVisible boolean value to show on creation
		**/
		// <*] class constructor [*>
		public function ScrollBarUI(scrollContent:Sprite) {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// call parent class
			super();
			
			content_sprite = scrollContent;
			
			// make the sprites
			establishTrack();
			establishKnob();
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
         * Creates the track sprite.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Removes the track if already there & 
         * creates a new one.</p>
         * 
        **/
		private function establishTrack():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// already has a track
			if (this.contains(track_sprite)) {
				
				// drop listeners
				track_sprite.removeEventListener(MouseEvent.CLICK, hdlClick);
				
				// remove the sprite
				this.removeChild(track_sprite);
			}
			
			// make a new one
			track_sprite = new Sprite();
			
			// mouse props
			track_sprite.buttonMode = true;
			track_sprite.useHandCursor = true;
			
			// add some mouse listeners
			track_sprite.addEventListener(MouseEvent.CLICK, hdlClick);
			
			// add to stage
			this.addChild(track_sprite);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Creates the knob sprite.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Removes the knob if already there & 
         * creates a new one.</p>
         * 
        **/
		private function establishKnob():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// already on stage
			if (this.contains(knob_sprite)) {
				
				// drop listeners
				knob_sprite.removeEventListener(MouseEvent.CLICK, hdlClick);
				
				// remove the sprite
				this.removeChild(knob_sprite);
			}
			
			// make a new one
			knob_sprite = new Sprite();
			
			// mouse props
			knob_sprite.buttonMode = true;
			knob_sprite.useHandCursor = true;
			
			// add some mouse listeners
			knob_sprite.addEventListener(MouseEvent.CLICK, hdlClick);
			knob_sprite.addEventListener(MouseEvent.MOUSE_DOWN, hdlMouse_Down);
			
			// add to stage
			this.addChild(knob_sprite);
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=[> .-[PUBLIC METHODS]_. ]=~=~=[>
		
		
		
		public function set scrollContent(val:Sprite):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			content_sprite = val as Sprite;
			content_size = content_sprite.height;
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Calculates the scroll ratio.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Takes the track distance & divides</p>
         * 
         * @param track_dist the distance the track has
         * @param view_dist the viewable amount
         * 
        **/
		public function updateRatio(track_dist:int, view_dist:int):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//trace("ScrollBarUI.updateRatio: ["+content_sprite.height+"]["+track_dist+"]["+view_dist+"]");
			
			track_size = track_dist;
			view_size = view_dist;
			
			scroll_ratio = (content_sprite.height - view_size) / track_size;
			//trace("ScrollBarUI.scroll_ratio = "+scroll_ratio) 
					
			//if (scroll_ratio <= 0)
			//	toggleEnabled(false);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Returns the content to zero.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p></p>
         * 
         * @param track_dist the distance the track has
         * @param view_dist the viewable amount
         * 
        **/
		public function tare():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
			Tweener.addTween(knob_sprite, {
				y:0, 
				time:0.25, 
				transition:"easeoutsine", 
				
				onUpdate:function():void {
					contentTo_pos = getTweenToPos(knob_sprite.y);
					content_sprite.y = contentTo_pos;
				}
			});
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Draws the scroll track.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Draws a rectangle representing the track.</p>
         * 
         * @param pos_rect the area to make the track
         * @param fill color to fill the track with
         * 
        **/
		public function drawTrack(pos_rect:Rectangle, fill:int):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var g:Graphics = track_sprite.graphics;
				g.clear();
				g.beginFill(fill);
				g.drawRect(pos_rect.x, pos_rect.y, pos_rect.width, pos_rect.height);
				g.endFill();
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Draws the scroll knob.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Draws a rectangle representing the knob.</p>
         * 
         * @param pos_rect the area to make the knob
         * @param stroke color to make the stroke
         * @param fill color to fill the track with
         * 
        **/
		public function drawKnob(pos_rect:Rectangle, stroke:int, fill:int, overStroke:int=-1):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			knob_rect = new Rectangle(pos_rect.x, pos_rect.y, pos_rect.width, pos_rect.height);
			idleKnobStroke = stroke;
			knob_fill = fill;
			
			if (overStroke > -1)
				overKnobStroke = overStroke;
			
			else
				overKnobStroke = stroke;
				
			
			var g:Graphics = knob_sprite.graphics;
				g.clear();
				g.lineStyle(1, stroke);
				g.beginFill(fill);
				g.drawRect(knob_rect.x, knob_rect.y, knob_rect.width, knob_rect.height);
				g.endFill();
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Moves the scroll knob and content.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Moves the scroll knob and tweens the content.</p>
         * 
         * @param dist the ditance to move the knob
         * 
        **/
		public function moveKnob(dist:int):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var pos:int = knob_sprite.y + dist;
			
			if (pos < 0)
				pos = 0;
				
			if (pos > track_size)
				pos = track_size;
				
			knob_sprite.y = pos;
			hdlEnterFrame();
		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Turns the scroll bar on/off.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Toggles visibility from passed param.</p>
         * 
         * @param isVisible determines the toggle action
         * 
        **/
		public function toggleVisibility(isVisible:Boolean):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			trace("ScrollBarUI.toggleVisibility: "+isVisible);
			
			this.mouseChildren = isVisible;
			this.visible = isVisible;
			
			toggleEnabled(isVisible);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Enables / disables the scroll bar.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Toggles enability from passed param.</p>
         * 
         * @param isVisible determines the toggle action
         * 
        **/
		public function toggleEnabled(isEnabled:Boolean):void {
			trace("ScrollBarUI.toggleEnabled: "+isEnabled);
			
			// set mouse children
			this.mouseChildren = isEnabled;
			
			// enable
			if (isEnabled) {
				
				// alpha tween to full
				Tweener.addTween(this, {
					alpha:1, 
					time:0.5, 
					transition:"easeoutquad", 
					
					onComplete:function():void {}
				});
			
			
			// disable
			} else {
				
				// alpha tween to zero
				Tweener.addTween(this, {
					alpha:0, 
					time:0.25, 
					transition:"easeinquad", 
					
					onComplete:function():void {}
				});
			}
		}
		
		
		/**
         * Returns the position to tween to.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>.</p>
        **/
		private function tweenContent():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			Tweener.addTween(content_sprite, {
				y:contentTo_pos, 
				time:0.33, 
				transition:"easeoutsine"
			});
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Returns the position to tween to.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>.</p>
        **/
		private function getTweenToPos(yMouse:int):int {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			return (yMouse * -scroll_ratio);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
         * Handler function for scroll rollover.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Tweens the overlay, changes thumb colors, and
         * changes the text formatting when rolling over.</p>
        **/
		private function hdlRollOver(e:MouseEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			trace("hdlRollOver: "+hdlRollOver);
			
			// idle & over stroke colors are !=
			if (idleKnobStroke != overKnobStroke) {
				
				// redraw the stroke
				var g:Graphics = knob_sprite.graphics;
					g.clear();
					g.lineStyle(1, overKnobStroke);
					g.beginFill(knob_fill*0xff);
					g.drawRect(knob_rect.x, knob_rect.y, knob_rect.width, knob_rect.height);
					g.endFill(); 
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Handler function for scroll rollout.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Tweens the overlay, changes thumb colors, and
         * changes the text formatting back to normal.</p>
        **/
		private function hdlRollOut(e:MouseEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// idle & over stroke colors are !=
			if (idleKnobStroke != overKnobStroke) {
				
				// redraw the stroke
				var g:Graphics = knob_sprite.graphics;
					g.clear();
					g.lineStyle(1, idleKnobStroke);
					g.beginFill(knob_fill);
					g.drawRect(knob_rect.x, knob_rect.y, knob_rect.width, knob_rect.height);
					g.endFill();
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
         * Handler function for scroll click.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>Dispatches a custom event to the mediator.</p>
        **/
		private function hdlClick(e:MouseEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//trace ("[:_:] ScrollBarUI.hdlClick("+e.target+") [:_:]");
			
			// the clicked sprite
			switch (e.target) {
				
				// scroll track clicked
				case track_sprite:
					
					// tween knob to mouse pos
					Tweener.addTween(knob_sprite, {
						y:this.mouseY, 
						time:0.5, 
						transition:"easeoutsine", 
						
						onUpdate:function():void {
							contentTo_pos = getTweenToPos(knob_sprite.y);
							content_sprite.y = contentTo_pos;
						}
					});
					
					break;
			}
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		
		/**
         * Handler function for mouse down on knob.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p></p>
        **/
		private function hdlMouse_Down(e:MouseEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// start dragging the knob
			knob_sprite.startDrag(false, new Rectangle(0, 0, 0, track_sprite.height-8));
			stage.addEventListener(MouseEvent.MOUSE_UP, hdlMouse_Up);
			
			// add an enter frame listener
			this.addEventListener(Event.ENTER_FRAME, hdlEnterFrame);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
         * Handler function for enter frame.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>.</p>
        **/
		private function hdlEnterFrame(e:Event=null):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// update the position
			contentTo_pos = getTweenToPos(knob_sprite.y);
			tweenContent();
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯'
		
		
		/**
         * Handler function for mouse up from knob.
         * ~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
         * <p>.</p>
        **/
		private function hdlMouse_Up(e:MouseEvent):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			// stop dragging
			stage.removeEventListener(MouseEvent.MOUSE_UP, hdlMouse_Up);
			knob_sprite.stopDrag();
			
			// kill enter frame listener
			this.removeEventListener(Event.ENTER_FRAME, hdlEnterFrame);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}