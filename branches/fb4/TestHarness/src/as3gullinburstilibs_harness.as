package {
	
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.lang.Chars;
	import cc.gullinbursti.lang.DateTimes;
	import cc.gullinbursti.lang.Numbers;
	import cc.gullinbursti.lang.Strings;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.geom.BasicGeom;
	import cc.gullinbursti.math.probility.Randomness;
	import cc.gullinbursti.sorting.*;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class as3gullinburstilibs_harness extends Sprite {
		
		public function as3gullinburstilibs_harness() {
			
			numberTests();
			
			//stringTests();
			//arrayTests();
		}
		
		
		private function numberTests():void {
			
			var float_rnd:Number = Randomness.generateFloat(1000, 2000, 5);
			var int_rnd:Number = Randomness.generateInt(100, 300);
			var tot_arr:Array = [0, 0]; 
			
			for (var i:int=0; i<10; i++) {
				//for (var j:int=0; j<100; j++) {
					var lehmer_rnd:Number = Randomness.generateInt();
					//trace (i, lehmer_rnd)
				//}
			}
			
			var epoch_ms:Number = DateTimes.epoch(null, true) * 10000;//new Date().getTime();
			
			trace ("\n", epoch_ms);
		}
		
		private function arrayTests():void {
			
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
		
		
		private function stringTests():void {
			
			//var search_str:String = Strings.genRndASCII(32);
			
			for (var i:int=0; i<16; i++)
				trace ("genRndASCII:["+Strings.genRndASCII(0, true, true)+"]");
			
				
			trace ("truncate:["+Strings.truncate(Strings.genRndASCII(50, true, true), 5, "…")+"]");
		}
		
		
		private function arraySorting():void {
			
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
	}
}



