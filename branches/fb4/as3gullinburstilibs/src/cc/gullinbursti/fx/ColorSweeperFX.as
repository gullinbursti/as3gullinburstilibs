package cc.gullinbursti.fx {
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.CurveModifiers;
	
	import com.gskinner.geom.ColorMatrix;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	
	public class ColorSweeperFX {
		
		public  var currHue_val:Number;
		
		
		private var isFullSweep:Boolean;
		private var lLimit:Number;
		private var uLimit:Number;
		private var range:Number;
		private var dist_tot:Number;
		
		private var speed:Number;
		private var rate:Number;
		private var transType:String;
		
		private var dir:int;
		private var tween_state:String;
		private var dur:Number;
		private var toHue_val:Number
		
		private var colr_mtx:ColorMatrix;
		private var evt_sprite:Sprite;
		
		public static const MIN_VAL:Number = -180;
		public static const MAX_VAL:Number = 180;
		public static const MAX_RANGE:Number = 360;
		
		public static const INIT_2_UPPER:String = "INIT_2_UPPER";
		public static const INIT_2_LOWER:String = "INIT_2_LOWER";
		public static const LOWER_2_UPPER:String = "LOWER_2_UPPER";
		public static const UPPER_2_LOWER:String = "UPPER_2_LOWER";
		
		
		public function ColorSweeperFX (
			initPos:Number=0, 
			dir:int=1, 
			minPos:Number=-180, 
			maxPos:Number=180, 
			dur_tot:Number=30, 
			trans_str:String="linear"
		) {
			
			// adds _beizer prop to tweener
			CurveModifiers.init();
			
			// tween params
			currHue_val = initPos;
			lLimit = minPos;
			uLimit = maxPos;
			range = uLimit - lLimit;
			speed = dur_tot;
			transType = trans_str;
			
			
			// 1 = incrementing; -1 = decrementing
			if (dir == 1)
				tween_state = INIT_2_UPPER;
				
			else
				tween_state = INIT_2_LOWER;
			
			// full hue sweep
			if (lLimit == MIN_VAL && uLimit == MAX_VAL)
				isFullSweep = true;
			
			// oscillate between lower & upper limits
			else
				isFullSweep = false;
				
			
			// total round trip distance
			dist_tot = (uLimit - currHue_val) + (currHue_val - lLimit);
			
			// rate value changes per update
			rate = speed / dist_tot;
			
			// dummy sprite to add events on
			evt_sprite = new Sprite();
		}
		
		public function commence():void {
			
			// color matrix
			colr_mtx = new ColorMatrix();
			colr_mtx.adjustHue(currHue_val);
			
			// start full hue sweep (MIN VAL -> MAX VAL)
			if (isFullSweep)
				initFullHueSweep();
			
			// just go from start -> upper limit
			else {
				toHue_val = uLimit - currHue_val;
				
				this.calcDuration();
				this.tweenHueTo();
			}
		}
		
		public function returnFilterFX():ColorMatrixFilter {
			return (new ColorMatrixFilter(colr_mtx));
		}
		
		
		private function initFullHueSweep():void {
			
			// choose a direction
			switch (tween_state) {
				
				// increment val -> max val
				case INIT_2_UPPER:
					toHue_val = MAX_VAL;
					this.calcDuration();
					break;
				
				// decrement val -> min val
				case INIT_2_LOWER:
					toHue_val = MIN_VAL;
					this.calcDuration();
					break;
			}
			
			// dbl the 1st tween's duration
			dur *= 2;
			
			// tween complete listener
			evt_sprite.addEventListener(Event.COMPLETE, hdlTweenComplete);
			
			// start tweening
			this.tweenHueTo();
		}
		
		private function tweenHueTo():void {
			
			// tween the hue val
			Tweener.addTween(this, {
                currHue_val:toHue_val, 
                
                time:dur,
                transition:transType, 
                
                /*
                _bezier:[{
                	currHue_val:
                }]
                */
                
                // update the color matrix w/ tweening hue val
                onUpdate:function():void {
                	this.updColorMatrix();
                },
                
                // dispatch 'COMPLETE' event
                onComplete:function():void {
                	evt_sprite.dispatchEvent(new Event(Event.COMPLETE));
                }
            });
		}
		
		private function hdlTweenComplete(e:Event=null):void {
				
			// change the tween params
			this.changeState();
			
			// start the next tween
			this.tweenHueTo();
		}
		
		//private function updColorMatrix(val:Number=Math.PI):void {
		private function updColorMatrix(val:Number=3.141592653589793236):void {
			
			if (val != Math.PI)
				currHue_val = val;
			
			colr_mtx = new ColorMatrix();
			colr_mtx.adjustHue(currHue_val);
			
			//reduce +/-180 limit to 100
			var base_scaler:Number = Math.abs(currHue_val / 1.8);
			
			// color attrib scalers
			var satur_scaler:Number = base_scaler / 8;
			var brite_scaler:Number = -base_scaler / 5;
			var contr_scaler:Number = Math.abs(base_scaler / 10);
			
			// increment / decrement
			satur_scaler += 0x0f;
			brite_scaler -= ((brite_scaler / 3) * -1);
			
			//trace (currHue_val,(satur_scaler));
			
			// apply to matrix
			colr_mtx.adjustSaturation(satur_scaler);
			colr_mtx.adjustBrightness(brite_scaler);
			colr_mtx.adjustContrast(contr_scaler);
		}
		
		private function changeState():void {
			
			// choose a state
			switch(tween_state) {
				
				// from start -> upper limit
				case INIT_2_UPPER:
				
					// is a full hue sweep: hue val = MIN VAL
					if (isFullSweep) {
						
						tween_state = LOWER_2_UPPER;
						
						// current val = MIN VAL
						currHue_val = MIN_VAL;
						
						// tween to MAX VAL
						toHue_val = MAX_VAL;
					
					// reached upper limit; state = upper -> lower
					} else {
						tween_state = UPPER_2_LOWER;
						
						// distance (upper - range)
						toHue_val = uLimit - range;
					}
						
					break;
				
				// from lower -> upper (incrementing)
				case LOWER_2_UPPER:
					
					// is a full hue sweep 
					if (isFullSweep) {
						
						//current hue val = MIN VAL
						currHue_val = MIN_VAL;
						
						// tween to MAX VAL
						toHue_val = MAX_VAL;
						
						// 
						tween_state = LOWER_2_UPPER;
						
						
					// reached upper limit
					} else {
						tween_state = UPPER_2_LOWER;
						
						// tween to (upper limit - range)
						toHue_val = uLimit - range;
					}
					
					break;
					
				// from upper -> lower (decrementing)
				case UPPER_2_LOWER:
				
					// reverse direction
					tween_state = LOWER_2_UPPER;
					
					// distance (upper - range)
					toHue_val = lLimit + range;
					
					break;
			}
			
			// duration for next tween
			this.calcDuration();
			
			//trace("<<[changeState]>> ["+tween_state+"]>> currHue_val:["+currHue_val+"] toHue_val:["+toHue_val+"] dur:["+dur+"]");
		}
		
		private function calcDuration():void {
			dur = Math.abs(toHue_val - currHue_val) * rate;
		}
	}
}