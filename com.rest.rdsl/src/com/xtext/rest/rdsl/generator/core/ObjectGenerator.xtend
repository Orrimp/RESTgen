package com.xtext.rest.rdsl.generator.core

import com.xtext.rest.rdsl.generator.RESTResourceObjects
import com.xtext.rest.rdsl.generator.internals.AnnotationUtils
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.ResourceReference
import java.util.ArrayList
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTState

///Erweitern indem ein VaterObjekt extrahiert wird mit Hyperlinks und ID
class ObjectGenerator {
	
	extension ExtensionMethods e = new ExtensionMethods();
	val ObjectParentGenerator parent;
	val AnnotationUtils anno;
	val ArrayList<String> imports = new ArrayList<String>();
	val RESTResourceObjects resources
	
	
	new(RESTResourceObjects resources, AnnotationUtils anno, ObjectParentGenerator parent) {
		this.anno = anno;	
		this.parent	= parent;
		this.resources = resources;
	}
	
	def generate(String packageName, RESTState resource){	
		imports.add("java.util.ArrayList");
		imports.add("java.util.List");
		imports.add("java.lang.String");
		imports.add(Naming.CLASS_LINK.classImport);
		imports.addAll(anno.annoImports);
		imports.add(Naming.CLASS_OBJPARENT.classImport);

	var String idDataType = resources.globalTraits.idtype.literal;
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
		«anno.fieldAnno»
		private String selfLink; 
	
		«anno.constrAnno»
		public «resource.name»(){}

		«FOR attribute: resource.resources.get(0).attributes»	
				
		«anno.fieldAnno»
		private «attribute.value.nameOfType» «attribute.name.toFirstLower»;
		
		«anno.getGetMethodAnno»
		public «attribute.value.nameOfType» get«attribute.name.toFirstUpper»(){
			return this.«attribute.name.toFirstLower»;
		}
		
		«anno.getSetMethodAnno»
		public void set«attribute.name.toFirstUpper»(«attribute.value.nameOfType» «attribute.name.toFirstLower»){
			this.«attribute.name.toFirstLower» = «attribute.name.toFirstLower»;
			«IF attribute.value instanceof ResourceReference»
			«ENDIF» 
		}
		«ENDFOR»
			
		@Override
		public String toString(){
			
			return "«resource.name»";
		}
	}
	'''
	}
	
	def generateCollectionsObjects(RESTState resource){
		
		'''
		package «PackageManager.getObjectPackage»;
		 
		import java.util.List;
		import java.util.ArrayList;
		import com.owlike.genson.annotation.JsonIgnore;
		 
		public class «resource.name.toFirstUpper»
		{
			private List<«resource.traits.name.toFirstUpper»> «resource.name.toLowerCase»;
		 
			public «resource.name.toFirstUpper»( )
			{
				this.«resource.name.toLowerCase» = new ArrayList<«resource.traits.name.toFirstUpper»>( );
			}
		 
		 	@JsonIgnore
			public List<«resource.traits.name.toFirstUpper»> get«resource.name.toFirstUpper»( )
			{
				return «resource.name.toLowerCase»;
			}
		 
			public void add«resource.name.toFirstUpper»( «resource.traits.name.toFirstUpper» «resource.traits.name.toLowerCase» )
			{
				this.«resource.name.toLowerCase».add( «resource.traits.name.toLowerCase» );
			}
		
		}
		
		'''
	}
}