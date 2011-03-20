package com.jeffyamada.util
{
	import com.jeffyamada.math.Trig;
	
	import flash.geom.Point;
	/**
     * Returns a Point that represents the position given an angle
     * and distance from 0,0.
     * 
     * @param angle			The angle in degrees, generally 0-360
     * @param distance		The distance from 0,0
     * @return 				A Point object that represents the x/y resultant
     */
	public function getPositionFromAngle( angle:Number, distance:Number ):Point
	{
		return Trig.getPositionFromAngle( angle, distance );
	}
}