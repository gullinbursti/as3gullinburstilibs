package utils.bitmap {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * @author nikkoh
	 */
	public class ScreenShot {
		
		/**
		 *  Simple drawing.
		 */
		public static function bitmap(target:IBitmapDrawable, width:Number, height:Number, matrix:Matrix = null,rect:Rectangle=null):Bitmap {
			if(width && height) {
				var bmd:BitmapData = new BitmapData(width, height, true, 0);
				bmd.draw(target, (matrix ? matrix : new Matrix()), null, null, rect, true);
			} else bmd = null;
			return new Bitmap(bmd, PixelSnapping.NEVER, true);
		}
		
		/**
		 *  Draws a 
		 */
		public static function bitmaps(target:DisplayObject, squareWidth:int, squareHeight:int, debugSplit:Boolean = false):Array {
		
			/**
			 *  Makes sure both square width and height is set.
			 */
			if(squareWidth && !squareHeight) squareHeight = squareWidth;
			else if(!squareWidth && squareHeight) squareWidth = squareHeight;
			else if(!squareWidth && !squareHeight) squareWidth = squareHeight = 100;

			/**
			 *  Splits the target up into smaller bitmaps.
			 */
			var arrBitmaps:Array = new Array();
			var bounds:Rectangle = target.getBounds(target);
			var cols:Number = Math.ceil(target.width/squareWidth);
			var rows:Number = Math.ceil(target.height/squareHeight);
			var numOfSquares:Number = cols*rows;
			
			/**
		 	 *  Creates all the squares necessary.
		 	 */
			for(var i:Number=0; i<numOfSquares; i++) {
			
				/**
			 	 *  Matrix that specifies drawing from desired area.
			 	 */
				var matrix:Matrix = new Matrix();
				matrix.tx = -bounds.x-(i%cols)*(squareWidth);
				matrix.ty = -bounds.y-(Math.floor(i/cols)*(squareHeight));
			
				/**
				 *  Makes sure the right edge and bottom bitmaps aren't bigger than necessary.
				 */
				var bWidth:Number = i%cols==cols-1 ? (target.width%squareWidth?target.width%squareWidth:squareWidth) : squareWidth;
				var bHeight:Number = Math.floor(i/cols)==rows-1 ? (target.height%squareHeight?target.height%squareHeight:squareHeight) : squareHeight;
				
				if(bWidth && bHeight) {
					
					/**
					 *  Attaches the bitmap.
				 	 */
				 	var bitmap:Bitmap = bitmap(target, bWidth, bHeight, matrix);
				 	bitmap.x = target.x - matrix.tx + (debugSplit ? (i%cols) : 0);
				 	bitmap.y = target.y - matrix.ty + (debugSplit ? (Math.floor(i/cols)) : 0);
					arrBitmaps.push(bitmap);
				}
			}
			return arrBitmaps;
		}
	}
}
