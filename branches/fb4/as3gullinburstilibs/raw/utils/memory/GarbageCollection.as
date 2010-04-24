package utils.memory {
	/** */
	import flash.net.LocalConnection;
	/**
	 * @author nikkoh
	 */
	public class GarbageCollection {
		/**
		 * 
		 */		
		public static function force():void{
			try {
			    new LocalConnection().connect('foo');
			    new LocalConnection().connect('foo');
			} catch (error:Error) {	}
		}
	}
}
