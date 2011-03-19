package com.company.utils {
	
	import flash.utils.getTimer;
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	public class TimeSlicer {
		
		private static const FRAME_DURATION:Number = 1000 / Application.application.frameRate;
		private var currentIndex:uint = 0;
		
		/**
		 * Execute a function on each data item in a collection, in a Flash Player friendly way.
		 *
		 * Typical use:
		 * new TimeSlicer().execute(myData, myMethod, myCallBackMethod);
		 *
		 * @param data      The data being processed
		 * @param f         The method to process the data
		 * @param callBack  The method called when processing is over
		 */
		public function execute(data:ArrayCollection, f:Function, callBack:Function):void {
			
			var isExecutionTooLong:Boolean = false;
			var startTime:uint = getTimer();
			
			while(!isExecutionTooLong && currentIndex < data.length) {
				
				// Execute processing on the current data item
				f(data.getItemAt(currentIndex));
				
				// Check if the execution is too long, i.e, if it exceeds half the frame duration at the current framerate
				isExecutionTooLong = (getTimer() - startTime) > (FRAME_DURATION / 2);
				
				currentIndex++;
			}
			
			// If the processing is over, call the callBack method. Otherwise, call this method again at the next frame
			
			if(currentIndex == data.length)
				callBack(); // Release "Thread"
			else
				Application.application.callLater(execute, [data, f, callBack]); // Yield, i.e release CPU cycles until the next frame
		}
	}
}

