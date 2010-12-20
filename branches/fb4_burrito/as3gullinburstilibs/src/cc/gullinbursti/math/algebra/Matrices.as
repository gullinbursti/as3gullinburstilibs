package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import flash.geom.Matrix;
	import flash.geom.Point;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Matrices extends BasicAlgebra {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some matrix operations
		
		public function Matrices() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		// http://en.wikipedia.org/wiki/Dual_number
		public static function dualNumber(val:int):Matrix {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//TODO: implement the matrix dual # operation
			
			return (new  Matrix());
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function genIdenty(dim:Point):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var col_arr:Array;
			var ident_arr:Array = new Array();
			
			for (var j:int=0; j<dim.y; j++) {
				col_arr = new Array();
				
				for (var i:int=0; i<dim.x; i++)
					col_arr.push(int(i == j));
				
				ident_arr.push(col_arr);
			}
			
			
			return (ident_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function invert(mtx:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			return (multiply(mtx, genIdenty(new Point((mtx[0] as Array).length, mtx.length))));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function adjoint(mtx:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * + - +
			 * - + -
			 * + - +
			 */
			
			
			return (mtx);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		public static function multiply(mtx1_arr:Array, mtx2_arr:Array):Array {
			//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var i:int;
			var j:int;
			var q:int;
			var r:int;
			
			var prod_arr:Array = new Array();
			
			var rows:int = mtx1_arr.length;
			var cols:int = (mtx2_arr[0] as Array).length;
			
			
			if ((mtx1_arr[i] as Array).length != mtx2_arr.length)
				return (prod_arr);
			
			
			// prime
			for (i=0; i<rows; i++) {
				
				var col_arr:Array = new Array();
				for (j=0; j<cols; j++)
					col_arr.push(0);
				
				prod_arr.push(col_arr);
			}
			
			
			// loop thru each col in matrix 2
			for (i=0; i<rows; i++) {
				
				// loop thru each row in matrix 1
				for (j=0; j<cols; j++) {
					
					
					var val:Number = 0;
					
					// loop thru each col in matrix 1
					for (q=0; q<(mtx1_arr[i] as Array).length; q++)	
						val += mtx1_arr[i][q] * mtx2_arr[q][j];
					
					prod_arr[i][j] = val;
				}
			}
			
			
			return (prod_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}