package
{
	import flash.text.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class SortingVectors extends Sprite
	{
		public function SortingVectors()
		{
			var logger:TextField = new TextField();
			logger.autoSize = TextFieldAutoSize.LEFT;
			addChild(logger);
			function log(msg:*): void { logger.appendText(msg+"\n"); }
			
			const NUM_ELEMENTS:uint = 500000;
			
			var v:Vector.<Point> = new Vector.<Point>(NUM_ELEMENTS);
			var v2:Vector.<Point> = new Vector.<Point>(NUM_ELEMENTS);
			var v3:Vector.<Point> = new Vector.<Point>(NUM_ELEMENTS);
			var a:Array = new Array(NUM_ELEMENTS);
			for (var i:int = 0; i < NUM_ELEMENTS; i++)
			{
				v[i] = v2[i] = v3[i] = a[i] = new Point(Math.random()*NUM_ELEMENTS, 0);
			}
			
			// Vector via sort()
			var startTime:int = getTimer();
			v.sort(f);
			log("Vector via sort(): " + (getTimer()-startTime));  // 1642
			
			startTime = getTimer();
			v.sort(f);
			log("Vector via sort() on ordered elements: " + (getTimer()-startTime)); // 1262
			
			
			// Array via sortOn()
			startTime = getTimer();
			a.sortOn("x", Array.NUMERIC);
			log("Array via sortOn(): " + (getTimer()-startTime));  // 649
			
			startTime = getTimer();
			a.sortOn("x", Array.NUMERIC);
			log("Array via sortOn() on ordered elements: " + (getTimer()-startTime));  // 504
			
			
			// Vector via quickSort()
			startTime = getTimer();
			quickSort(v2, 0, NUM_ELEMENTS-1);
			log("Vector via quickSort(): " + (getTimer()-startTime));  // 5234
			
			startTime = getTimer();
			quickSort(v2, 0, NUM_ELEMENTS-1);
			log("Vector via quickSort() on ordered elements: " + (getTimer()-startTime));  // 3615
			
			
			// Vector via shellSort()
			startTime = getTimer();
			shellSort(v3);
			log("Vector via shellSort(): " + (getTimer()-startTime)); // 7406
			
			startTime = getTimer();
			shellSort(v3);
			log("Vector via shellSort() on ordered elements: " + (getTimer()-startTime)); // 4148
			
		}
		
		// http://www.valveblog.com/2009/06/as3-sorting-algorithm-faster-than-native-sorting.html
		private function shellSort(data:Vector.<Point>): void
		{
			var n:int = data.length;
			var inc:int = int(n/2);
			while (inc)
			{
				for (var i:int = inc; i < n; i++)
				{
					var temp:Point= data[i], j:int = i;
					while (j >= inc && data[int(j - inc)].x > temp.x)
					{
						data[j] = data[int(j - inc)];
						j = int(j - inc);
					}
					data[j] = temp
				}
				inc = int(inc / 2.2);
			}
		}
		
		
		private function f(p1:Point, p2:Point): int
		{
			return p1.x - p2.x;
		}
		
		// http://www.kirupa.com/developer/actionscript/quickSort.htm
		private function quickSort(arrayInput:Vector.<Point>, left:int, right:int): void
		{
			var i:int = left;
			var j:int = right;
			var pivotPoint:Point = arrayInput[Math.round((left+right)*.5)];
			
			// Loop
			while (i<=j)
			{
				while (arrayInput[i].x < pivotPoint.x)
				{
					i++;
				}
				while (arrayInput[j].x > pivotPoint.x)
				{
					j--;
				}
				if (i <= j)
				{
					var tempStore:Point = arrayInput[i];
					arrayInput[i] = arrayInput[j];
					i++;
					arrayInput[j] = tempStore;
					j--;
				}
			}
			// Swap
			if (left < j)
			{
				quickSort(arrayInput, left, j);
			}
			if (i < right)
			{
				quickSort(arrayInput, i, right);
			}
		}
	}
}




// http://blog.inspirit.ru/?p=271