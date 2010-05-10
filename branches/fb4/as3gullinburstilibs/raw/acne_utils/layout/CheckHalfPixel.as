package utils.layout {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Svante
	 */
	public class CheckHalfPixel {
		public static function check(a_target:DisplayObject):void {
			var xHalf : Boolean = a_target.x != int(a_target.x);
			var yHalf : Boolean = a_target.y != int(a_target.y);
			if ( xHalf || yHalf ) {
//				trace(a_target,xHalf?("x:"+a_target.x):"",yHalf?("y:"+a_target.y):"");
			}
			
			if ( !(a_target is DisplayObjectContainer) ) return;
			
			var i : int;
			var container : DisplayObjectContainer = a_target as DisplayObjectContainer;
			for ( i; i < container.numChildren; i++) {
				check(container.getChildAt(i));
			}
			
		}
	}
}
