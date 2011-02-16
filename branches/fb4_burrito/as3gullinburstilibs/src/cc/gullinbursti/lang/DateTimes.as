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

package cc.gullinbursti.lang {
	
	import cc.gullinbursti.math.BasicMath;
	
	import flash.geom.Point;
	
	
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class DateTimes {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		private static const MONTH_NAMES:Array = new Array(
			["January", "Jan"],
			["February", "Feb"], 
			["March", "Mar"], 
			["April", "Apr"], 
			["May", "May"], 
			["June", "Jun"], 
			["July", "Jul"], 
			["August", "Aug"], 
			["September", "Sep"], 
			["October", "Oct"], 
			["November", "Nov"], 
			["December", "Dec"] 
		);
		
		
		private static const HEBREW_MONTHS:Array = new Array(
			"Nisan",
			"Iyyar", 
			"Sivan", 
			"Tammuz", 
			"Av", 
			"Elul", 
			"Tishri", 
			"Heshvan", 
			"Kislev", 
			"Teveth", 
			"Shevat", 
			"Adar", 
			"Veadar"
		);
		
		
		private static const ISLAM_MONTHS:Array = new Array(
			"Muharram",
			"Safar", 
			"Rabi`al-Awwal", 
			"Rabi`ath-Thani", 
			"Jumada l-Ula", 
			"Jumada t-Tania", 
			"Rajab", 
			"Sha`ban", 
			"Ramadan", 
			"Shawwal", 
			"Dhu l-Qa`da", 
			"Dhu l-Hijja"
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
		
		
		private static const YEARS:String = "YEARS";
		private static const MONTHS:String = "MONTHS";
		private static const DAYS:String = "DAYS";
		private static const HOURS:String = "HOURS";
		private static const MINUTES:String = "MINUTES";
		private static const SECONDS:String = "SECONDS";
		private static const MILLISECS:String = "MILLISECS";
		private static const TIMEZONE:String = "TIMEZONE";
		
		
		
		// ISO 
		private static const ATOM_RFC3339:String 	= "Y-m-d\TH:i:sP"; 		// [2005-08-15T15:52:01+00:00]
		private static const ATOM_W3C:String 		= "Y-m-d\TH:i:s"; 		// [2005-08-15T15:52:01Z]
		private static const COOKIE:String 			= "l, d-M-y H:i:s T"; 	// [Monday, 15-Aug-05 15:52:01 UTC]
		private static const ISO8601:String 		= "Y-m-d\TH:i:sO"; 		// [2005-08-15T15:52:01+0000]
		private static const RFC822:String 			= "D, d M y H:i:s O"; 	// [Mon, 15 Aug 05 15:52:01 +0000]
		private static const RFC850:String 			= "l, d-M-y H:i:s T"; 	// [Monday, 15-Aug-05 15:52:01 UTC]
		private static const RFC1036:String 		= "D, d M y H:i:s O"; 	// [Mon, 15 Aug 05 15:52:01 +0000]
		private static const RFC1123:String 		= "D, d M Y H:i:s O"; 	// [Mon, 15 Aug 2005 15:52:01 +0000]
		private static const RFC2822:String 		= "D, d M Y H:i:s O"; 	// [Mon, 15 Aug 2005 15:52:01 +0000]
		private static const RSS10:String 			= "Y-m-d\TH:i:sP"; 		// [2005-08-15T15:52:01+00:00]
		private static const RSS20:String 			= "D, d M Y H:i:s O"; 	// [Mon, 15 Aug 2005 15:52:01 +0000]
		
		
		// swatch time
		private static const BEATS_YEAR:int = 365000;
		private static const BEATS_WEEK:int = 7000;
		private static const BEATS_DAY:int = 1000;
		private static const BEATS_HOUR:Number = 41 + (2 / 3);
		private static const BEATS_MINUTE:Number = 0.694444444444444;
		private static const BEATS_SECOND:Number = 0.011574074074074;
		private static const BEATS_MILLISEC:Number = 0.000011574074074074;
		
		
		private static const MOD_JULIAN_DAY:Number = 2400000.5;
		private static const HEBREW_EPOCH:Number = 347995.5;
		private static const ISLAM_EPOCH:int = 1948085;
		private static const ISLAM_DAY_MONTHS:Number = 10631 / 30;
		
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
		public function DateTimes() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		
		/**
		 * Changes a local <code>Date</code> object into UTC 
		 * @param date
		 * @return 
		 * 
		 */		
		public static function asUTC(date:Date=null):Date {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// current date
			if (!date)
				date = new Date();
			
			// define new date in UTC
			return (new Date(date.toUTCString()));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		
		/**
		 * Calculates the time elapsed from Unix Epoch to the <code>Date</code> object.
		 * @param date The <code>Date</code> object to get time from.
		 * @param isMilli Boolean flag for millisecond precision.
		 * @return The time in integer seconds w/ or w/out millisecond decimal precision.
		 * 
		 */		
		public static function asUnixEpoch(date:Date=null, isMilli:Boolean=false):Number {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// use the current datetime
			if (!date)
				date = new Date();
			
			
			// value in millisecs
			var epoch_ms:int = date.getTime();
			
			
			// millisecs as decimal
			if (isMilli)
				return (epoch_ms * 0.001);
			
			
			// as integer seconds
			return (Numbers.dropDecimal(epoch_ms * 0.001));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns the Julian day from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return Number
		 */
		public static function asJulianDay(date:Date=null, isModified:Boolean=false):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * interval of time in days and fractions of a day since January 1, 4713 BC UTC @ Noon
			 **/
			
			if (!date)
				date = new Date();
				
			var year:int = date.getFullYear();
			var month:int = date.getMonth() + 1;
			var day:int = date.getDate(); 
			
			if (month < 3) {
				month += 12;
				year--;
			}
			
			var jul_date:Number = ((365.25 * (year + 4716) << 0) + (30.6001 * (month + 1) << 0) + day + 2 - ((year * 0.01) << 0) + ((((year * 0.01) << 0) * 0.25) << 0) - 1524) - 0.5;
			var jul_day:Number = jul_date + ((date.getHours() + (date.getMinutes() + (date.getSeconds() + (date.getMilliseconds() * 0.001)) / 60) / 60) / 24); 
			
			if (isModified)
				return (jul_day - MOD_JULIAN_DAY); // 55606.871608796064	
			
			return (jul_day); // 2455607.871608796
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function asJulianCalendar(date:Date=null):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (julianToDate(asJulianDay(date), false));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Formats a <code>Date</code> object to an ATOM date (YYYY-MM-DDTHH:MM:SSZ) 
		 * @param date
		 * @return 
		 * 
		 */		
		public static function asAtom(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			return (date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate() + "T"+date.getUTCHours() + ":" + date.getUTCMinutes() + ":" + date.getUTCSeconds() + "Z");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts a <code>Date</code> object to an ISO-8601
		 * formatted <code>String</code>
		 * 
		 * @param date
		 * @return String
		 */
		public static function asISO8601(date:Date=null):String { // (YYYY-MM-DD HH:MM:SS +TZ)
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			var month_str:String = Ints.formatDblDigit(date.getMonth() + 1);
			var day_str:String = Ints.formatDblDigit(date.getDate());
			
			var tz_hrs:String = Ints.formatDblDigit((date.getTimezoneOffset() / 60) << 0);
			var tz_mins:String = Ints.formatDblDigit(date.getTimezoneOffset() - (int(tz_hrs) * 60) << 0);
			var tz_sign:String = "+";
			
			if (date.getTimezoneOffset() > 0)
				tz_sign = "-";
			
			return (date.getFullYear() + "-" + month_str + "-" + day_str + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + tz_sign + tz_hrs + tz_mins);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the time zone abreviation (ISO 8601) from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return String
		 */
		public static function asISO8601Timezone(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			var offset:Number = Math.round(12 + -(date.getTimezoneOffset() / 60));
			
			if (isDST(date))
				offset--;
			
			return (TIME_ZONES[offset][0]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns a UTC date ready for a MySQL db (YYYY-MM-DD HH:HH:SS.MMMM)
		 * @param date
		 * @return String
		 * 
		 */		
		public static function asMySQL(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			var delim_str:String = "-";
			
			var mysql_str:String = date.fullYearUTC.toString() + delim_str;
				mysql_str += Ints.formatDblDigit(date.monthUTC + 1) + delim_str;
				mysql_str += Ints.formatDblDigit(date.dateUTC);
				mysql_str += " ";
				
			delim_str = ":";
			mysql_str += Ints.formatDblDigit(date.hoursUTC) + delim_str;
			mysql_str += Ints.formatDblDigit(date.minutesUTC) + delim_str;
			mysql_str += Ints.formatDblDigit(date.secondsUTC);
			mysql_str += "." + date.millisecondsUTC;
			
			
			return (mysql_str);			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns the beats of the swatch internet time from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function asSwatchInternetTime(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (!date)
				date = new Date();
			
			// get passed seconds for the day
			var secs_tot:int = (date.getUTCHours() * 3600) + (date.getUTCMinutes() * 60) + (date.getUTCSeconds()) + 3600; // caused of the BMT Meridian
			
			// 1day = 1000 .beat ... 1 second = 0.01157 .beat 		
			return ("@" + Math.round(secs_tot * 0.01157));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function asHebrewDate(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (!date)
				date = new Date();
			
			
			return (date.toString());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function asIslamDate(date:Date=null, isKuwaiti:Boolean=true):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			/**
			 * Common (non-leap) years have 354 days. Leap years have 355 days.
			 * Odd-numbered months of the year have 30 days. Even-numbered months have 29 days. Exception: the 12th month of a leap year has 30 days.
			 * Eleven of every thirty years are leap years. The leap years are the years which are congruent modulo 30 to any of these numbers: 2, 5, 7, 10, 13, 15, 18, 21, 24, 26, 29. Thus, a 30-year cycle always lasts exactly (354×30)+11 = 10631 days.
			 * Correlation with Gregorian calendar: the 1st of January 2000 (a Saturday) corresponds to the 25th of Ramadan 1420. (Ramadan is the ninth month of the Islamic lunar year.)
			 * 
			 * [http://www.phys.uu.nl/~vgent/islam/islam_tabcal_main.htm]
			 **/
			
			
			if (!date)
				date = new Date();
			
			
			var leap_mult:Number = 8.01 / 60;
			var j_ghost:Number = asJulianDay(date) - ISLAM_EPOCH;
			var m_ghost:int = (j_ghost / 10631);
			var y_ghost:int;
			
			j_ghost -= (10631 * m_ghost);
			y_ghost = ((j_ghost - leap_mult) / ISLAM_DAY_MONTHS) << 0;			
			j_ghost -= ((y_ghost * ISLAM_DAY_MONTHS) + leap_mult) << 0;
			
			var year:int = (30 * m_ghost) + y_ghost;
			var month:int = Math.min(12, ((j_ghost + 28.5001) / 29.5) << 0);
			var day:int = j_ghost - Math.floor(29.5001 * month - 29);
			
			var date_str:String = day.toString() + " " + ISLAM_MONTHS[month - 1];
			
			return (date_str + " @ " + Ints.formatDblDigit(date.getHours()) + ":" + Ints.formatDblDigit(date.getMinutes()) + ":" + Ints.formatDblDigit(date.getSeconds()) + ":" + date.getMilliseconds().toString() + " " + year.toString());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns a long date <code>String</code> representation from a <code>Date</code> object.
		 * “Tuesday, February 15, 2001”
		 * 
		 * @param date
		 * @return String
		 */
		public static function asLongDate(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			return (DateTimes.dayOfWeek(date) + ", " + DateTimes.monthName(date) + " " + date.getDate() + ", " + date.getFullYear());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns a short date <code>String</code> representation from a <code>Date</code> object.
		 * “7/10/1981”
		 * 
		 * @param date
		 * @return 
		 */
		public static function asShortDate(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			return ((date.getMonth() + 1) + "/" + date.getDate() + "/"+date.getFullYear());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Converts an ATOM formatted <code>String</code> to a <code>Date</code> object.
		 * [Y-m-d\TH:i:sP] = [2005-08-15T15:52:01+00:00] // [Y-m-d\TH:i:s] = [2005-08-15T15:52:01Z]
		 * 
		 * @param date_str
		 * @return Date
		 */
		public static function atomToDate(atomDate_str:String=null):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (!atomDate_str)
				atomDate_str = "0000-00-00T00:00:00Z";
			
			var date_str:String = String(atomDate_str.split("T")[0]);
			var time_str:String = String(atomDate_str.split("T")[1]);
			
			var year:int = int(date_str.split("-")[0]);
			var month:int = int(date_str.split("-")[1]) - 1;
			var day:int = int(date_str.split("-")[2]);
			
			var hour:int = int(time_str.split(":")[0]);
			var minute:int = int(time_str.split(":")[1]);
			var second:int = int(String(time_str.split(":")[2]).substr(0, 2));
			
			var tz_mult:int = -int(time_str.charAt(8) + "1");
			var tz_hrs:int = -int(String(time_str.split(":")[2]).substr(3, 2)) * int(time_str.charAt(8) + "1");
			var tz_mins:int = -int(time_str.split(":")[3]) * int(time_str.charAt(8) + "1");
			
			
			// last character denotes utc
			if (date_str.charAt(atomDate_str.length - 1) == "Z")
				return (new Date(Date.UTC(year, month, day, hour, minute, second)));
			
			
			return (new Date(Date.UTC(year, month, day, hour + tz_hrs, minute + tz_mins, second)));
				
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Converts an ISO-8601 formated string (YYYY-MM-DDTHH:MM:SS-0800) to a <code>Date</code> object. 
		 * 
		 * @param date_str
		 * @return Date
		 */
		
		// "Y-m-d\TH:i:sO" [2005-08-15T15:52:01+0000]
		public static function iso8601ToDate(isoDate_str:String=null):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!isoDate_str)
				isoDate_str = "0000-00-00T00:00:00";
			
			var date_str:String = String(isoDate_str.split("T")[0]);
			var time_str:String = String(isoDate_str.split("T")[1]);
			
			var year:int = date_str.split("-")[0];
			var month:int = date_str.split("-")[1] - 1;
			var day:int = date_str.split("-")[2];
			
			var hour:int = time_str.split(":")[0];
			var min:int = time_str.split(":")[1];
			var sec:int = int(String(time_str.split(":")[2]).substr(0, 2));
			
			var tz_hrs:int = -int(isoDate_str.substr(20, 2)) * int(isoDate_str.charAt(19) + "1");
			
			
			return (new Date(Date.UTC(year, month, day, hour + tz_hrs, min + -int(isoDate_str.substr(22)), sec)));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns a date parsed from a MySQL db (YYYY-MM-DD HH:MM:SS.MMMM)
		 * @param date_str
		 * @return Date
		 * 
		 */		
		public static function mysqlToDate(date_str:String=null):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date_str)
				date_str = "0000-00-00 00:00:00";
			
			var patt_regx:RegExp = /[: -]/g;
			date_str = date_str.replace(patt_regx, ',');
			
			var date_arr:Array = date_str.split(',');
			
			return (new Date(date_arr[0], date_arr[1] - 1, date_arr[2], date_arr[3], date_arr[4], date_arr[5], date_str.split(".")[1]));			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function swatchTimeToDate(beats:String="@0", isSwatchTZ:Boolean=true):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var curr_date:Date = new Date();
			var remain:Number = Number(beats.substr(1));
			
			var years:int = (remain / BEATS_YEAR) << 0;
			remain -= (years * BEATS_YEAR) << 0;
			
			var weeks:int = (remain / BEATS_WEEK) << 0;
			remain -= (weeks * BEATS_WEEK) << 0;
			
			var days:int = (remain / BEATS_DAY) << 0;
			remain -= (days * BEATS_DAY);
			
			var hours:int = (remain / BEATS_HOUR) << 0;
			remain -= (hours * BEATS_HOUR);
			
			var mins:int = (remain / BEATS_MINUTE) << 0;
			remain -= (mins * BEATS_MINUTE);
			
			var secs:int = (remain / BEATS_SECOND) << 0;
			remain -= (secs * BEATS_SECOND);
			
			var ms:int = (remain / BEATS_MILLISEC) << 0;
			
			
			if (isSwatchTZ)
				return (new Date(Date.UTC(curr_date.getFullYear() + years, curr_date.getMonth(), curr_date.getDate() + days, hours + int(isDST()) - 1, mins, secs, ms)));
			
				
			return (new Date(curr_date.getFullYear() + years, curr_date.getMonth(), curr_date.getDate() + days, hours + int(isDST()) - 1, mins, secs, ms));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Converts a UNIX timestamp to a <code>DateM</code> object.
		 * @param epoch_time
		 * @return 
		 */
		public static function unixEpochToDate(epoch_time:Number=0, isMilli:Boolean=false, isLocal:Boolean=false):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (isLocal)
				epoch_time += new Date().getTimezoneOffset() * 60;
			
			if (isMilli)
				return (new Date(epoch_time));
			
			return (new Date(epoch_time * 1000));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Converts a Julian date to a <code>Date</code> Object. 
		 * @param date
		 * @return 
		 * 
		 */		
		public static function julianToDate(date:Number=int.MAX_VALUE, isGregorian:Boolean=true):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (date == int.MAX_VALUE)
				date = asJulianDay();
			
			
			// date attribs
			var year:int;
			var month:int;
			var day:int;
			var hour:int;
			var min:int;
			var sec:int;
			var msec:int;
			
			date += 0.5;
			
			// julian day & time
			var j_day:int = date << 0;
			var j_time:Number = Numbers.decimalPlace(date);
			
			// ghost vals
			var j_ghost:int;
			var d_ghost:int;
			var y_ghost:int = ((j_day - 1867216.25) / 36524.25) << 0;
			
			// later than 12pm, 15-OCT-1582, calc leap yrs
			if (isGregorian && j_day >= 2299161)
				j_day += 1 + y_ghost - ((y_ghost * 0.25) << 0);
			
			
			
			// calc date
			j_ghost = j_day + 1524;
			year = ((j_ghost - 122.1) / 365.25) << 0;
			d_ghost = (year * 365.25) << 0;
			month = ((j_ghost - d_ghost) / 30.6001) << 0;
			day = j_ghost - d_ghost - ((30.6001 * month) << 0) + j_time;
			
			// change decimal day into seconds
			j_time *= (24 * 60 * 60);
			
			// time attribs
			hour = (j_time / 3600) << 0;
			j_time -= (hour * 3600);
			min = (j_time / 60) << 0;
			j_time -= (min * 60);
			sec = j_time + 0.0001;
			msec = Numbers.decimalPlace(sec) * 1000;
			
			// month offset
			if (month < 14)
				month--;
			else
				month -= 13;
			
			// year offset
			if (month > 2)
				year -= 4716;
			else
				year -= 4715;
			
			
			
			return (new Date(year << 0, month - 1, day, hour, min, sec, msec));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hebrewToDate(year:int, month_str:String, day:int, time:String="00:00:00.000"):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			var time_arr:Array = time.split(":");
			var hour:int = int(time_arr[0]);
			var min:int = int(time_arr[1]);
			var sec:int = Numbers.dropDecimal(int(time_arr[2]));
			var msec:int = Numbers.decimalPlace(int(time_arr[2]) * 1000) << 0;
			
			
			var y_date:int = 0;
			var m_date:int = 0;
			var d_date:int = 0;
			
			return (new Date(y_date, m_date, d_date, hour, min, sec, msec));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function islamToDate(year:int, month_str:String, day:int, time:String="00:00:00.000"):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			var time_arr:Array = time.split(":");
			var hour:int = int(time_arr[0]);
			var min:int = int(time_arr[1]);
			var sec:int = Numbers.dropDecimal(int(time_arr[2]));
			var msec:int = Numbers.decimalPlace(int(time_arr[2]) * 1000) << 0;
			
			
			var y_date:int = 0;
			var m_date:int = 0;
			var d_date:int = 0;
			
			return (new Date(y_date, m_date, d_date, hour, min, sec, msec));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the day of the year from a <code>Date</code> object, 
		 * starting with 0 (0-365).
		 * 
		 * @param date
		 * return int
		 */		
		public function dayOfYear(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
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
		public function weekOfYear(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
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
		 * Returns the name of the month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @param isAbbreviated Boolean
		 * @return String
		 */
		public static function monthName(date:Date=null, isAbbreviated:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			return (MONTH_NAMES[date.getMonth()][int(isAbbreviated)]);	
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the 1st day of a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function monthFirstDay(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			return (date.getDay());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the last day of a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function monthLastDay(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			// date for the last day of the month
			var end_date:Date = new Date(date.getFullYear(), date.getMonth(), daysInMonth(date));
			
			return (end_date.getDay());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns days in a month from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @return int
		 */
		public static function daysInMonth(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			return (new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the weekday's name from a <code>Date</code> object.
		 * 
		 * @param date Date
		 * @param isAbbreviated Boolean
		 * @return String
		 */
		public static function dayOfWeek(date:Date=null, isAbbreviated:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			return (WEEK_DAYS[date.getDay()][int(isAbbreviated)]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns the hours in a <code>Date</code> object as a value between 1 & 12. 
		 * @param date
		 * @return 
		 * 
		 */		
		public static function shortHour(date:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			// get the 24 hour amount
			var hour:int = date.getHours();
			
			// is midnight
			if (hour == 0)
				return (12);
			
			// 1pm or later
			else if (hour > 12)
				return (hour - 12);
			
			
			// am
			return (hour);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function easterDate(year:int=-1):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (year == -1)
				year = new Date().getFullYear();
			
			var a:int = year % 19;
			var b:int = year % 4;
			var c:int = year % 7;
			var k:int = (year / 100) << 0;
			var p:int = ((13 + 8 * k) / 25) << 0;
			var q:int = (k / 4) << 0;
			var M:int = (15 - p + k - q) % 30;
			var N:int = (4 + k - q) % 7;
			var d:int = ((19 * a) + M) % 30;
			var e:int = ((2 * b) + (4 * c) + (6 * d) + N) % 7;
			
			//trace ("a:["+a+"] b:["+b+"] c:["+c+"] k:["+k+"] p:["+p+"] q:["+q+"] M:["+M+"] N:["+N+"] :["+d+"] :["+e+"]");
			
			if (d == 29 && e == 6)
				return (new Date(year, 3, 19));
			
			if (d == 28 && e== 6 && ((11 * M) + 11) % 30 < 19)
				return (new Date(year, 3, 18));
			
			
			return (new Date(year, 2, 22 + d + e));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Returns true if the <code>Date</code> object is a leap year.
		 * 
		 * @param date Date
		 * @return Boolean
		 */
		public static function isLeapYear(date:Date=null):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			if ((date.getFullYear() % 4 == 0) && ((date.getFullYear() % 100 != 0) || (date.getFullYear() % 400 == 0)))
				return (true);
				
			else
				return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns true if the <code>Date</code> object is under Daylight Savings Time.
		 * 
		 * @param date Date
		 * @return Boolean
		 */
		public static function isDST(date:Date=null):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
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
		
		
		
		public static function dstStart(year:int=-1):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (year == -1)
				year = new Date().getFullYear();
			
			var date:Date = new Date(year, 0, 1);
			var offset_pt:Point = new Point(date.getTimezoneOffset(), date.getTimezoneOffset());
			
			for (var i:int=0; i<12; i++) {
				for (var j:int=1; j<daysInMonth(date); j++) {
					date.setMonth(i, j);
					offset_pt.x = date.getTimezoneOffset();
					
					if (offset_pt.x != offset_pt.y && offset_pt.x < offset_pt.y)
						return (date);
											
					offset_pt.y = date.getTimezoneOffset();
				}
			}
			
			return (new Date(year));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function dstEnd(year:int=-1):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._	
			
			if (year == -1)
				year = new Date().getFullYear();
			
			var date:Date = new Date(year, 0, 1);
			var offset_pt:Point = new Point(date.getTimezoneOffset(), date.getTimezoneOffset());
			
			for (var i:int=dstStart(year).getMonth()+1; i<12; i++) {
				for (var j:int=1; j<=daysInMonth(date); j++) {
					date.setMonth(i, j);
					offset_pt.x = date.getTimezoneOffset();
					
					if (offset_pt.x != offset_pt.y && offset_pt.x > offset_pt.y)
						return (date);
					
					offset_pt.y = date.getTimezoneOffset();
				}
			}
			
			return (new Date(year));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns true if date is AM (ante meridiem)
		 * 
		 * @param Date
		 * @return Boolean
		 */
		public static function isAM(date:Date=null):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
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
		public static function isWeekday(date:Date=null):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
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
		public static function isWeekend(date:Date=null):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			return (!isWeekday(date));			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns the time in a phrase <i>two years, one month, zero days, 
		 * three hours, zero minutes, and five seconds.</i>
		 * 
		 * @param date <code>Date</date> obj (1900 = zero years) 
		 * @return String 
		 */
		public static function timestampAsCountdown(date:Date=null):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date)
				date = new Date();
			
			
			var phrase_str:String = toPhraseSegment(date.fullYear - 1900, YEARS);
				phrase_str += ", " + toPhraseSegment(date.month, MONTHS);
				phrase_str += ", " + toPhraseSegment(date.date, DAYS);
				phrase_str += ", " + toPhraseSegment(date.hours, HOURS);
				phrase_str += ", " + toPhraseSegment(date.minutes, MINUTES);
				phrase_str += ", and " + toPhraseSegment(date.seconds, SECONDS);
			
			return (phrase_str + ".");
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		/**
		 * Returns the part of time as a phrase <i>three minutes</i> 
		 * @param val the number to use
		 * @param seg part of time
		 * @param nums use digits
		 * @return A worded phrase
		 * 
		 */		
		private static function toPhraseSegment(val:int, seg:String, nums:Boolean=false):String {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// phrased msg
			var phrase_str:String = "";
			
			// use digits
			if (nums) 
				phrase_str = val.toString();
			
			// use words
			else
				phrase_str = Numbers.toPhrase(val);
			
			
			// add part name
			phrase_str += " " + seg.substring(0, seg.length - 1).toLowerCase();
			
			
			// add an 's'
			if (val != 1)
				phrase_str = Strings.pluralize(phrase_str);
			
			
			return (phrase_str);			
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
		public static function compare(date1:Date, date2:Date=null):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date2)
				date2 = new Date();
			
			// 1st date is after the 2nd
			if (DateTimes.difference(date1, date2) > 0)
				return (-1);
			
			// 1st date is before 2nd
			else if (DateTimes.difference(date1, date2) < 0)
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
		public static function difference(date1:Date, date2:Date=null, isSigned:Boolean=true):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			if (!date2)
				date2 = new Date();
			
			// actual date matters
			if (isSigned)
				return (date2.valueOf() - date1.valueOf());
				
			else
				return (Math.abs(date2.valueOf() - date1.valueOf()));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Calculates the time elapsed between two <code>Date</code> objects. 
		 * @param start_date
		 * @param end_date
		 * @param isSigned
		 * @return 
		 * 
		 */		
		public static function elapsedSince(start_date:Date, end_date:Date=null, isSigned:Boolean=true):Date {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// use current date
			if (!end_date)
				end_date = new Date();
			
			
			// difference in ms
			var diff:Number = difference(start_date, end_date, isSigned);
			
			return (new Date(diff));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		private static function monthIndex(name_str:String):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			for (var i:int=0; i<MONTH_NAMES.length; i++) {
				if ((MONTH_NAMES[i][0] as String).toUpperCase() == name_str.toUpperCase() || (MONTH_NAMES[i][1] as String).toLocaleUpperCase() == name_str.toUpperCase())
					return (i);
			}
			
			return (-1);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
	}
}