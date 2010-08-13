package {
	
	import cc.gullinbursti.lang.Arrays;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.geom.BasicGeom;
	import cc.gullinbursti.sorting.BasicSorting;
	import cc.gullinbursti.sorting.Selecting;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class as3gullinburstilibs_harness extends Sprite {
		
		public function as3gullinburstilibs_harness() {
			
			var len:int = 10;
			
			var ind_arr:Array = Arrays.genIndexedVals(len);
			var rnd_arr:Array = Arrays.genRandVals(len, new Point(0, BasicMath.cube(len)));
			//var rnd_arr:Array = Arrays.genScrambled(len);
			var asc_arr:Array = BasicSorting.selectionSort(rnd_arr);
				
			trace ("RND:",rnd_arr);
			trace ("ASC:",asc_arr);
			
		}
	}
}