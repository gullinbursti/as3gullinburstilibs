package {
	
	import cc.gullinbursti.lang.*;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.algebra.Matrices;
	import cc.gullinbursti.math.probility.Randomness;
	import cc.gullinbursti.sorting.*;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	public class as3gullinburstilibs_harness extends Sprite {
		
		private var cnt:int;
		private var holder_sprite:Sprite;
		
		
		public function as3gullinburstilibs_harness() {
			scaffold();
			
			
			//numberTests();
			//stringTests();
			//arrayTests();
			//matrixTests();
			//shapeTests();
			colorTests();
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
			
			
			//trace (DateTimes.timestampAsCountdown(new Date(2, 11, 30, 3, 55, 23)));
			
			trace (Ints.formatDbl(1));
			
		}
		
		
		
		private function colorTests():void {
			
			//trace (0xf04a3bc9, 0xf0000000, Colors.alphaAmt(0xf04a3bc9));
			redraw();
		}
		
		
		private function shapeTests():void {
			
			/*
			Tweener.addCaller(this, {
			count:1,
			
			time:4, 
			ease:"linear", 
			onUpdate:function():void {
			holder_sprite.addChild(Shapes.renderPolyhedron(cnt++, 128));
			}, 
			
			onComplete:function():void {
			holder_sprite.graphics.lineStyle(1, 0xff3366);
			holder_sprite.graphics.moveTo(0, -160);
			holder_sprite.graphics.lineTo(0, 160);
			holder_sprite.graphics.moveTo(-160, 0);
			holder_sprite.graphics.lineTo(160, 0);
			
			holder_sprite.graphics.drawCircle(0, 0, 128);
			holder_sprite.graphics.endFill();	
			}
			});
			*/
			
			holder_sprite.addChild(Shapes.renderPolyhedron(5, 128));
			
			holder_sprite.graphics.lineStyle(1, 0xff3366);
			holder_sprite.graphics.moveTo(0, -160);
			holder_sprite.graphics.lineTo(0, 160);
			holder_sprite.graphics.moveTo(-160, 0);
			holder_sprite.graphics.lineTo(160, 0);
			
			holder_sprite.graphics.drawCircle(0, 0, 128);
			holder_sprite.graphics.endFill();	
			
			
		}
		
		
		
		private function hdlHolder_Click(e:MouseEvent=null):void {
			redraw();
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
		
		
		
		private function bitmapTests():void {
			
		}
		
		
		private function matrixTests():void {
			
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
				[1, 3, 3], 
				[1, 4, 3], 
				[1, 3, 4]
			];
			
			
			
			var prod_arr:Array = Matrices.invert(blur_arr);
			
			trace(prod_arr);
		}
		
		
		
		private function scaffold():void {
			
			cnt = 11;
			holder_sprite = new Sprite();
			holder_sprite.x = 256;
			holder_sprite.y = 256;
			
			this.addChild(holder_sprite);
			
			holder_sprite.buttonMode = holder_sprite.useHandCursor = true;
			holder_sprite.addEventListener(MouseEvent.CLICK, hdlHolder_Click);
		}
		
		private function redraw():void {
			
			var color:uint = Colors.rndRGB();
			
			trace ("Colors.rndRGB:["+Colors.redAmt(color)+" "+Colors.greenAmt(color)+" "+Colors.blueAmt(color)+"] ("+color+")");
			
			holder_sprite.graphics.clear();
			holder_sprite.graphics.beginFill(color);
			holder_sprite.graphics.drawCircle(0, 0, 128);
			holder_sprite.graphics.endFill();
		}
	}
}



