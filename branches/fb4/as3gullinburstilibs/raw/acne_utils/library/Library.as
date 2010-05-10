package utils.library {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	/**
	 * @author nikkoh
	 */
	public class Library {
		
		public static function getClass(className:String):Object {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			return Object(new ClassRef());
		}
		public static function getBitmapData(className:String):BitmapData {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			
			return BitmapData(new ClassRef(0, 0));
		}
		public static function getBitmap(className:String, pixelSnapping:String = "auto", smoothing:Boolean = true):Bitmap {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			return new Bitmap(BitmapData(new ClassRef(0, 0)), pixelSnapping, smoothing);
		}
		public static function getSprite(className:String):Sprite {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			return Sprite(new ClassRef());
		}
		public static function getMovieClip(className:String):MovieClip {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			return MovieClip(new ClassRef());
		}
		public static function getSound(className:String):Sound {
			var ClassRef:Class = getDefinitionByName(className) as Class;
			return Sound(new ClassRef());
		}
	}
}
