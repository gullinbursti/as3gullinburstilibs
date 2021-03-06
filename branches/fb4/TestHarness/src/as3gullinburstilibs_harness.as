package {
	
	import cc.gullinbursti.lang.*;
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.math.algebra.Matrices;
	import cc.gullinbursti.math.geom.Polyhedron;
	import cc.gullinbursti.math.probility.Randomness;
	import cc.gullinbursti.math.settheory.BasicSetTheory;
	import cc.gullinbursti.sorting.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	//[SWF(backgroundColor="#ffffff", frameRate="24", widthPercent="100%", heightPercent="100", pageTitle="AS3 Gullinbursti Libs // Test Harness")]
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	public class as3gullinburstilibs_harness extends Sprite {
		
		private var cnt:int;
		private var holder_sprite:Sprite;
		private var holder_dim:Rectangle = new Rectangle(0, 0, 480, 320);
		
		private static const SAMPLE_RATE:uint = 44100;
		private static const RESOLUTION:uint = 2048;
		
		private var sound:Sound = new Sound();
		private var mono:Boolean = true;
		private var wave_ang:Number = 0;

		private var note:int = 0;
		
		private var timer:Timer = new Timer(500);
		
		public function as3gullinburstilibs_harness() {
			scaffold();
			
			//draw();
			
			//numberTests();
			//stringTests();
			//arrayTests();
			//matrixTests();
			//shapeTests();
			//colorTests();
			
			audioTest();
		}
		
		private function audioTest():void {
			
			sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, hdlSound_SampleData);
			sound.play();
			
			timer.addEventListener(TimerEvent.TIMER, function (e:TimerEvent):void {
				note = Randomness.generateInt(-5, 15);
				timer.delay = 125 * Randomness.diceRoller(8);
				
				trace (note, timer.delay);
				
			});
			timer.start();
		}
			
		private function hdlSound_SampleData(e:SampleDataEvent):void {
			
			var graph_sprite:Sprite = holder_sprite.getChildAt(0) as Sprite;
				graph_sprite.graphics.clear();
				graph_sprite.graphics.moveTo(0, stage.stageHeight / 2);
				graph_sprite.graphics.lineStyle(0, 0x999999);
				//graph_sprite.graphics.beginFill(0x00ffff);
			
			// 2048 - 8192 --> samples to write
			for(var i:int=0; i<RESOLUTION; i++)
				write(i, e.data, sine());
			
			//graph_sprite.graphics.endFill();
		}
		
		
		private function noise(freq:Point=null, isStereo:Boolean=true):Point {
			
			if (!freq)
				freq = new Point(-1, 1);
			
			var samp_pt:Point = new Point();
				samp_pt.x = Randomness.generateFloat(freq.x, freq.y, 10);
				samp_pt.y = Randomness.generateFloat(freq.x, freq.y, 10);
				
			wave_ang++;
				
			if (!isStereo)
				samp_pt.y = samp_pt.x;
			
			return (samp_pt);
		}
		
		private function sine(freq:Number=440, isStereo:Boolean=true):Point {
			
			var phase:Number = wave_ang / SAMPLE_RATE * Math.PI * 2;
			//var samp_pt:Point = new Point(Math.sin(phase * freq), Math.sin(phase * freq));
			var samp_pt:Point = new Point(Math.sin(phase * 440 * Math.pow(2, note / 12)), Math.sin(phase * 440 * Math.pow(2, note / 12)));
			wave_ang++;
			
			if (!isStereo)
				samp_pt.y = samp_pt.x;
			
			return (samp_pt);
		}
		
		private function square(freq:Number=440, isStereo:Boolean=true):Point {
			
			var phase:Number = wave_ang / SAMPLE_RATE * Math.PI * 2;
			var samp_pt:Point = new Point(Math.sin(phase * freq), Math.sin(phase * freq));
			wave_ang++;
			
			if (!isStereo)
				samp_pt.y = samp_pt.x;
			
			return (samp_pt);
		}
		
		private function write(ind:int, ba:ByteArray, samps:Point):void {
			
			ba.writeFloat(samps.x); // left
			ba.writeFloat(samps.y); // right
			
			var graph_sprite:Sprite = holder_sprite.getChildAt(0) as Sprite;
				graph_sprite.graphics.lineTo(ind / RESOLUTION * holder_dim.width, (holder_dim.height * 0.5) - samps.x * (holder_dim.height * 0.5));
		}
		
		private function numberTests():void {
			
			var float_rnd:Number = Randomness.generateFloat(1000, 2000, 5);
			var int_rnd:Number = Randomness.generateInt(100, 300);
			var tot_arr:Array = [0, 0]; 
			
			trace ("BasicMath.mersenneTwister()", Randomness.mersenneTwister());			
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
			
			holder_sprite.addChild(Shapes.renderPolyhedron(Polyhedron.PENTAGON, 128));
			
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
		
		
		
		private function scaffold(pos:Point=null):void {
			
			if (!pos)
				pos = new Point(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			
			cnt = 11;
			holder_sprite = new Sprite();
			holder_sprite.x = pos.x + (holder_dim.width * -0.5);
			holder_sprite.y = pos.y + (holder_dim.height * -0.5);
			
			var guide_shape:Shape = new Shape();
				guide_shape.graphics.lineStyle(1, 0xff3366);
				guide_shape.graphics.drawRect(0, 0, holder_dim.width, holder_dim.height);
				//guide_shape.graphics.drawCircle(0, 0, holder_dim.width * 0.25);
				
				guide_shape.graphics.lineStyle(1, 0x99cc00);
				guide_shape.graphics.moveTo(0, holder_dim.height * 0.5);
				guide_shape.graphics.lineTo(holder_dim.width, holder_dim.height * 0.5);
				
				//guide_shape.graphics.moveTo(-holder_dim.width * 0.5, 0);
				//guide_shape.graphics.lineTo(holder_dim.width * 0.5, 0);
				//guide_shape.graphics.moveTo(0, -holder_dim.height * 0.5);
				//guide_shape.graphics.lineTo(0, holder_dim.height * 0.5);
			
				
			var graph_sprite:Sprite = new Sprite();
				
			holder_sprite.addChild(graph_sprite);
			holder_sprite.addChild(guide_shape);
			this.addChild(holder_sprite);
			
			holder_sprite.buttonMode = holder_sprite.useHandCursor = true;
			holder_sprite.addEventListener(MouseEvent.CLICK, hdlHolder_Click);
			
			stage.addEventListener(Event.RESIZE, function (e:Event):void {
				pos.x = stage.stageWidth * 0.5;
				pos.y = stage.stageHeight * 0.5;
				
				holder_sprite.x = pos.x + (holder_dim.width * -0.5);
				holder_sprite.y = pos.y + (holder_dim.height * -0.5);
			});
		}
		
		
		private function draw():void {
			
			var xp:Number = 0;
			var yp:Number = 0;
			var t:Number = 0;
			var a:Number = 15;
			var b:Number = 3;
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
			 
			holder_sprite.graphics.lineStyle(0, 0x000000);
			holder_sprite.addEventListener(Event.ENTER_FRAME, function (e:Event):void {
				
				var p:Number = ((a + b) / b) * t
				
				xp = (a + b) * Math.cos(t) - b * Math.cos(p);
				yp = (a + b) * Math.sin(t) - b * Math.sin(p);
				    
				if (t == 0)
					holder_sprite.graphics.moveTo(xp, yp);
				
				else
					holder_sprite.graphics.lineTo(xp, yp);
				
				t += 0.05;
			});	
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



