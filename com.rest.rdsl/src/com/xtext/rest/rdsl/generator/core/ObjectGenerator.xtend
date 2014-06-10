package com.xtext.rest.rdsl.generator.core

import com.xtext.rest.rdsl.generator.internals.AnnotationUtils
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import com.xtext.rest.rdsl.restDsl.ResourceReference
import java.util.ArrayList

///Erweitern indem ein VaterObjekt extrahiert wird mit Hyperlinks und ID
class ObjectGenerator {
	
	extension ExtensionMethods e = new ExtensionMethods();
	val RESTResource resource;
	val RESTConfiguration config;
	val ObjectParentGenerator parent;
	val AnnotationUtils anno;
	val ArrayList<String> imports = new ArrayList<String>();
	
	
	new(RESTResource resource, RESTConfiguration config, AnnotationUtils anno, ObjectParentGenerator parent) {
		this.resource = resource;
		this.config = config;
		this.anno = anno;	
		this.parent	= parent;
	}
	
	def generate(String packageName){	
		
		imports.add("java.util.ArrayList");
		imports.add("java.util.List");
		imports.add(Naming.CLASS_LINK.classImport);
		imports.addAll(anno.annoImports);
		imports.add(Naming.CLASS_OBJPARENT.classImport);
		for(attrib: resource.attributes)
		{
			if((attrib.value instanceof JavaReference) && !imports.contains((attrib.value as JavaReference).fullNameOfType))
				imports.add((attrib.value as JavaReference).fullNameOfType);
		}
	
	var String idDataType = config.IDDataTyp;
	
	'''
	package «packageName»;
	
	«FOR imp : imports»
	import «imp»;
	«ENDFOR»
	
	«anno.classAnno»
	public class «resource.name.toFirstUpper» «parent.extensionType» «Naming.CLASS_OBJPARENT.className»{
	
		«anno.fieldAnno»
		private List<«Naming.CLASS_LINK»> hyperlinks = new ArrayList<«Naming.CLASS_LINK»>();
		«anno.fieldAnno»
		private «idDataType» id;
		«anno.fieldAnno»
		private String selfLink; 
	
		«anno.constrAnno»
		public «resource.name»(){}
		
		«anno.constrAnno»
		public «resource.name»(«idDataType» id){
			this();
			this.id = id;
			resetLinks();
		}
		
		«anno.getGetMethodAnno»
		public «idDataType» getID(){
			return this.id;
		}
		
		«anno.getSetMethodAnno()»
		public void setID(«idDataType» id){
			this.id = id;
			resetLinks();
		}
		

		«FOR attribute: resource.attributes»	
				
		«anno.fieldAnno»
		private «attribute.value.nameOfType»«putExtra(attribute)» «attribute.name.toFirstLower»;
		
		«anno.getGetMethodAnno»
		public «attribute.value.nameOfType»«putExtra(attribute)» get«attribute.name.toFirstUpper»(){
			return this.«attribute.name.toFirstLower»;
		}
		
		«anno.getSetMethodAnno»
		public void set«attribute.name.toFirstUpper»(«attribute.value.nameOfType»«putExtra(attribute)» «attribute.name.toFirstLower»){
			this.«attribute.name.toFirstLower» = «attribute.name.toFirstLower»;
			«IF attribute.value instanceof ResourceReference»
			resetLinks();
			«ENDIF» 
		}
		«ENDFOR»
		
		public void resetLinks(){
			this.hyperlinks.clear();
			selfLink = "«config.basePath»/«resource.name.toLowerCase»/" + this.id;
			this.hyperlinks.add(new «Naming.CLASS_LINK»("self", selfLink));
		«FOR attribute: resource.attributes»
			«IF attribute.value instanceof ResourceReference && resource.name != (attribute.value as ResourceReference).resourceRef.name»
				if(«attribute.name»  != null)
				this.hyperlinks.add(new «Naming.CLASS_LINK»("rel", "«config.basePath»/«(attribute.value as ResourceReference).resourceRef.name.toLowerCase»" + "/" + «attribute.name».getID()));
			«ENDIF»
		«ENDFOR»
		}
		
		public String getSelfURI(){
			return selfLink;
		}
		
		public List<«Naming.CLASS_LINK»> getLinks(){
			return this.hyperlinks;
		}
		
		public void addLink(String type, String uri){
			this.hyperlinks.add(new «Naming.CLASS_LINK»(type, uri));
		}
		
		@Override
		public String toString(){
			
			return "«resource.name»";
		}
	}
	'''
	}

	
	private def String putExtra(Attribute attribute){
		if( attribute.value instanceof ListReference)
			return  "<" + (attribute.value as ListReference).innerType + ">"
		else
			return ""
	}
}