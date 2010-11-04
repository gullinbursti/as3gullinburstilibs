package cc.gullinbursti.collections {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.iterators.AscendIterator;
	import cc.gullinbursti.iterators.DescendIterator;
	import cc.gullinbursti.iterators.IIterator;
	import cc.gullinbursti.iterators.RandIterator;
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [!]>
	public class Collection implements ICollection {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		public static const ASCENDING_ITERATOR    :String = "ASCENDING_ITERATOR";
		public static const DECENDING_ITERATOR    :String = "DECENDING_ITERATOR";
		public static const RANDOM_ITERATOR       :String = "RANDOM_ITERATOR";
		
		private var data:Array;
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function Collection() {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._	
			data = new Array();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>

		public function reverse():void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			data = data.reverse();
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		
		public function iterator(iterType:String=""):IIterator {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			switch (iterType) {
				
				case DECENDING_ITERATOR:
					return (new DescendIterator(data));
					break;
					
				case RANDOM_ITERATOR:
					return (new RandIterator(data));
					break;
					
				case ASCENDING_ITERATOR:
					return (new AscendIterator(data));
					break;
					
				default:
					return (new AscendIterator(data));
					break;
					
			}
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function addElement(value:*):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			data.push(value);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function removeElement(val:*):void {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			if(hasElement(val))
			    data.splice(data.indexOf(val), 1);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
        public function hasElement(val:*):Boolean {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
        	return (data.indexOf(val) > -1);
        }//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function length():int {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			return (data.length);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
		
		public function clone():Collection {
		//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
			
			var clonedCollection:Collection = new Collection();
			var ascendIterator:IIterator = this.iterator(Collection.ASCENDING_ITERATOR);
			
			while (ascendIterator.hasNext())
				clonedCollection.addElement(ascendIterator.next());
			
			
			return (clonedCollection);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯
	}
}