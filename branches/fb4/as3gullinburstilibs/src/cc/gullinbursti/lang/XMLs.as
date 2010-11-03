package cc.gullinbursti.lang {


	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	 
	// <[!] class delaration [¡]>
	public class XMLs extends Strings {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function XMLs() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
		
		
		
		public static function stripNamespace(in_xml:XML):XML {
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
			
			var out_xml:XML = new XML("<" + in_xml.localName()+"></" + in_xml.localName() + ">");
			
			if (in_xml.elements().length() > 0){
				
				for (var i:int=0; i<in_xml.elements().length(); i++) {	
					var nsRemoved:XML = stripNamespace(in_xml.elements()[i]);
						nsRemoved.setNamespace("");
					
					out_xml.appendChild(nsRemoved);
				}
				
			} else
				return (in_xml);
			
			
			return (out_xml);
		}//]~*~~*~~*~~*~~*~~*~~*~~*~~·¯	
	}
}
