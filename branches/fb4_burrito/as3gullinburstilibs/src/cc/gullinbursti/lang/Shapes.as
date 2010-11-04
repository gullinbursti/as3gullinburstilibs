package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.probility.Randomness;
	import cc.gullinbursti.converts.Angle;
	import flash.geom.Point;
	import flash.display.Shape;
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
			
			trace("ang_tot:["+ang_tot+"] ang_seg:["+ang_seg+"");	
				
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
	}
}