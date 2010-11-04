package utils.date {
	import flash.errors.IOError;
	import flash.errors.IllegalOperationError;
	/**
	* @author nikkoh
	*/
	public class DateToString {
		/**
		 * CONSTANTS
		 */
		public static const YEAR_FULL:String = 					"yearFull";
		public static const YEAR:String = 						"year";
		
		public static const MONTH_NUM:String = 					"monthNum";
		public static const MONTH_NUM_LEADING_ZERO:String = 	"monthNumLeadingZero";
		public static const MONTH_NAME:String = 				"monthName";
		
		public static const DAY_NUM:String = 					"dayNum";
		public static const DAY_NUM_LEADING_ZERO:String = 		"dayNumLeadingZero";
		public static const DAY_NAME:String = 					"dayName";
		public static const DAY_DATE:String = 					"dayDate";
		public static const DAY_DATE_LEADING_ZERO:String = 		"dayDateLeadingZero";
		
		public static const HOURS_24:String = 					"hours24";
		public static const HOURS_24_LEADING_ZERO:String = 		"hours24LeadingZero";
		public static const HOURS_12:String = 					"hours12";
		public static const HOURS_12_LEADING_ZERO:String = 		"hours12LeadingZero";
		
		public static const AMPM:String = 						"AMPM";
		
		public static const MINUTES:String = 					"minutes";
		public static const MINUTES_LEADING_ZERO:String = 		"minutesLeadingZero";
		
		public static const SECONDS:String = 					"seconds";
		public static const SECONDS_LEADING_ZERO:String = 		"secondsLeadingZero";
		/**
		 * VARIABLES
		 */
		private var _monthNames:Array = 
		[
			"January", 
			"February", 
			"March", 
			"April", 
			"May", 
			"June", 
			"July", 
			"August", 
			"September", 
			"October", 
			"November", 
			"December"
		];
		
		private var _dayNames:Array = 
		[
			"Monday", 
			"Tuesday", 
			"Wednesday", 
			"Thursday", 
			"Friday", 
			"Saturday",
			"Sunday"
		];
		
		private var constantFunctionBindings:Object;
		
		private var _am:String = "AM";
		private var _pm:String = "PM";
		
		private var _formats:Array;
		/**
		 * GETTERS AND SETTERS
		 */
		public function set monthNames(names:Array):void {
			try {
				if (names.length == 12) {
					_monthNames = names;
				} else {
					throw new IOError("DateToString.monthNames -  the array must contain 12 items/months.");
				}
			} catch (error:IOError) {
				throw error;
			}
			
		}
		public function get monthNames():Array {
			return _monthNames;
		}
		public function set dayNames(names:Array):void {
			try {
				if (names.length == 7) {
					_dayNames = names;
				} else {
					throw new IOError("DateToString.dayNames - the array must contain 7 items/days.");
				}
			} catch (error:IOError) {
				throw error;
			}
		}
		public function get dayNames():Array {
			return _dayNames;
		}
		public function set AM(str:String):void {
			_am = str;
		}
		public function set PM(str:String):void {
			_pm = str;
		}
		/**
		 * CONSTRUCTOR
		 */
		public function DateToString() {
			initialize();
		}
		
		//--------------------------------------------------------------------------
	    //
	    //  Public functions
	    //
	    //--------------------------------------------------------------------------
	    
		public function addFormat(type:String, beginChar:String = "", endChar:String = ""):void {
			if (!_formats) {
				_formats = new Array();
			}
			_formats.push({type:type, b:beginChar, e:endChar});
		}
		/**
		 * 
		 */
		public function resetFormats():void {
			_formats = null;
		}
		/**
		 * 
		 */
		public function convert(date:Date):String {
			if (!_formats) {
				return date.toString();	
			}
			
			var str:String = "";
			var len:int = _formats.length;
			var r:String;
			var type:String;
			
			for (var i:int = 0; i < len; i++) {
				type = _formats[i].type;
				
				if (constantFunctionBindings[type]) {
					r = constantFunctionBindings[type](date);
				} else {
					r = "";
					throw new IllegalOperationError("WARNING: DateToString.convert() - constantFunctionBindings[\"" + type + "\"] not found.");
				}
				
				str += _formats[i].b + r + _formats[i].e;
			}
			
			return str;
		}
		
		//--------------------------------------------------------------------------
	    //
	    //  Private functions
	    //
	    //--------------------------------------------------------------------------
	    
	    private function initialize():void {
	    	constantFunctionBindings = {
				yearFull:getFullYear,
				year:getYear,
				
				monthNum:getMonthNum,
				monthNumLeadingZero:getMonthNumLeadingZero,
				monthName:getMonthName,
				
				dayNum:getDayNum,
				dayNumLeadingZero:getDayNumLeadingZero,
				dayName:getDayName,
				dayDate:getDayDate,
				dayDateLeadingZero:getDayDateLeadingZero,
				
				hours24:getHours24,
				hours24LeadingZero:getHours24LeadingZero,
				hours12:getHours12,
				hours12LeadingZero:getHours12LeadingZero,
				
				AMPM:getAMPM,
				
				minutes:getMinutes,
				minutesLeadingZero:getMinutesLeadingZero,
				
				seconds:getSeconds,
				secondsLeadingZero:getSecondsLeadingZero
			};
	    }
	    
	    //----------------------------------
	    //  Year functions
	    //----------------------------------
		
		private function getFullYear(date:Date):String {
			return date.getFullYear().toString();
		}
		/**
		 * 
		 */
		private function getYear(date:Date):String {
			return date.getFullYear().toString().substr(-2);
		}
		
		//----------------------------------
	    //  Month functions
	    //----------------------------------

		private function getMonthNum(date:Date):String {
			return (date.getMonth() + 1).toString();
		}
		/**
		 * 
		 */
		private function getMonthNumLeadingZero(date:Date):String {
			var mn:String = getMonthNum(date);
			if (mn.length < 2) {
				mn = "0" + mn;
			}
			return mn;
		}
		/**
		 * 
		 */
		private function getMonthName(date:Date):String {
			return _monthNames[date.getMonth()];
		}
		
		//----------------------------------
	    //  Day functions
	    //----------------------------------
		
		private function getDayNum(date:Date):String {
			return date.getDay().toString();
		}
		/**
		 * 
		 */
		private function getDayNumLeadingZero(date:Date):String {
			var dn:String = getDayNum(date);
			if (dn.length < 2) {
				dn = "0" + dn;
			}
			return dn;
		}
		/**
		 * 
		 */
		private function getDayName(date:Date):String {
			return _dayNames[date.getDay() - 1];
		}
		/**
		 * 
		 */
		private function getDayDate(date:Date):String {
			return date.getDate().toString();
		}
		/**
		 * 
		 */
		private function getDayDateLeadingZero(date:Date):String {
			var dn:String = getDayDate(date);
			if (dn.length < 2) {
				dn = "0" + dn;
			}
			return dn;
		}
		
		//----------------------------------
	    //  Hours functions
	    //----------------------------------
	    
	    private function getHours24(date:Date):String {
			return date.getHours().toString();
		}
		/**
		 * 
		 */
		 private function getHours24LeadingZero(date:Date):String {
			var hn:String = getHours24(date);
			if (hn.length < 2) {
				hn = "0" + hn;
			}
			return hn;
		}
		/**
		 * 
		 */
		 private function getHours12(date:Date):String {
		 	var h12:int = date.getHours() % 12;
			if (h12 == 0) {
				h12 = 12;
			}
			return h12.toString();
		}
		/**
		 * 
		 */
		 private function getHours12LeadingZero(date:Date):String {
			var hn:String = getHours12(date);
			if (hn.length < 2) {
				hn = "0" + hn;
			}
			return hn;
		}
		/**
		 * 
		 */
		private function getAMPM(date:Date):String {
			var h:int = date.getHours();
			if (h < 12 || h == 24) {
				return _am;
			}
			return _pm; 
		}
		
		
		//----------------------------------
	    //  Minutes functions
	    //----------------------------------
	    
	    private function getMinutes(date:Date):String {
			return date.getMinutes().toString();
		}
		/**
		 * 
		 */
		 private function getMinutesLeadingZero(date:Date):String {
			var mn:String = getMinutes(date);
			if (mn.length < 2) {
				mn = "0" + mn;
			}
			return mn;
		}
		
		//----------------------------------
	    //  Seconds functions
	    //----------------------------------
	    
	    private function getSeconds(date:Date):String {
			return date.getSeconds().toString();
		}
		/**
		 * 
		 */
		 private function getSecondsLeadingZero(date:Date):String {
			var sn:String = getSeconds(date);
			if (sn.length < 2) {
				sn = "0" + sn;
			}
			return sn;
		}
	}
}
