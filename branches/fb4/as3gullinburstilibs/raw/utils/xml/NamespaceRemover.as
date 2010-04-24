package utils.xml {

	/**
	 * @author Mathias
	 */
	public class NamespaceRemover {
		
		public static function remove(a_xml : XML) : XML {
//			var attr:String = getAttributes(a_xml.@*);
			var theXML:XML = new XML("<"+a_xml.localName()+"></"+a_xml.localName()+">");
			if(a_xml.elements().length() > 0){
				var a:Number;
				for(a=0;a<a_xml.elements().length();a++){
					var nsRemoved:XML = remove(a_xml.elements()[a]);
					nsRemoved.setNamespace(""); // EDIT BY SVANTE 2009-02-19
					theXML.appendChild(nsRemoved);
				}
			} else {
				theXML = a_xml;
			}
			return theXML;
		}
		
//		private static function getAttributes(attr:XMLList):String{
//			var attrString:String = " ";
//			if(attr.length() == 0){
//				return attrString;
//			}
//			var b:Number;
//			for(b=0;b<attr.length();b++){
//				attrString += attr[b].localName()+"='"+attr[0]+"' ";
//			}
//			return attrString;
//		}	
	}
}
