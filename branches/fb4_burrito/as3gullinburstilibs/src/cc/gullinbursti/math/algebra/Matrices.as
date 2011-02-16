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
			
			var ident_arr:Array = new Array();
			
			for (var j:int=0; j<dim.y; j++) {
				
				for (var i:int=0; i<dim.x; i++)
					ident_arr.push(int(i == j));
			}
			
			
			return (ident_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Constructs an <code>Array</code> representation of a matrix, all filled w/ zeroes. 
		 * @param dim The w/h of the matrix.
		 * @return A list w × h elements consisting of zero values.
		 * 
		 */		
		public static function genZeroMatrix(dim:Point):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * ⎡0 0 0⎤
			 * ⎢0 0 0⎢
			 * ⎣0 0 0⎦
			 **/ 
			
			// array rep of the matrix
			var ident_arr:Array = new Array();
			
			// loop thru rows x cols, and push zero into each element
			for (var i:int=0; i<dim.x * dim.y; i++)
				ident_arr.push(0);
			
			// send it back
			return (ident_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Constructs a the additive identity (zero) matrix represented by an <code>Array</code>.
		 * @param dim The w/h of the matrix.
		 * @return A list w × h elements as the identity.
		 * 
		 */		
		public static function additiveIdent(dim:Point):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * Additive identity of a matrix states:
			 * 
			 *  ⎡1 2 1⎤   ⎡0 0 0⎤   ⎡0 0 0⎤
			 *  ⎢1 1 4⎢ + ⎢0 0 0⎢ = ⎢0 0 0⎢
			 *  ⎣2 0 3⎦   ⎣0 0 0⎦   ⎣0 0 0⎦
			 * 

			 **/
			
			// use the zero matrix generator
			return (genZeroMatrix(dim));
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		/**
		 * Generates the identity matrix represented as an <code>Array</code> for a given dimension. 
		 * @param mtx The matrix as 1-dim list to create identity for.
		 * @return A list of 
		 * 
		 */		
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
		
		
		
		public static function add(mtx1:Array, mtx2:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var sum_arr:Array = new Array();
			
			for(var i:int=0; i<mtx1.length; i++)
				sum_arr.push(mtx1[i] + mtx2[i]);
			
			
			return (sum_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
			
		public static function multiplyFactor(mtx_arr:Array, factor:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var prod_arr:Array = new Array();
			
			for (var i:int=0; i<mtx_arr.length; i++) {
				var itm:Number = mtx_arr[i];
				
				if (itm == 0)
					prod_arr.push(0);
				
				else
					prod_arr.push(factor * itm);
			}
			
			return (prod_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function concat(dim:Point, mtx1:Array, mtx2:Array):Array {
			
			var concat_arr:Array = new Array();
			
			var col:int = 0;
			var row:int = 0;
			
			for (var i:int=0; i<(dim.x*dim.y); i++) {
				col = i % dim.x;
				row = i / dim.x;
				
				concat_arr.push((mtx1[row*dim.x] * mtx2[col]) + (mtx1[(row*dim.x)+1] * mtx2[dim.x+col]) + (mtx1[(row*dim.x)+2] * mtx2[(dim.x*2)+col]));
			}
			
			
			/*
			concat_arr[0] = (mtx1[0] * mtx2[0]) + (mtx1[1] * mtx2[5]) + (mtx1[2] * mtx2[10]);
			concat_arr[1] = (mtx1[0] * mtx2[1]) + (mtx1[1] * mtx2[6]) + (mtx1[2] * mtx2[11]);
			concat_arr[2] = (mtx1[0] * mtx2[2]) + (mtx1[1] * mtx2[7]) + (mtx1[2] * mtx2[12]);
			concat_arr[3] = (mtx1[0] * mtx2[3]) + (mtx1[1] * mtx2[8]) + (mtx1[2] * mtx2[13]);
			concat_arr[4] = (mtx1[0] * mtx2[4]) + (mtx1[1] * mtx2[9]) + (mtx1[2] * mtx2[14]);
				
			concat_arr[5] = (mtx1[5] * mtx2[0]) + (mtx1[6] * mtx2[5]) + (mtx1[7] * mtx2[10]);
			concat_arr[6] = (mtx1[5] * mtx2[1]) + (mtx1[6] * mtx2[6]) + (mtx1[7] * mtx2[11]);
			concat_arr[7] = (mtx1[5] * mtx2[2]) + (mtx1[6] * mtx2[7]) + (mtx1[7] * mtx2[12]);
			concat_arr[8] = (mtx1[5] * mtx2[3]) + (mtx1[6] * mtx2[8]) + (mtx1[7] * mtx2[13]);
			concat_arr[9] = (mtx1[5] * mtx2[4]) + (mtx1[6] * mtx2[9]) + (mtx1[7] * mtx2[14]);
				
			concat_arr[10] = (mtx1[10] * mtx2[0]) + (mtx1[11] * mtx2[5]) + (mtx1[12] * mtx2[10]);
			concat_arr[11] = (mtx1[10] * mtx2[1]) + (mtx1[11] * mtx2[6]) + (mtx1[12] * mtx2[11]);
			concat_arr[12] = (mtx1[10] * mtx2[2]) + (mtx1[11] * mtx2[7]) + (mtx1[12] * mtx2[12]);
			concat_arr[13] = (mtx1[10] * mtx2[3]) + (mtx1[11] * mtx2[8]) + (mtx1[12] * mtx2[13]);
			concat_arr[14] = (mtx1[10] * mtx2[4]) + (mtx1[11] * mtx2[9]) + (mtx1[12] * mtx2[14]);
				
			concat_arr[15] = (mtx1[15] * mtx2[0]) + (mtx1[16] * mtx2[5]) + (mtx1[17] * mtx2[10]);
			concat_arr[16] = (mtx1[15] * mtx2[1]) + (mtx1[16] * mtx2[6]) + (mtx1[17] * mtx2[11]);
			concat_arr[17] = (mtx1[15] * mtx2[2]) + (mtx1[16] * mtx2[7]) + (mtx1[17] * mtx2[12]);
			concat_arr[18] = (mtx1[15] * mtx2[3]) + (mtx1[16] * mtx2[8]) + (mtx1[17] * mtx2[13]);
			concat_arr[19] = (mtx1[15] * mtx2[4]) + (mtx1[16] * mtx2[9]) + (mtx1[17] * mtx2[14]);
			*/
			
			return (concat_arr);
			
		}
	}
}