package utils.string {
	/**
	 * @author nikkoh
	 */
	public class ValidateEmail {
		
		private static const EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
		
		/**
		 *  Validates a simple email address.
		 */
		public static function validateEmail(email:String):Boolean {
			
			return Boolean(email.match(EMAIL_REGEX));
			
		}
		/**
		 *  Validates a list of several email addresses. Strips white characters.
		 */
		public static function validateEmailList(emailList:String, separator:String = ","):Boolean {
			
            var arrEmail:Array = emailList.split(separator);
            for each(var email:String in arrEmail){
                if(!validateEmail(email.replace(/\s/, ""))) return false;
            }
            return true;
			
        }
	}
}
