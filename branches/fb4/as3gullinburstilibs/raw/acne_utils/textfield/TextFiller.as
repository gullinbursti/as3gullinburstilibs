package utils.textfield {
	/** */
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	* @author nikkoh
	*/
	public class TextFiller {
		/**
		 * 
		 */
		public static function byFieldSize(field:TextField, prop:String, maxValue:Number, additional:String = "..."):Number {
			
			if (!field[prop]) {
				return -1;
			}
			
			if (field[prop] <= maxValue) {
				return field[prop];
			}
			
			if (!field.autoSize || field.autoSize == TextFieldAutoSize.NONE) {
				field.autoSize = TextFieldAutoSize.LEFT;
			}
			
			var str:String = field.htmlText;
			
			var endIndex:int = str.length;
			
			field.htmlText = str + additional;
			
			while (field[prop] > maxValue) {
				field.htmlText = str.substr(0, endIndex) + additional;
				endIndex--;
			}
			
			return field[prop];
		}
	}
}
