package cc.gullinbursti.math.algebra {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.lang.Numbers;
	
	import flash.geom.Matrix;
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Matrices extends BasicAlgebra {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		//TODO: define & implement some matrix operations [http://mathworld.wolfram.com/topics/MatrixTypes.html]
		// orthogonal matrix
		// hat matrix
		// random matrix [http://en.wikipedia.org/wiki/Random_matrix]
		// permutation matrix [http://en.wikipedia.org/wiki/Permutation_matrix]
		// triangular matrix [http://en.wikipedia.org/wiki/Triangular_matrix]
		
		// derterminant [http://planetmath.org/encyclopedia/Determinant2.html]
		// trace [http://planetmath.org/encyclopedia/Trace.html]
		// eigenvalue [http://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors] [http://planetmath.org/encyclopedia/SpectralValue.html]
		// matrix exponential [http://planetmath.org/encyclopedia/MatrixExponential.html]
		
		
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
		
		/*
		public static function cofactors(mtx:Array):Array {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var i:int;
			var j:int;
			var mult:int;
			var size:int = mtx.length;
			var factor_arr:Array = new Array();
			var col_arr:Array = new Array();
			var coeff_arr:Array = new Array();
			var minor_arr:Array = new Array();
			
			for (i=0; i<size; i++)
				factor_arr.push(mtx[i][0]);
			
			
			for (j=1; j<size; j++) {
				col_arr = [];
				
				for (i=1; i<size; i++) {
					col_arr.push(mtx[j][i]);
				}
				
				coeff_arr.push(col_arr);
				minor_arr.push(expMinor(factor_arr[i], cof_arr));
				
			}
			
			for (i=0; i<size; i++) {
				if (i % 2 == 0)
					mult = 1;
				else
					mult = -1;
			}
			
			
			return (cof_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		*/
		private static function expMinor(factor:Number, coeff_arr:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 4×⎡1 3⎤ = 4((1×0) - (2×3))
			 *   ⎣2 0⎦ 
			 **/
			
			// only perform on a 2×2 matrix
			if (coeff_arr.length == 2 && (coeff_arr[0] as Array).length == 2)
				return (factor * ((coeff_arr[0][0] * coeff_arr[1][1]) - (coeff_arr[1][0] * coeff_arr[0][1])));
			
			// return 0
			return (0);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public static function genIdenty(dim:Point):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var ident_arr:Array = new Array();
			var factor_arr:Array = new Array();
			
			for (var j:int=0; j<dim.y; j++) {
				factor_arr = [];
				
				for (var i:int=0; i<dim.x; i++)
					factor_arr.push(int(i == j));
				
				ident_arr.push(factor_arr);
			}
			
			
			return (ident_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function genIdempotent(mtx:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 *  An idempotent matrix multiplied by itself, yields itself:
			 * 
			 * ⎡0 0 0⎤
			 * ⎢0 0 0⎢ × 
			 * ⎣0 0 0⎦
			 **/ 
			
			return ([]);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function genTranspose(mtx:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * ⎡1 3⎤  ⎡1 2 4⎤
			 * ⎢2 0⎢  ⎣3 0 7⎦
			 * ⎣4 7⎦
			 **/
			
			var i:int;
			var j:int;
			var cnt:int = 0;
			
			var tmp_arr:Array = new Array();
			var factor_arr:Array = new Array();
			var trans_arr:Array = new Array();
			
			
			for (i=0; i<(mtx[0] as Array).length; i++) {
				for (j=0; j<mtx.length; j++) {
					tmp_arr.push(mtx[j][i]);
				}
			}
			
			for (j=0; j<mtx.length; j++) {
				factor_arr = [];
				
				for (i=0; i<(mtx[0] as Array).length; i++)
					factor_arr.push(tmp_arr[cnt++]);
					
				trans_arr.push(factor_arr);
			}
				
			
			return (trans_arr)
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
			var zero_arr:Array = new Array();
			var factor_arr:Array = new Array();
			
			// loop thru rows x cols, and push zero into each element
			for (var j:int=0; j<dim.y; j++) {
				factor_arr = [];
				
				for (var i:int=0; i<dim.x; i++)
					factor_arr.push(0);
				
				zero_arr.push(factor_arr);
			}
			
			// send it back
			return (zero_arr);
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
		
		
		public function isBinary(mtx:Array):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			for (var j:int=0; j<mtx.length; j++) {
				for (var i:int=0; i<(mtx[0] as Array).length; i++) {
					if (mtx[j][i] != 0 || mtx[j][i] != 1)
						return (false);
				}
			}
			
			return (true)
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function isDiagnal(mtx:Array):Boolean {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			for (var j:int=0; j<mtx.length; j++) {
				for (var i:int=0; i<(mtx[0] as Array).length; i++) {
					if (i != j && mtx[j][i] != 0)
						return (false);
				}
			}
			
			return (true)
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		/**
		 * Generates the identity matrix represented as an <code>Array</code> for a given dimension. 
		 * @param mtx The square matrix as 2 dimensional list to create identity for.
		 * @return A list of 
		 * 
		 */		
		public static function invert(mtx:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			// return empty array if it's not square
			if (mtx.length != (mtx[0] as Array).length)
				return ([]);
			
			// loop iterators
			var i:int;
			var j:int;
			//var cnt:int = 0;
			var piv:int = 0;
			
			// dimension
			var size:int = mtx.length;
			var row_arr:Array = new Array();
			
			// identity
			var ident_arr:Array = genIdenty(new Point(size, size));
			
			// return array
			var invert_arr:Array = genZeroMatrix(new Point(size * 2, size));
			
			
			// build augmented matrix
			for (j=0; j<size; j++) {
				for (i=0; i<size*2; i++) {
					
					// src
					if (i < size)
						invert_arr[j][i] = mtx[j][i];
					
					// ident
					else
						invert_arr[j][i] = ident_arr[j][i - size];
				}
			}
			
			
			while (piv < size) {
				row_arr = [];
				
				for (i=0; i<size; i++) {
					if (i != piv)
						row_arr.push(invert_arr[i]);
				}
				
				//trace ("invert_arr["+piv+"]["+piv+"]:"+invert_arr[piv][piv]);
				if (invert_arr[piv][piv] != 1)
					reduce(invert_arr[piv], invert_arr[piv][piv]);
				//trace ("invert_arr["+piv+"]: "+invert_arr[piv]);
				
				invert_arr = pivot(piv, invert_arr[piv], row_arr);
				piv++;
			}
			
			
			for (j=0; j<size; j++) {
				for (i=0; i<size; i++)
					(invert_arr[j] as Array).shift();
			}
			
			return (invert_arr);
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
		
		
		public static function determinant(mtx:Array):Number {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			/**
			 * 
			 * 
			 * 
			 */
			
			var i:int;
			var j:int;
			
			var size:int = mtx.length;
			var fact:Number = 0;
			var mult:int = 1;
			var discrim:Number = 0;
			
			var factor_arr:Array = new Array();
			var row_arr:Array = new Array();
			var sub_arr:Array = new Array();
			var cof_arr:Array = new Array();
			
			for (var q:int=0; q<size; q++) {
				factor_arr.push(mtx[q][0]);
				
				if (q % 2 == 0)
					mult = 1;
					
				else
					mult = -1;
				
				sub_arr = [];
				for (j=1; j<size; j++) {
					row_arr = [];
					
					for (i=1; i<size; i++)
						row_arr.push(mtx[j][i])
							
					sub_arr.push(row_arr);
				}
				
				discrim += multiplyByFactor(sub_arr, factor_arr[q]);
				
				cof_arr.push(sub_arr);
			}
			
			for (q=0; q<size; q++) {
				if (q % 2 == 0)
					mult = 1;
				
				else
					mult = -1;
			}
			
			return (discrim);
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
				return ([]);
			
			
			// prime
			for (i=0; i<rows; i++) {
				
				var factor_arr:Array = new Array();
				for (j=0; j<cols; j++)
					factor_arr.push(0);
				
				prod_arr.push(factor_arr);
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
			
			
			/**
			 * ⎡1 3⎤   ⎡1 2⎤   ⎡(1+1) (3+2)⎤
			 * ⎢2 0⎢ + ⎢4 3⎢ = ⎢(2+4) (0+3)⎢
			 * ⎣4 7⎦   ⎣0 1⎦   ⎣(4+0) (7+1)⎦
			 **/
			
			
			var sum_arr:Array = new Array();
			var factor_arr:Array = new Array();
			
			
			for(var i:int=0; i<mtx1.length; i++)
				sum_arr.push(mtx1[i] + mtx2[i]);
			
			
			return (sum_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
			
		public static function multiplyByFactor(mtx_arr:Array, factor:Number):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var factor_arr:Array = new Array();
			var prod_arr:Array = new Array();
			
			for (var j:int=0; j<mtx_arr.length; j++) {
					factor_arr = [];
				
				if (mtx_arr[0] as Array) {
					for (var i:int=0; i<(mtx_arr[0] as Array).length; i++) {
						if (mtx_arr[j][i] == 0)
							factor_arr.push(0);
					
						else
							factor_arr.push(factor * mtx_arr[j][i]);
					}
				
					prod_arr.push(factor_arr);
				
				} else {
					if (mtx_arr[j] == 0)
						prod_arr.push(0);
							
					else
						prod_arr.push(factor * mtx_arr[j]);
				}
			}
			
			return (prod_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function concat(dim:Point, mtx1:Array, mtx2:Array):Array {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			var concat_arr:Array = new Array();
			
			var col:int = 0;
			var row:int = 0;
			
			for (var i:int=0; i<(dim.x * dim.y); i++) {
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
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		private static function pivot(pos:int, piv_row:Array, rows:Array):Array {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			//trace ("\n\npivoting @["+pos+"]:\n\tpiv_row:["+piv_row+"]\n\trows:["+rows+"]\n");
			
			var i:int;
			var j:int;
			var cnt:int = -1;
			var coeff:Number;
			var col:Number;
			
			var row_arr:Array = new Array();
			var piv_arr:Array = new Array();
			
			
			/*trace ("piv_row["+pos+"]:"+piv_row[pos]);
			if (piv_row[pos] != 1)
				reduce(piv_row, piv_row[pos]);
			trace ("piv_row[]: "+piv_row);*/
			
			// 
			for (j=0; j<=rows.length; j++) {
				row_arr = [];
				
				if (j != pos)
					cnt++;
				
				for (i=0; i<piv_row.length; i++) {
					
					if (j != pos) {
						coeff = rows[cnt][pos];
						
						//trace ("rows["+cnt+"]["+i+"]: "+rows[cnt][i]);
						//trace ("coeff: "+coeff);
						//trace ("piv_row["+i+"]: "+piv_row[i]);
						
						col = rows[cnt][i] - (coeff * piv_row[i]);
						
					} else
						col = piv_row[i];
					
					//trace ("col["+i+"]: "+col);
					row_arr.push(col);
				}

				//trace (j+") row_arr[]: "+row_arr);
				//trace ("[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n");
					
				piv_arr.push(row_arr);
			}
			
			return (piv_arr);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		
		private static function reduce(row:Array, factor:Number):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			for (var i:int=0; i<row.length; i++) {
				row[i] *= Number(Numbers.reciprocal(factor).toFixed(4));
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}