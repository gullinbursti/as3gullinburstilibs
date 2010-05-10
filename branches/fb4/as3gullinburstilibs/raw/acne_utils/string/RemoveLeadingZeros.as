package utils.string {
	/**
	* @author nikkoh
	*/
	public class RemoveLeadingZeros {
		
		public static function converToInt(str:String):int {
			while (str.substring(0, 1) == "0" && str.length > 1) {
				str = str.substring(1);
			}
			return int(str);
		}
		
	}
}
