package cc.gullinbursti.lang {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class MovieClips extends DisplayObjs {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		// <*] class constructor [*>
		public function MovieClips() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		public static function gotoAndReverse(trg_mc:MovieClip, start:int, rate:Number=24,end:int=1, easing:String="linear"):void {
		// ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._

			start = Math.min(Math.max(1, start), trg_mc.totalFrames);
			end = Math.min(Math.max(1, end), start);
			
			var frame_dist:int = start - end;
			
			Tweener.addCaller(trg_mc, {
				count:frame_dist,
				time:frame_dist / rate,
				ease:easing,
				
				onUpdate:function():void {
					frame_dist--;
					trg_mc.gotoAndStop(end + frame_dist);
				}
			});
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public static function playReverse(trg_mc:MovieClip, rate:Number=24, end:int=1, easing:String="linear"):void {
		// ]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			gotoAndReverse(trg_mc, trg_mc.currentFrame, rate, end, easing);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯		
	}
}
