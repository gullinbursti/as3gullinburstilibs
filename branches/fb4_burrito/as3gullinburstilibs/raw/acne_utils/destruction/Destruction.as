package utils.destruction {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;

	/**
	* @author nikkoh
	*/
	public class Destruction {
		/**
		 *  Destroy an object. E.g. Destruction.destroy(container, Event.ENTER_FRAME, onEveryFrame, Event.RESIZE, onStageResize);
		 * @param	object	The object to destroy.
		 * @param	...args	Event listeners to remove. Pass pairs of Strings and Functions.
		 */
		public static function destroy(object:Object, ...args):void {
			/**
			 *  Don't do anything if there's no object.
			 */	
			if (object) {
				/**
				 *  Arrays are iterated until they're empty.
				 */
				if(object is Array) {
					while((object as Array).length) destroy((object as Array).pop(), args); 
				} else {
					/**
					 * Remove tweens.
					 */
					try { TweenLite.killTweensOf(object); }
					catch(error1:Error) { trace("Destruction: Error caught while removing tweens. object = " + object + "\n" + error1.getStackTrace()); }
					
					/**
					 *  Remove listeners.
					 */
					try {
						if (object is IEventDispatcher) {
							/**
							 *  If Array doesn't contain pairs, remove the last item.
							 */
							if (args.length % 2 != 0) args.pop();
							var len:int = args.length;
							/**
							 *  Remove listeners.
							 */
							for (var i:int = 0; i < len; i += 2) {
								IEventDispatcher(object).removeEventListener(args[i] as String, args[i + 1] as Function);
							}
						}
					} catch (error2:Error) { trace("Destruction: Error caught while removing listeners. object = " + object + "\n" + error2.getStackTrace()); }
					/**
					 *  Run destroy method & remove from stage.
					 */
					try {
						if (object.hasOwnProperty("destroy") && object.destroy is Function) object.destroy();
						if (object is DisplayObject) {
							if(object.parent) DisplayObjectContainer(object.parent).removeChild(DisplayObject(object));
							DisplayObject(object).filters = [];
							DisplayObject(object).mask = null;
							if (object is MovieClip) MovieClip(object).stop();
						} else if(object is Timer) Timer(object).reset();
					} catch (error3:Error) { trace("Destruction: Error caught while destroying and removing from stage. object = " + object + "\n" + error3.getStackTrace()); }
					/**
					 *  Bitmap destruction.
					 */
					try {
						if(object is Bitmap) {
							if(Bitmap(object).bitmapData) Bitmap(object).bitmapData.dispose();
						} else if(object is BitmapData) BitmapData(object).dispose();
					} catch(error4:Error) { trace("Destruction: Error caught while destroying bitmap. object = " + object + "\n" + error4.getStackTrace()); }
				}
			}
		}
		/**
		 * 
		 */
		public static function destroyItemsInArray(array:Array, ...args):void {
			for (var i:int = 0; i < array.length; i++){
				destroy(array[i], args);
			}
		}
		/**
		 * 
		 */
		public static function destroyTimelineMovieClip(target:MovieClip):void {
			
			var i : uint;
			target.gotoAndStop(1);
			for ( i  = 0; i < target.totalFrames; i++) {
				target.nextFrame();
				while ( target.numChildren ) {
					var child : DisplayObject = target.getChildAt(0);
					destroy(child);
					
				}
			}
			
			
		}
	}
}