package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.converts.Angle;
	import cc.gullinbursti.math.probility.Randomness;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	// <[!] class delaration [!]>
	public class Shapes {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>	
		
		// <*] class constructor [*>
		public function Shapes() {/*..\(^_^)/..*/}
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function renderPolyhedron(sides:int, rad:int, ratio:Number=1.0, stroke:Point=null, fill:Point=null):Shape {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._

			if (sides < 3)
				return (new Shape());
			
			if (!stroke) 
				stroke = new Point(4, 0x0f0f0f);
				
			if (!fill)
				fill = new Point(0x808080, 0.1);
				
			var ang_tot:int = ((sides - (sides - 2)) * 180);
			var ang_seg:Number = ang_tot / sides;
			var ang_offset:Number = 0;
			
			var pos_offset:Point = new Point();
				pos_offset.x = Math.sin(Angle.degreesToRadians(ang_offset)) * rad;
				pos_offset.y = Math.cos(Angle.degreesToRadians(ang_offset)) * rad;
			
			
			pos_offset.x *= ratio;
			pos_offset.y *= ratio;
			
			trace("ang_tot:["+ang_tot+"] ang_seg:["+ang_seg+""+Colors.BLUE);	
				
			var shape:Shape = new Shape();
				shape.rotation = -180;
				shape.graphics.moveTo(pos_offset.x, pos_offset.y);
				shape.graphics.lineStyle(stroke.x, stroke.y);
				shape.graphics.beginFill(fill.x, fill.y);
				
			ang_offset -= (ang_seg * 0.5);
			for (var i:int=0; i<ang_tot; i+=ang_seg) {
				
				pos_offset.x = Math.sin(Angle.degreesToRadians(i)) * rad;
				pos_offset.y = Math.cos(Angle.degreesToRadians(i)) * rad;
				pos_offset.x *= ratio;
				pos_offset.y *= ratio;
				
				trace("line:["+(i / ang_seg )+"] = "+i+" @("+pos_offset+")");
				
				
				shape.graphics.lineTo(pos_offset.x, pos_offset.y);
				ang_offset += ang_seg;
				
				
			}
			
			shape.graphics.endFill();
			
			return (shape);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function tri3Color(pt1:Point, fill1:uint, pt2:Point, fill2:uint, pt3:Point, fill3:uint):Shape {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
				     
			// create 2x2 canvas
			var bmpData:BitmapData = new BitmapData(2 , 2, true);
			
			// copy colors to bitmap, 4th is avg
			bmpData.setVector(bmpData.rect, Vector.<uint>([
				fill1, 
				fill2, 
				fill3, 
				Bits.rShift(fill2 + fill3, 1)
			]));
 			
			
			var shape:Shape = new Shape();
				shape.graphics.beginBitmapFill(bmpData, null, false, true);		
				shape.graphics.drawTriangles(
	
					// x,y -coordinates
					Vector.<Number>([
						pt1.x, pt1.y, 
						pt2.x, pt2.y, 
						pt3.x, pt3.y
					]),
		
					// indices
					Vector.<int>([
						0, 
						1, 
						2
					]),
					
					// texture coordinates
					Vector.<Number>([
						0, 
						0, 
						1,0, 
						0,1
					])
				);
				
				
			return (shape);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}