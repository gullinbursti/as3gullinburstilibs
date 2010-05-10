package utils.keyboard {
	import com.dummyproject.SiteProxy;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	/**
	 * @author Svante
	 */
	public class BindKey {
		private static var m_upbindings		: Dictionary;
		private static var m_downbindings	: Dictionary;
		
		public static  function enable():void {
			m_downbindings = new Dictionary();
			m_upbindings = new Dictionary();
			
			var s : Stage = SiteProxy.configuration.stage;
			
			s.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			s.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		public static function disable():void {
			m_upbindings = null;
			m_downbindings = null;
			var s : Stage = SiteProxy.configuration.stage;
			
			s.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			s.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		public static function addBinding(a_key:int,a_function:Function,a_params:Array=null,a_keyup:Boolean = false) : void {
			if ( a_keyup ) {
				
				m_upbindings[a_key] = {f:a_function,p:a_params};
				
			} else {
				
				m_downbindings[a_key] = {f:a_function,p:a_params};
				
			}
		}

		private static function keyDownHandler(event : KeyboardEvent) : void {
			var obj : Object = m_downbindings[event.charCode];
			if ( obj ) {
				var f : Function = obj.f;
				var p : Array = obj.p;
				f.apply(null,p);
			}
		}

		private static function keyUpHandler(event : KeyboardEvent) : void {
			var obj : Object = m_upbindings[event.charCode];
			if ( obj ) {
				var f : Function = obj.f;
				var p : Array = obj.p;
				f.apply(null,p);
			}
		}
	}
}
