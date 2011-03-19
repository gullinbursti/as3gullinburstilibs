package {
	import caurina.transitions.Tweener;
	
	import cc.gullinbursti.math.algebra.BasicAlgebra;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import mx.containers.Canvas;
	
	import spark.primitives.BitmapImage;
	
	
	/**
	 * 
	 * @author:		Gullinbursti
	 * @class:		TestCases
	 * @package:	
	 * @created:	12:05:05 PM Nov 21, 2010
	 */
	public class TestCases {
		
		import cc.gullinbursti.lang.*;
		import cc.gullinbursti.math.BasicMath;
		import cc.gullinbursti.math.algebra.Matrices;
		import cc.gullinbursti.math.geom.Polyhedron;
		import cc.gullinbursti.math.probility.Randomness;
		import cc.gullinbursti.sorting.*;
		
		import flash.geom.Point;
		
		public var cnt:Number=-100;
		
		public function TestCases() {
		}
		
		
		public function numberTests():void {
			
			var float_rnd:Number = Randomness.generateFloat(1, 100);
			var int_rnd:Number = Randomness.generateInt(100, 300);
			var tot_arr:Array = [0, 0]; 
			
			//for (var i:int=0; i<100; i++)
			//	trace ("BasicMath.mersenneTwister("+i+")", Randomness.mersenneTwister());
			
			/*
			for (var i:int=0; i<10; i++) {
				float_rnd = Randomness.generateFloat(500, 1500, Randomness.generateInt(3, 5));
				//trace (float_rnd, decimal, Number(float_rnd.toFixed(5)), (int(float_rnd) + Number(decimal.toPrecision(5))), Numbers.setDecimalPrecision(float_rnd, 5))
				//trace (float_rnd, Numbers.decimalPrecision(float_rnd, 0), Numbers.extendDecimal(float_rnd, 5));
				trace (float_rnd, "\n[=-=-=-=-=-=-=-=-=-=-=-=-=]")
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 0));
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 1));
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 2));
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 3));
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 4));
				trace (float_rnd, Numbers.extendDecimal(float_rnd, 5), Numbers.decimalPlace(float_rnd, 5));
				
				trace (float_rnd, Numbers.integerPlace(float_rnd, 0));
				trace (float_rnd, Numbers.integerPlace(float_rnd, 1));
				trace (float_rnd, Numbers.integerPlace(float_rnd, 2));
				trace (float_rnd, Numbers.integerPlace(float_rnd, 3));
				trace (float_rnd, Numbers.integerPlace(float_rnd, 4));
				
				trace ("[=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=]\n\n");
			}
			*/
			
			/*
			trace (int_rnd);
			trace ("Numbers.reciprocal", Numbers.reciprocal(10));
			trace ("Ints.reciprocal", Ints.reciprocal(10));
			trace ("BasicAlgebra.reciprocal", BasicAlgebra.reciprocal(10));
			
			
			trace ("Numbers.additiveInverse", Numbers.additiveInverse(10));
			trace ("Ints.additiveInverse", Ints.additiveInverse(10));
			trace ("BasicAlgebra.additiveInverse", BasicAlgebra.additiveInverse(10));
			*/
			
			//trace (int_rnd, int_rnd.toPrecision(5), (int_rnd.toString() + Numbers.decimalPlace(int_rnd).toPrecision(5)), Numbers.setDecimalPrecision(int_rnd, 5))
			
			//trace ("Numbers.decimalPlace("+float_rnd+"): ["+Numbers.decimalPlace(float_rnd)+"]")
			//trace ("Numbers.extendDecimal("+float_rnd+", 3): ["+Numbers.extendDecimal(float_rnd, 3)+"]")
		}
		
		public function arrayTests():void {
			
			//var search_str:String = Strings.genRndASCII(32);
			
			
			/**
			 * [  [  "H",   72,   0x0048],   true]    
			 * [_⁰[_⁰"H", _¹72, _²0x0048], _¹true]
			 */
			
			
			var nest_arr:Array = new Array(
				/*[["H", 1, 0x0048],  true],
				[["I", 2, 0x0049],  true], 
				[["J", 3, 0x004a], false], 
				[["K", 4, 0x004b],  true], 
				[["L", 5, 0x004c], false]*/
				
				
				[["A", 10, 0x0041], ["a", 20, 0x0061], ["", ""]], 
				[["B", 11, 0x0042], ["b", 21, 0x0062], ["", ""]], 
				[["C", 12, 0x0043], ["c", 22, 0x0063], ["", ""]], 
				[["D", 13, 0x0044], ["d", 23, 0x0064], ["", ""]], 
				[["E", 14, 0x0045], ["e", 24, 0x0065], ["", ""]]
			);
			
			//var slice_arr:Array = Arrays.subsetSlicer(Arrays.subsetSlicer(nest_arr, [0]), [2]);
			var slice_arr:Array = Arrays.subsetSlicer(nest_arr, [0, 0, 2]);
			trace ("subSlice:[>"+slice_arr+"<]");
			
		}
		
		
		public function stringTests():void {
			
			
			//trace (DateTimes.timestampAsCountdown(new Date(2, 11, 30, 3, 55, 23)));
			
			trace (Ints.formatDblDigit(1));
			
		}
		
		
		
		public function colorTests(canvas:Canvas):void {
			
			//trace (0xf04a3bc9, 0xf0000000, Colors.alphaAmt(0xf04a3bc9));
			redraw(canvas);
		}
		
		
		
		public function dateTests(canvas:Canvas=null):void {
			
			var swatch_val:String = "@248";
			var date_str:String = "Mon Feb 14 20:55:07 GMT-0800 2011";
			var utc_str:String = "Tue Feb 15 00:02:13 2011 UTC";
			var iso8601_str:String = "2005-08-15T15:52:01-0700"; //"2005-08-15T15:52:01-0730";
			var mysql_str:String = "2005-08-15 15:52:01.051";
			var atom_str:String = "2005-08-15T15:52:01-07:00"; //"2005-08-15T15:52:01-07:30"; //"2005-08-15T15:52:01Z";
			
			var curr_date:Date = new Date();
			var str_date:Date = new Date(date_str);
				str_date.setMilliseconds(0);
				
			var utc_date:Date = new Date(Date.UTC(curr_date.getFullYear(), curr_date.getMonth(), curr_date.getDate(), curr_date.getHours(), curr_date.getMinutes() + curr_date.getTimezoneOffset(), curr_date.getSeconds(), curr_date.getMilliseconds()));
			
			var jul:Number = (str_date.hours+(str_date.minutes+str_date.seconds/60)/60)/24;
			
			//trace ("DateTimes.stringToDate("+date_str+"): ["+DateTimes.stringToDate(date_str)+"]");
			//trace ("DateTimes.asUTC("+curr_date+"): ["+DateTimes.asUTC(curr_date)+"]");
			
			//trace ("Date.UTC(): ["+Date.UTC(curr_date.getFullYear(), curr_date.getMonth(), curr_date.getDate(), curr_date.getHours(), curr_date.getMinutes(), curr_date.getSeconds(), curr_date.getMilliseconds())+"]");
			//trace ("Date.UTC(): ["+utc_date.toString()+"] ["+utc_date.toUTCString()+"]");
			//trace ("DateTimes.asUTC("+curr_date+"): ["+DateTimes.asUTC(curr_date)+"] ["+DateTimes.asUTC(curr_date).toUTCString()+"]");
			
			//trace ("DateTimes.swatchTimeToDate("+val+"): ["+swatch_date+"]");
			//trace ("DateTimes.asSwatchInternetTime("+str_date+"): ["+DateTimes.asSwatchInternetTime(str_date)+"]");
			//trace ("DateTimes.swatchTimeToDate("+swatch_val+"): ["+DateTimes.swatchTimeToDate(swatch_val)+"]");
			
			//trace ("DateTimes.iso8601ToDate("+iso8601_str+"): ["+DateTimes.iso8601ToDate(iso8601_str)+"] ["+DateTimes.iso8601ToDate(iso8601_str).toUTCString()+"]");
			//trace ("DateTimes.atomToDate("+atom_str+"): ["+DateTimes.atomToDate(atom_str)+"] ["+DateTimes.atomToDate(atom_str).toUTCString()+"]");
			
			//trace ("DateTimes.asJulianDay("+str_date+"): ["+DateTimes.asJulianCalendar(str_date)+"] ["+DateTimes.asJulianDay(str_date, false)+"]");
			//trace ("DateTimes.asJulianDay("+DateTimes.asJulianDay(str_date, false)+"): ["+DateTimes.julianToDate(DateTimes.asJulianDay(str_date, false))+"]");
			
			//trace ("DateTimes.asIslamDate("+curr_date+"): ["+DateTimes.asIslamDate(curr_date)+"]");
			
			//trace ("DateTimes.easterDate("+str_date.getFullYear()+"): ["+DateTimes.easterDate(str_date.getFullYear())+"]");
			
			//trace ("DateTimes.dstStart("+2011+"): ["+DateTimes.dstStart(2011)+"]");
			//trace ("DateTimes.dstEnd("+2011+"): ["+DateTimes.dstEnd(2011)+"]");
			
			//trace ("DateTimes.difference("+2011+"): ["+DateTimes.difference(DateTimes.dstStart(2011), DateTimes.dstEnd(2011))+"]");
			//trace ("DateTimes.elapsedSince("+2011+"): ["+DateTimes.elapsedSince(DateTimes.dstStart(2011), DateTimes.dstEnd(2011))+"]");
			//trace ("DateTimes.unixEpochToDate(): ["+DateTimes.unixEpochToDate(DateTimes.difference(DateTimes.dstStart(2011), DateTimes.dstEnd(2011)), true)+"]");
			
			
			//trace ("DateTimes.midnight(): ["+DateTimes.midnight()+"]");
			//trace ("DateTimes.endOfDay(): ["+DateTimes.endOfDay()+"]");
			
			trace ("DateTimes.secondsToEOD(): ["+DateTimes.secondsToEOD()+"]");
		}
		
		
		
		public function filterTests(canvas:Canvas):void {
			
			canvas.filters = [ConvolutionFilters.blur(2)];
		}
		
		
		public function cryptoTests():void {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			
			var chars:String = Strings.genRndCharsHex(0xff);
			
			trace (chars);
			
			
			
			
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯

		
		
		public function shapeTests(canvas:Canvas):void {
			
			canvas.addEventListener(MouseEvent.CLICK, function (e:MouseEvent=null):void {
				redraw(canvas);
			});
			
			var guide_shape:Shape = new Shape();
				guide_shape.x = 256;
				guide_shape.y = 256;
				guide_shape.graphics.lineStyle(1, 0xff3366);
				guide_shape.graphics.moveTo(0, -160);
				guide_shape.graphics.lineTo(0, 160);
				guide_shape.graphics.moveTo(-160, 0);
				guide_shape.graphics.lineTo(160, 0);
				guide_shape.graphics.drawCircle(0, 0, 128);
				guide_shape.graphics.endFill();
				
			var shape:Shape = Shapes.renderPolyhedron(Polyhedron.OCTAGON, 128);
				shape.x = 256;
				shape.y = 256;
			
			canvas.rawChildren.addChild(shape);
			canvas.rawChildren.addChild(guide_shape);
		}
		
		public function arraySorting():void {
			
			var len:int = 10;
			
			var ind_arr:Array = Arrays.genIndexedVals(len);
			
			//var rnd_arr:Array = [3,0,1,9,2,7,8,5,4,6];
			//var rnd_arr:Array = Arrays.genScrambled(len);
			var rnd_arr:Array = Arrays.genRandVals(len, new Point(0, BasicMath.cube(len)));
			
			
			var asc_arr:Array =  BasicSorting.insertionSort(rnd_arr);
			var dsc_arr:Array = BasicSorting.selectionSort(rnd_arr, false);
			
			trace ("RND:",rnd_arr);
			trace ("ASC:",asc_arr);
			trace ("DSC:",dsc_arr);
			
			trace ("SORTED:",BasicSorting.isSorted(dsc_arr));
			trace ("ASC SORTED:",BasicSorting.isAcsendSorted(asc_arr));
			trace ("DSC SORTED:",BasicSorting.isDesendSorted(dsc_arr));
			
		}
		
		public function bitmapTests(src_bmpData:BitmapData, out_cnv:Canvas):void {
			var src_sprite:Sprite = new Sprite();
				src_sprite.x = 0;
			
			var red_sprite:Sprite = new Sprite();
				red_sprite.x = 0;	
				red_sprite.y = 150;
				
			var green_sprite:Sprite = new Sprite();
				green_sprite.x = 112;
				green_sprite.y = 150;
			
			var blue_sprite:Sprite = new Sprite();
				blue_sprite.x = 224;
				blue_sprite.y = 150;
			
			var alpha_sprite:Sprite = new Sprite();
				alpha_sprite.x = 336;
				alpha_sprite.y = 150;
				
			var rot_sprite:Sprite = new Sprite();
				rot_sprite.x = 112;
			
			var greyscale_sprite:Sprite = new Sprite();
				greyscale_sprite.x = 224;
			
				
			/*var red_bmpData:BitmapData = src_bmpData.clone();
			var green_bmpData:BitmapData = src_bmpData.clone();
			var blue_bmpData:BitmapData = src_bmpData.clone();
			var alpha_bmpData:BitmapData = src_bmpData.clone();
			*/
				
			var red_bmpData:BitmapData = BitmapDatas.extractChannel(src_bmpData, BitmapDataChannel.RED, true);
			var green_bmpData:BitmapData = BitmapDatas.extractChannel(src_bmpData, BitmapDataChannel.GREEN, true);
			var blue_bmpData:BitmapData = BitmapDatas.extractChannel(src_bmpData, BitmapDataChannel.BLUE, true);
			var alpha_bmpData:BitmapData = BitmapDatas.extractChannel(src_bmpData, BitmapDataChannel.ALPHA, true);
			
			var greyscale_bmpData:BitmapData = src_bmpData.clone();
			var rot_bmpData:BitmapData = src_bmpData.clone();
			
			/*BitmapDatas.dropChannel(red_bmpData, BitmapDataChannel.RED);
			BitmapDatas.dropChannel(green_bmpData, BitmapDataChannel.GREEN);
			BitmapDatas.dropChannel(blue_bmpData, BitmapDataChannel.BLUE);
			BitmapDatas.dropChannel(alpha_bmpData, BitmapDataChannel.ALPHA);*/
			
			BitmapDatas.greyscale(greyscale_bmpData);
			BitmapDatas.saturate(rot_bmpData, 0.5);
			//BitmapDatas.hue(rot_bmpData, 0);
			 
			
			
			src_sprite.addChild(new Bitmap(src_bmpData));
			red_sprite.addChild(new Bitmap(red_bmpData));
			green_sprite.addChild(new Bitmap(green_bmpData));
			blue_sprite.addChild(new Bitmap(blue_bmpData));
			alpha_sprite.addChild(new Bitmap(alpha_bmpData));
			rot_sprite.addChild(new Bitmap(rot_bmpData));
			greyscale_sprite.addChild(new Bitmap(greyscale_bmpData));
			
			
			out_cnv.rawChildren.addChild(src_sprite);
			out_cnv.rawChildren.addChild(red_sprite);
			out_cnv.rawChildren.addChild(green_sprite);
			out_cnv.rawChildren.addChild(blue_sprite);
			out_cnv.rawChildren.addChild(alpha_sprite);
			out_cnv.rawChildren.addChild(rot_sprite);
			out_cnv.rawChildren.addChild(greyscale_sprite);
		}
		
		
		public function matrixTests():void {
			
			var blur_arr:Array = new Array(
				[0,  1,  2,  4,  8,  4,  2,  1,  0], 
				[1,  2,  4,  8, 16,  8,  4,  2,  1], 
				[2,  4,  8, 16, 32, 16,  8,  4,  2],  
				[4,  8, 16, 32, 64, 32, 16,  8,  4], 
				[8, 16, 32, 64,128, 64, 32, 16,  8],  
				[4,  8, 16, 32, 64, 32, 16,  8,  4], 
				[2,  4,  8, 16, 32, 16,  8,  4,  2],
				[1,  2,  4,  8, 16,  8,  4,  2,  1], 
				[0,  1,  2,  4,  8,  4,  2,  1,  0]
			);
			
			
			blur_arr = [
				3, 1, 3,
				1, 2, 1,
				4, 1, 3
			];
			
			
			var indent_arr:Array = Matrices.genIdenty(new Point(3, 3));
			//var prod_arr:Array = Matrices.invert(blur_arr);
			var concat_arr:Array = Matrices.concat(new Point(3, 3), blur_arr, indent_arr);
			
			trace(concat_arr);
		}
		
		
		
		private function redraw(canvas:Canvas):void {
			
			var color:uint = Colors.rndRGB();
			
			trace ("Colors.rndRGB:["+Colors.redAmt(color)+" "+Colors.greenAmt(color)+" "+Colors.blueAmt(color)+"] ("+color+")");
			canvas.graphics.clear();
			canvas.graphics.beginFill(color);
			canvas.graphics.drawCircle(0, 0, 128);
			canvas.graphics.endFill();
		}
	}
}