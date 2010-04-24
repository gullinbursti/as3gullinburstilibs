package utils.string {
	/**
	* @author nikkoh
	*/
	public class FileExtension {
		/**
		 * 
		 */
		public static function getFileExtension(file:String):String {
			var pos:Number = file.lastIndexOf(".");
			var extension:String = file.substring(pos);
			return extension;
		}
	}	
}
