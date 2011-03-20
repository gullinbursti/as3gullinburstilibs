package com.jeffyamada.util
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public function centerCropImage( object:DisplayObject, area:Rectangle ):DisplayObject
	{
		var percent:Number = area.width/object.width;
		object.width = area.width;
		object.height *= percent;
		if( object.height > area.height ) {
			object.y = -(object.height-area.height)/2;
		} else {
			percent = area.height / object.height;
			object.height = area.height;
			object.width *= percent;
			object.x = -( object.width-area.width ) / 2;
		} return object;
	}
}