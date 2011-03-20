package com.jeffyamada.math
{
        import flash.geom.Point;


         /**
         * Basic Trig methods for calculating angles and rotation
         *
         * @author      Jeff Yamada
         * @version     1.0
         */
        public class Trig
        {
                /**
                 * degreesToRadians takes a degree value and
                 * returns radians. It is primarily used by
                 * the other conversion methods within the
                 * NavTools class
                 *
                 * @usage   degreesToRadians(360);
                 * @param   degrees             The number of degrees to be converted
                 * @return    Number            This returns the radian equivelent of degrees passed
                 */
                static public function degreesToRadians(degrees:Number):Number
                {
                        return(degrees*Math.PI/180);
                }


                /**
                 * Takes a degree value and the lengh in
                 * pixels of the hypotenuse and returns a
                 * _y value.
                 *
                 * @usage   deghyp2X(360, 100);
                 * @param   degrees             The number of degrees, typically between 0 and 360.
                 * @param   hypo                The length of the hypotenuse, or distance from the center.
                 * @return    Number value of _y
                 */
                static public function deghyp2X(degrees:Number, hypo:Number):Number
                {
                        return Math.cos(degreesToRadians(degrees))*hypo;
                }


                /**
                 * Takes a degree value and the lengh in
                 * pixels of the hypotenuse and returns a
                 * _x value.
                 *
                 * @usage   deghyp2Y(360, 100);
                 * @param   degrees             The number of degrees, typically between 0 and 360.
                 * @param   hypo                The length of the hypotenuse, or distance from the center.
                 * @return    Number value of _x
                 */
                static public function deghyp2Y(degrees:Number, hypo:Number):Number
                {
                        return Math.sin(degreesToRadians(degrees))*hypo;
                }

                
                /**
                 * Returns a Point that represents the position given an angle
                 * and distance from 0,0.
                 * 
                 * @param degrees		The degree of the angle 0-360
                 * @param hypotenuse	The distance from 0,0
                 * @return 				A Point object that represents the x/y resultant
                 */                
                static public function getPositionFromAngle( degrees:Number, hypotenuse:Number ):Point
                {
                        return new Point( deghyp2X(degrees,hypotenuse), deghyp2Y(degrees,hypotenuse) );
                }
                
                static public function getAngleFromPosition( p1:Point, p2:Point ):Number
                {
                	var dx:Number = p1.x - p2.x;
                	var dy:Number = p1.y - p2.y;
                	return Math.atan2( dy, dx ) * 180 / Math.PI;
                }
        }
}
