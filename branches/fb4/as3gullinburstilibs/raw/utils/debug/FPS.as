package utils.debug { 
	/** */
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	/** */
	public class FPS extends MovieClip { 
		/**
		 * VARIABLES
		 */
		private var counter:uint; 
		private var counterDisplay:TextField;
		private var theTimer:Timer;
		/**
		 * CONSTRUCTOR
		 */
		public function FPS() { 
			counter = 0; 
			counterDisplay = new TextField(); 
			counterDisplay.background = true;
			counterDisplay.border = true;
			counterDisplay.selectable = false;
			counterDisplay.autoSize =  TextFieldAutoSize.LEFT;
			/** */			
			addChild(counterDisplay);
			addEventListener(Event.ENTER_FRAME, onEnterFrameEvent); 
			/** */			
			theTimer = new Timer(1000, 0); 
			theTimer.addEventListener(TimerEvent.TIMER, onTimerEvent); 
			theTimer.start(); 
		} 
		/**
		 * EVENT HANDLERS
		 * @param event				<Event>
		 */		
		private function onEnterFrameEvent(event:Event):void { 
			counter++; 
		} 
		/**
		 * @param event				<TimerEvent>
		 */	
		private function onTimerEvent(event:TimerEvent):void { 
			counterDisplay.text = "FPS : " + counter.toFixed(1); 
			counterDisplay.autoSize =  TextFieldAutoSize.LEFT;
			counter = 0; 
		}
		/**
		 * 
		 */
		public function destroy():void {
			theTimer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			theTimer.stop();
			removeEventListener(Event.ENTER_FRAME, onEnterFrameEvent); 
		}
	} 
} 
