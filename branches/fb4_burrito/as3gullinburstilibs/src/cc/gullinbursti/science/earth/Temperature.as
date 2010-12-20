package cc.gullinbursti.science.earth {
	import cc.gullinbursti.converts.Speed;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.geom.BasicGeom;
	import cc.gullinbursti.math.geom.Trig;
	
	import flash.geom.Point;
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Temperature extends BasicWeather {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		// <*] class constructor [*>
		public function Temperature() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function heatIndex(feh:Number, humid:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * heat_index = 
			 * 
			 * -42.379 + (2.04901523 * t) + (10.14333127 * h)
			 * - (0.22475541 * t * h) - (6.83783e-3 * t^2) 
			 * - (5.481717e-2 * h^2) + (1.22874e-3 * t^2 * h) 
			 * + (8.5282e-4 * t * h^2) - (1.99e-6 * t^2 * r^2)
			 * 
			 */
			
			var const_arr:Array = new Array(
				-42.379, 
				2.04901523, 
				10.14333127, 
				0.22475541, 
				BasicMath.e(6.837830, -3), 
				BasicMath.e(5.481717, -2), 
				BasicMath.e(1.228740, -3), 
				BasicMath.e(8.528200, -4), 
				BasicMath.e(1.990000, -3));
			
			var feh_sq:Number = BasicMath.square(feh);
			var humid_sq:Number = BasicMath.square(humid);
			
			return (const_arr[0] + (const_arr[1] * feh) + (const_arr[2] * humid) - (const_arr[3] * feh * humid) - (const_arr[4] * feh_sq) - (const_arr[5] * humid_sq) + (const_arr[6] * feh_sq * humid) + (const_arr[7] * feh * humid_sq) - (const_arr[8] * feh_sq * humid_sq));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function summerSizzleIndex(feh:Number, rh:Number=-1):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	1.98(temp - (0.55 - 0.0055(rh))(temp-58)) - 56.83
			 * 
			 */
			
			if (rh == -1)
				rh = Moisture.realitiveHumidity(feh, 0);
			
			
			return (1.98 * (feh - (0.55 - 0.0055 * rh) * (feh - 58)) - 56.83);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function virtualTemp(celc:Number, vapPress:Number, satVapPress:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	Tv= ((TemperatureC + 273.16) / (1 - 0.378 * (VaporPressure / StationPressure))) - 273.16
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function liftedIndex(celc:Number, vapPress:Number, satVapPress:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	LI= Tc(500mb) - Tp(500mb)
			 * tp - adiabatic
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function verticalTotals(celc:Number, press:Number=850):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	VT= T(850mb) - T(500mb)
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function crossTotals(celc:Number, press:Number=850):Number {
			//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	CT= Tdewpt(850mb) - T(500mb)
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function totalTotals(celc:Number, dewpt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	TT= Tc(850mb) + Tdewc(850mb) - 2*Tc(500mb)
			 * 
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function deepConvectIndex(celc:Number, dewpt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	DCI= T(850 mb) + Td(850 mb) - LI(sfc-500 mb)
			 *  > 30 strong t-storms
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function maxHailSize(max_vel:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * 	mhs = 2 * ((3 * 0.55 * 1.0033 * max_vel2) / (8 * 9.8 * 900)) * 100
			 */
			
			return (2 * ((3 * 0.55 * 1.0033 * BasicMath.square(max_vel)) / (8 * 9.8 * 900)) * 100);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function tqIndex(celc:Number, dewpt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * low-top convection potential
			 * (T850 + Td850 ) - 1.7 (T700)
			 * > 12 storms possible
			 * > 17 low-top storms possible
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function hWindUV(spd:Number, angle:Number):Point {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * spd is mph
			 * angle is degrees
			 */
			
			spd = Speed.mphToKnots(spd);
			
			return (new Point(
				-spd * 0.5148 * Trig.sinDeg(angle),
				-spd * 0.5148 * Trig.cosDeg(angle)
			));
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function airDensity(celc:Number, dewpt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * D= (mb*100)/((Tc+273.16)*287)
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function absHumidity(celc:Number, dewpt:Number):Number {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			/**
			 * Ah= ((6.11*10.0**(7.5*Tdc/(237.7+Tdc)))*100)/((Tc+273.16)*461.5)
			 */
			
			return (0);
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}