package utils.string {

	/**
	 * @author nikkoh
	 */
	public class NumberFormat {
		
		/**
		 *  Formats a Number to a String with desired delimiter between thousands,
		 *  specific number of decimals, and a custom decimal sign.
		 */
		public static function format(number:Number, thousandsDelimiter:String = ",", decimals:int = 0, decimalSign:String = "."):String {
			
			var integer:int = Math.floor(number);
			var strDecimals:String = decimals ? (number-integer).toFixed(decimals).substr(1).split(".").join(decimalSign) : "";
			var strInteger:String = integer.toString();
			var len:int = strInteger.length;
			var strReturn:String = "";
			for(var i:int=0; i<len; i++) { strReturn = (strInteger.charAt(len-1-i) + (i&&i%3==0?thousandsDelimiter:"")).concat(strReturn); }
			strReturn += strDecimals;
			return strReturn;
			
		}
		public static function addLeadingZero(n:Number):String
		{
			var out:String = String(n);
			
			if(n < 10 && n > -1)
			{
				out = "0" + out;
			}
			
			return out;
		}
	}
}
