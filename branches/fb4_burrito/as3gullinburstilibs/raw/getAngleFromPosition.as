package com.jeffyamada.util
{
	import com.jeffyamada.math.Trig;
	
	import flash.geom.Point;
	
	public function getAngleFromPosition( p1:Point, p2:Point ):Number
	{
		return Trig.getAngleFromPosition( p1, p2 );
	}
}