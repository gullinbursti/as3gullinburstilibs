/**
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~._
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._ 
 *
 * Class	:	DateTime.as		
 * Version	: 	1.2
 * 
 * Author	:	Matt Holcombe (gullinbursti)
 * Created	:	11-24-09
 * 
 * Purpose	:	Performs operations concerning calendar dates & times.
 * 
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
 * ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~·¯
**/


/*
Licensed under the MIT License
Copyright (c) 2009 Matt Holcombe (matt@gullinbursti.cc)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://code.gullinbursti.cc/
http://en.wikipedia.org/wiki/MIT_license/

[]~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~:~~[].
*/

package cc.gullinbursti.utils {
	import cc.gullinbursti.math.BasicMath;
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class DateTime {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static const MONTH_NAMES:Array = new Array(
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
		);
		
		// weekdays: name // abrev // 1=Mon / 7=Sun
		private static const WEEK_DAYS:Array = new Array(
			["Sunday", 		"Sun",	7],
			["Monday", 		"Mon",	1],
			["Tuesday", 	"Tue",	2],
			["Wednesday",	"Wed",	3],
			["Thursday", 	"Thu",	4],
			["Friday", 		"Fri",	5],
			["Saturday", 	"Sat",	6]
		);
		
		// name abbreviation & UTC offset
		private static const TIME_ZONES:Array = new Array(
			["IDLW",	-12], 
			["NT", 		-11], 
			["HST", 	-10], 
			["AKST", 	 -9], 
			["PST", 	 -8], 
			["MST", 	 -7],
			["CST", 	 -6],
			["EST", 	 -5],
			["AST", 	 -4],
			["ADT", 	 -3],
			["AT", 		 -2],
			["WAT", 	 -1],
			["GMT", 	  0], // aka UT, UTC, Z
			["CET", 	  1],
			["EET", 	  2],
			["MSK", 	  3],
			["ZP4", 	  4],
			["ZP5", 	  5],
			["ZP6", 	  6],
			["WAST", 	  7],
			["WST", 	  8],
			["JST", 	  9],
			["AEST", 	 10],
			["AEDT", 	 11],
			["NZST", 	 12]
		);

		
		// ISO 
		private static const ATOM:String 	= "Y-m-d\TH:i:sP"; // [2005-08-15T15:52:01+00:00]
		private static const COOKIE:String 	= "l, d-M-y H:i:s T"; // [Monday, 15-Aug-05 15:52:01 UTC]
		private static const ISO8601:String = "Y-m-d\TH:i:sO"; // [2005-08-15T15:52:01+0000]
		private static const RFC822:String 	= "D, d M y H:i:s O"; // [Mon, 15 Aug 05 15:52:01 +0000]
		private static const RFC850:String 	= "l, d-M-y H:i:s T"; // [Monday, 15-Aug-05 15:52:01 UTC]
		private static const RFC1036:String = "D, d M y H:i:s O"; // [Mon, 15 Aug 05 15:52:01 +0000]
		private static const RFC1123:String = "D, d M Y H:i:s O"; // [Mon, 15 Aug 2005 15:52:01 +0000]
		private static const RFC2822:String = "D, d M Y H:i:s O"; // [Mon, 15 Aug 2005 15:52:01 +0000]
		private static const RFC3339:String = "Y-m-d\TH:i:sP"; // [2005-08-15T15:52:01+00:00) (ATOM]
		private static const RSS:String 	= "D, d M Y H:i:s O"; // [Mon, 15 Aug 2005 15:52:01 +0000]
		private static const W3C:String 	= "Y-m-d\TH:i:sP"; // [2005-08-15T15:52:01+00:00]
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
/**
 * 
 * <listing>
 * 	<strong>Day</strong>
 * 		d	Day of the month, 2 digits w/ leading zero [01 - 31]
 * 		D	A textual representation of the day, three letters [Mon - Sun]
 * 		j	Day of the month w/o leading zeros [1 - 31]
 * 		l	A full textual representation of the day of the week [Sunday - Monday]
 * 		N	ISO-8601 numeric representation of the day of the week [Monday(1) - Sunday(7)]
 * 		S	English ordinal suffix for the day of the month, [2 chars st / nd / rd / th] w/ j
 * 		w	Numeric representation of the day of the week [Sunday(0) - Saturday(6)]
 * 		z	The day of the year start w/ 0 [0 - 365]
 * 	
 * 	<strong>Week</strong>
 * 		W	ISO-8601 week number of year, weeks starting on Monday [1 - 52]
 * 	
 * 	<strong>Month</strong>
 * 		F	A full textual representation of a month, such as [January - December]
 * 		m	Numeric representation of a month, w/ leading zeros [01 - 12]
 * 		M	A short textual representation of a month, three letters [Jan - Dec]
 * 		n	Numeric representation of a month, w/o leading zeros [1 - 12]
 * 		t	Number of days in the given month [28 - 31]
 * 	
 * 	<strong>Year</strong>
 * 		L	Whether it's a leap year (boolean) [0 / 1]
 * 		Y	A full numeric representation of a year, 4 digits [1000 / 2010]
 * 		y	A two digit representation of a year [99 / 03]
 * 	
 * 	<strong>Time</strong>
 * 		a	Lowercase Ante meridiem & Post meridiem [am / pm]
 * 		A	Uppercase Ante meridiem & Post meridiem [AM / PM]
 * 		B	Swatch Internet time [000 - 999]
 * 		g	12-hour format of an hour w/o leading zeros [1 - 12]
 * 		G	24-hour format of an hour w/o leading zeros [0 - 23]
 * 		h	12-hour format of an hour w/ leading zeros [01 - 12]
 * 		H	24-hour format of an hour w/ leading zeros [00 - 23]
 * 		i	Minutes w/ leading zeros [00 - 59]
 * 		s	Seconds, w/ leading zeros [00 - 59]
 * 		u	Milliseconds
 * 	
 * 	<strong>Time zone</strong>
 * 		e	Time zone identifier [UTC / GMT / Azores]
 * 		I	Whether or not is daylight saving time [0 / 1]
 * 		O	Difference to GMT in hours [+0000 - +2300]
 * 		P	Difference to GMT w/ colon between hours & minutes +00:00 - +23:00]
 * 		T	Time zone abbreviation [EST / MST / PST]
 * 		Z	Time zone offset in seconds. West of UTC is (-), East is (+) [-43200 - 50400]
 * 	
 * 	<strong>Full Date/Time</strong>
 * 		c	ISO 8601 date [2004-02-12T15:19:21+00:00]
 * 		r	RFC 2822 formatted date [Thu, 21 Dec 2000 16:01:07 +0200]
 * 		U	Seconds since the Unix Epoch (01 Jan 1970 00:00:00 GMT)
 * </listing>
 */


		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function DateTime() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		/**
		 * 
		 * @param epoch_time
		 * @return 
		 */
		public static function unixToDate(epoch_time:int):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (new Date(epoch_time * 1000));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates the secs elapsed from Unix Epoch to the <code>Date</code> object 
		 * 
		 * @param date
		 * @return int
		 */
		public static function epochDate(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (Numbers.dropDecimal(date.getTime() / 1000));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts an ISO-8601 formated string to a <code>Date</code> object. 
		 * 
		 * @param date_str
		 * @return Date
		 */
		 
		// "Y-m-d\TH:i:sO" [2005-08-15T15:52:01+0000]
		public static function iso8601ToDate(date_str:String):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			var year:int = String(date_str.split(" ")[0]).split("-")[0];
			var month:int = String(date_str.split(" ")[0]).split("-")[1];
			var day:int = String(date_str.split(" ")[0]).split("-")[2];
			
			var hour:int = String(date_str.split(" ")[1]).split(":")[0];
			var min:int = String(date_str.split(" ")[1]).split(":")[1];
			var sec:int = String(date_str.split(" ")[1]).split(":")[2];
			
			
			return (new Date(year, month, day, hour, min, sec));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts a <code>Date</code> object to an ISO-8601
		 * formatted <code>String</code>
		 * 
		 * @param date
		 * @return String
		 */
		public static function dateToISO8601(date:Date):String { // (YYYY-MM-DD HH:MM:SS +TZ)
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			return (date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+" ");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts an ATOM formatted <code>String</code> to a <code>Date</code> object.
		 * [Y-m-d\TH:i:sP] = [2005-08-15T15:52:01+00:00]
		 * 
		 * @param date_str
		 * @return Date
		 */
		public static function atomToDate(date_str:String):Date { // 
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			var year:String = String(date_str.split("T")[0]).split("-")[0];
			var month:String = String(date_str.split("T")[0]).split("-")[1];
			var day:String = String(date_str.split("T")[0]).split("-")[2];
			
			var time:String = date_str.split("T")[1];
			var hour:String = time.split(":")[0];
			var minute:String = time.split(":")[1];
			var second:String = String(time.split(":")[2]).substr(0, 2);
			
			return (new Date(year, month, day, hour, minute, second));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		//"Y-m-d\TH:i:sP"; // [2005-08-15T15:52:01+00:00]
		
		
		
		/**
		 * Returns a long date <code>String</code> representation from a <code>Date</code> object.
		 * “Tuesday, February 15, 2001”
		 * 
		 * @param date
		 * @return String
		 */
		public static function longDate(date:Date):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (DateTime.dayOfWeek(date)+", "+DateTime.monthName(date)+" "+date.getDate()+", "+date.getFullYear());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns a short date <code>String</code> representation from a <code>Date</code> object.
		 * “7/10/1981”
		 * 
		 * @param date
		 * @return 
		 */
		public static function shortDate(date:Date):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return ((date.getMonth()+1)+"/"+date.getDate()+"/"+date.getFullYear());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the name of the month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @param isAbbreviated Boolean
		 * @return String
		 */
		public static function monthName(date:Date, isAbbreviated:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (MONTH_NAMES[date.getMonth()]);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the weekday's name from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @param isAbbreviated Boolean
		 * @return String
		 */
		public static function dayOfWeek(date:Date, isAbbreviated:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (WEEK_DAYS[date.getDay()][int(isAbbreviated)]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the time zone abreviation (ISO 8601) from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return String
		 */
		public static function iso8601TZ(date:Date):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var offset:Number = Math.round(11 + -(date.getTimezoneOffset() / 60));
			
			if (isDST(date))
				offset--;
				
			return (TIME_ZONES[offset][0]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns true if the <code>Date</code> object is a leap year.
		 * 
		 * @param date Date
		 * @return Boolean
		 */
		public static function isLeapYear(date:Date):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			if ((date.getFullYear() % 4 == 0) && ((date.getFullYear() % 100 != 0) || (date.getFullYear() % 400 == 0)))
				return (true);
			
			else
				return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the day of the year from a <code>Date</code> object, 
		 * starting with 0 (0-365).
		 * 
		 * @param date
		 * return int
		 */		
		private function dayOfYear(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var firstDayOfYear:Date = new Date(date.getFullYear(), 0, 1);
			var millisecs_offset:Number = date.getTime() - firstDayOfYear.getTime();
			
			return (int(millisecs_offset / 86400000));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the # of the week from a <code>Date</code> object, a week starts
		 * with monday
		 * 
		 * @param date
		 * @return int
		 */
		private function weekOfYear(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// number of passed days
			var dayOfYear:Number = dayOfYear(date);
			
			//jan 1st of the date
			var firstDay:Date = new Date(date.getFullYear(), 0, 1);
			
			// remove days of the 1st & current wk for acurate passed weeks
			var fullWeeks:Number = (dayOfYear - (WEEK_DAYS[date.getDay()][2] + (7 - WEEK_DAYS[firstDay.getDay()][2]))) / 7;  
			

			// if 1st wk of this yr has > 3 for the date
			if (WEEK_DAYS[firstDay.getDay()][2] <= 4)
				fullWeeks++;
			
			//adding the current week
			fullWeeks++;
			
			return (int(fullWeeks));		
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		/**
		 * Returns true if the <code>Date</code> object is under Daylight Savings Time.
		 * 
		 * @param date Date
		 * @return Boolean
		 */
		public static function isDST(date:Date):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var offset_cur:Number = date.getTimezoneOffset();
			var offset_ref:Number;
			
			var month:int = 1;
			
			while (month--) {
				offset_ref = (new Date(date.getFullYear(), month, 1)).getTimezoneOffset();
				
				if (offset_cur != offset_ref && offset_cur < offset_ref)
					return (true);
			}
			
			return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the 1st day of a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function monthStartDay(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (date.getDay());
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the last day of a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function monthLastDay(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// date for the last day of the month
			var end_date:Date = new Date(date.getFullYear(), date.getMonth(), daysInMonth(date))
			
			return (end_date.getDay());
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the Julian day from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return Number
		 */
		public static function julianDay(date:Date):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
			var y:int = date.getFullYear();
			var m:int = date.getMonth() + 1;
			var d:int = date.getDate(); 
			
			if (m < 3) {
				m += 12;
				y--;
			}
				
			return (Math.floor(365.25 * (y + 4716)) + Math.floor(30.6001 * (m + 1)) + d + 2 - Math.floor(y / 100) + Math.floor(Math.floor(y / 100) / 4) - 1524);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns days in a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function daysInMonth(date:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the beats of the swatch internet time from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function getSwatchInternetTime(date:Date):int {
			
			// get passed seconds for the day
			var secs_tot:int = (date.getUTCHours() * 3600) + (date.getUTCMinutes() * 60) + (date.getUTCSeconds()) + 3600; // caused of the BMT Meridian
			
			// 1day = 1000 .beat ... 1 second = 0.01157 .beat 		
			return (Math.round(secs_tot * 0.01157));
		}
		
		
		/**
		 * Returns true if date is AM (ante meridiem)
		 * 
		 * @param Date
		 * @return Boolean
		 */
		public static function isAM(date:Date):Boolean {
			
			if (date.getHours() > 12)
				return (false);
			
			return (true);			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns true if it's Mon-Fri.
		 * 
		 * @param Date
		 * @return Boolean
		 */
		public static function isWeekday(date:Date):Boolean {
			
			// the day of week index
			var day:int = date.getDay();
			
			// boolean test
			return (!(day == 0 || day == 6));			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns true if it's Sat / Sun.
		 * 
		 * @param Date
		 * @return Boolean
		 */
		public static function isWeekend(date:Date):Boolean {
			
			return (!isWeekday(date));			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Compares two <code>Date</code> objects & returns:
		 * d1 > d2 -≫ -1
		 * d1 = d2 -≫  0
		 * d1 < d2 -≫ +1
		 * 
		 * @param date1 Date
		 * @param date2 Date
		 * @return int
		 */
		public static function compare(date1:Date, date2:Date):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// 1st date is after the 2nd
			if (DateTime.dateDiff(date1, date2) > 0)
				return (-1);
			
			// 1st date is before 2nd
			else if (DateTime.dateDiff(date1, date2) < 0)
				return (1);
			
			// same date
			else
				return (0);
			
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns the ms difference between two <code>Date</code> objects. 
		 * 
		 * @param date1 Date
		 * @param date2 Date
		 * @param isSigned Boolean
		 * @return int
		 */
		public static function dateDiff(date1:Date, date2:Date, isSigned:Boolean=true):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// actual date matters
			if (isSigned)
				return (date1.valueOf() - date2.valueOf());
				
			else
				return (Math.abs(date1.valueOf() - date2.valueOf()));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}