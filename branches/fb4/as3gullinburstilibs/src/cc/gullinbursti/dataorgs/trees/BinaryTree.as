package cc.gullinbursti.dataorgs.trees {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	import cc.gullinbursti.math.BasicMath;
	import cc.gullinbursti.searching.BasicSearching;
	import cc.gullinbursti.searching.ISearcher;
	import cc.gullinbursti.lang.Arrays;

	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class BinaryTree extends AbstractTree implements ISearcher {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		// TODO: apply bin search props to this static class
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		/**
		 * 
		 */
		// <*] class constructor [*>
		public function BinaryTree() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~.
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		/**
		 * 
		 * @param val_obj val_obj pattern / data to find
		 * @return whether or not the tree has the value obj
		 * 
		 */		
		override public function isContaining(val_obj:Object):Boolean {
			return (super.isContaining(val_obj));
		}
		
		
		
		/**
		 * 
		 * @param val_obj pattern / data to find
		 * @return the index of the data, -1 if not found
		 * 
		 */		
		override public function locatedAtInd(val_obj:Object):int {
			return (super.locatedAtInd(val_obj));
		}
	}
}