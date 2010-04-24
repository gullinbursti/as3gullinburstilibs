package utils.debug { 
	/** */
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	/** */
	public class MemoryUsage extends MovieClip { 
		/**
		 * VARIABLES
		 */
		private var memDisplay:TextField;
		private var theTimer:Timer;
		/**
		 * CONSTRUCTOR
		 */
		public function MemoryUsage() { 
			memDisplay = new TextField(); 
			memDisplay.background = true;
			memDisplay.border = true;
			memDisplay.selectable = false;
			memDisplay.autoSize =  TextFieldAutoSize.LEFT;
			/** */
			addChild(memDisplay); 
			/** */
			theTimer = new Timer(1000, 0); 
			theTimer.addEventListener(TimerEvent.TIMER, onTimerEvent); 
			theTimer.start(); 
		} 
		/**
		 * EVENT HANDLERS
		 * @param TimerEvent				<Event>
		 */			
		private function onTimerEvent(event:TimerEvent):void { 
			var m:Number = (System.totalMemory / 1024) / 1024;
			var ms:String = m.toFixed(3);
			memDisplay.text = "Memory usage : " + ms + " Mb"; 
			memDisplay.autoSize =  TextFieldAutoSize.LEFT;
		}
		/**
		 * 
		 */
		public function destroy():void {
			theTimer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			theTimer.stop();
		}
	} 
} 
