package utils.bitmap {
	import adobe.images.JPEGEncoder;
	import adobe.images.PNGEncoder;

	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	/**
	 * @author Svante
	 * @time 9 jun 2009 16.54.25
	 * @project saab
	 */
	public class SaveImageToDisk {

		public static function SaveJpeg(a_target:IBitmapDrawable,a_rect:Rectangle,a_quality:Number=100,a_name:String="snapshot") : void {
			var bdata : BitmapData = new BitmapData(a_rect.width,a_rect.height,false,0);
			bdata.draw(a_target);
			var je : JPEGEncoder = new JPEGEncoder(a_quality);
			var data : ByteArray = je.encode(bdata);
			var fr : FileReference = new FileReference();
			fr.save(data,a_name+".jpg"); 
		}
		public static function SavePng(a_target:IBitmapDrawable,a_rect:Rectangle,a_name:String="snapshot") : void {
			var bdata : BitmapData = new BitmapData(a_rect.width,a_rect.height,true,0);
			bdata.draw(a_target);
			var data : ByteArray = PNGEncoder.encode(bdata);
			var fr : FileReference = new FileReference();
			fr.save(data,a_name+".png"); 
		}
	}
}
