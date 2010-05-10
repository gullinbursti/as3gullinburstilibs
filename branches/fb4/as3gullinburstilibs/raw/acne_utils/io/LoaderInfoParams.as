package utils.io {
	import flash.display.DisplayObject;
	/**
	 * @author nikkoh
	 */
	public class LoaderInfoParams {
		/**
		 * @param root				<DisplayObject>
		 */
		public static function getClickTag(root:DisplayObject):String{
			for (var key:String in root.loaderInfo.parameters){
				if(key.toLowerCase() == "clicktag") return root.loaderInfo.parameters[key];
			}
			return "";
		}
		/**
		 * @param root				<DisplayObject>
		 */
		public static function getStreambase(root:DisplayObject):String{
			for (var key:String in root.loaderInfo.parameters){
				if(key.toLowerCase() == "streambase") return root.loaderInfo.parameters[key];
			}
			return "";
		}
		
		// USAGE 
		
		// navigateToURL(new URLRequest(LoaderInfoParams.getClickTag(root)), "_blank");
		
		// nameofnetstream.play(LoaderInfoParams.getStreambase(root) + "nameofflv.flv");
		
	}
}
