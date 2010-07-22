package cc.gullinbursti.math.discrete {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.utils.Arrays;
	
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 // <[!] class delaration [¡]>
	public class Fibonacci extends BasicMath {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		/**
		 * 
		 */
		// <*] class constructor [*>	
		public function Fibonacci() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function seqGenerator(max:int, min:int=0):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// find the prev two fib #'s from the smaller val 
			var last2:Point = Fibonacci.last2InSeq(min);
			 
			// sequence of fibonacci #'s
			var seq_arr:Array = new Array();
				seq_arr.push(last2.x, last2.y);   //seq_arr.push(seed0, seed1);
			
			// loop while the last fib # is <= the max
			while (last <= max) {
				
				// pull last & 2nd to last from array
				var prev:int = seq_arr[seq_arr.length-2];
				var last:int = seq_arr[seq_arr.length-1];
				
				// add them & append
				seq_arr.push(prev + last);	
			}
			
			return (seq_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function isValidFibo(val:int):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// get the two before the val
			var last2:Point = Fibonacci.last2InSeq(val);
			
			// if the sum of 2 prevs = the val
			if (last2.x + last2.y == val)
				return (true);
			
			else
				return (false);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function isRatio(nom:int, denom:int, isSeq:Boolean=true):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// fraction arrays
			var nom_arr:Array = new Array();
			var denom_arr:Array = new Array();
			
			// pts holding prev two fib #'s
			var nom_last2:Point = Fibonacci.last2InSeq(nom);
			var denom_last2:Point = Fibonacci.last2InSeq(denom);
			
			// populate the arrays
			nom_arr.push([nom, nom_last2.x, nom_last2.y]);
			denom_arr.push([denom, denom_last2.x, denom_last2.y]);
			
			// point holding validity flags
			var bool_pt:Point = new Point();
				bool_pt.x = int(Fibonacci.isValidFibo(nom));
				bool_pt.y = int(Fibonacci.isValidFibo(denom));
			
			// both or one (x, y) is false
			if (bool_pt.x + bool_pt.y != 2)
				return (false);
			
			// both flags are true, not checking for sequence
			else if (bool_pt.x + bool_pt.y == 2 && !isSeq)
				return (true);
				
			
			// nominator is larger…
			if (Math.max(nom, denom) == nom) {
				
				// the denomimator is the 1st prev
				if (nom_last2.y == denom)
					return (true);
			}
				
			// denominator is larger…
			else if (Math.max(nom, denom) == denom) {
				
				// the nomimator is the 1st prev
				if (denom_last2.y == nom)
					return (true)
			}
			
			
			// both vals aren't fib #'s
			return (false);
			
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function nextLowest(val:int):int {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 * 		   φⁿ - (1 - φ)ⁿ
			 * F(n) = ————————————————
			 * 			    √5
			 * 
			 *  n = next lowest
			 *  φ ≈ 1.6.180339887
			 * √5 ≈ 2.236797749979
			 * 
			 */
			
			// nominator broken up into 2 pts
			var nom1:Number = Math.pow(BasicMath.GOLDEN_RATIO, val);
			var nom2:Number = Math.pow((1 - BasicMath.GOLDEN_RATIO), 15);
			
			// approx fib #
			var approx_val:Number = (nom1 - nom2) / Fibonacci.sqRoot5();
			
			// round it off & return
			return (Math.round(approx_val));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		private static function last2InSeq(val:int):Point {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// seeds to start the formula
			var seed0:int;
			var seed1:int;
			
			// starting at zero, hard seed
			if (val == 0) {
				seed0 = 0;
				seed1 = 1;
			
			// find the next two lowest fib #'s
			} else {
				seed1 = Fibonacci.nextLowest(val);
				seed0 = Fibonacci.nextLowest(seed1);
			}
			
			// swap if seed0 > seed1
			if (seed0 > seed1)
				Arrays.swap([seed0, seed1], seed0, seed1);
			
			
			// return last two as a pt
			return (new Point(seed0, seed1));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Performs the square root of 5 for Fibonacci formulas.
		 * 
		 * @return √5
		 */
		private static function sqRoot5():Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			return (BasicMath.root(5));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}