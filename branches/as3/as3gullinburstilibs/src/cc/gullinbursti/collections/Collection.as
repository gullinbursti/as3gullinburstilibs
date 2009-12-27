package cc.gullinbursti.collections {
	
	import cc.gullinbursti.iterators.AscendIterator;
	import cc.gullinbursti.iterators.DescendIterator;
	import cc.gullinbursti.iterators.IIterator;
	import cc.gullinbursti.iterators.RandIterator;

	public class Collection implements ICollection {
		
		public static const ASCENDING_ITERATOR    :String = "ASCENDING_ITERATOR";
		public static const DECENDING_ITERATOR    :String = "DECENDING_ITERATOR";
		public static const RANDOM_ITERATOR       :String = "RANDOM_ITERATOR";
		
		private var data:Array;
		
		public function Collection() {
			data = new Array();
		}

		public function reverse():void {
			data = data.reverse();
		}
		
		
		public function iterator( iterType:String="" ):IIterator {
			
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
			
		}
		
		public function addElement(value:*):void {
			data.push(value);
		}
		
		public function removeElement(val:*):void {
			if( hasElement( val )) { 
			    data.splice( data.indexOf( val ), 1 );
			}
		}
		
        public function hasElement(val:*):Boolean {
        	return data.indexOf( val ) > -1;
        }
		
		public function length():int {
			return data.length;
		}
		
		public function clone():Collection {
			
			var clonedCollection:Collection = new Collection();
			var ascendIterator:IIterator = this.iterator(Collection.ASCENDING_ITERATOR);
			
			while (ascendIterator.hasNext())
				clonedCollection.addElement(ascendIterator.next());
			
			
			return (clonedCollection);
			
		}
	}
}