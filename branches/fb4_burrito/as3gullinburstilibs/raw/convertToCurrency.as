package com.jeffyamada.util
{
	public function convertToCurrency( number:Number ):String {
		var buf:String = "";
		var sBuf:String = "";
		var j:Number = 0;
		var value:String = String( number );
 
		if( value.indexOf(".") > 0 ) {
			buf = value.substring(0, value.indexOf("."));
		} else {
			buf = value;
		}
			
		if( buf.length%3!=0 && (buf.length/3-1) > 0) {
			sBuf = buf.substring(0, buf.length%3) + ",";
			buf = buf.substring(buf.length%3);
		}
			
		j = buf.length;
		for (var i:int = 0; i <(j/3-1); i++) {
			sBuf = sBuf+buf.substring(0, 3) + ",";
			buf = buf.substring(3);
		}
		sBuf = sBuf+buf;
		
		if (value.indexOf(".") > 0) {
			value = sBuf + value.substring(value.indexOf("."));
		} else {
			value = sBuf;
		}
		
		if( value.indexOf(".") == -1 ) value += ".";
		while( value.indexOf(".") > value.length-3 ) {
			value += "0";
		}
		
		return "$"+value;
	}
}