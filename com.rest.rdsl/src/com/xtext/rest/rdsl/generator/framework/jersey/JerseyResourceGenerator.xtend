package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import java.util.HashSet
import java.util.Set
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator

class JerseyResourceGenerator implements IResourceGenerator {
			
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	/*
	 * Generate the class which represents a REST resource. 
	 */
	override generate(RESTResource resource, RESTConfiguration config) {
	
	// Analyse the use attributes to import them if necessary 
	// by extracting the full qaualifed name and addting import later.
	val Set<String> attributeImports = new HashSet<String>()
	for(Attribute attrib: resource.attributes){
		if(attrib.value instanceof JavaReference){
			attributeImports.add(attrib.value.nameOfType);
		}
	}
		
	'''
	package «PackageManager.resourcePackage»;
	 
	«««Write all the Jersey relevant and used imports
	«FOR imp: Naming.FRAMEWORK_JERSEY.baseImports»
	import «imp»;
	«ENDFOR»
	import «PackageManager.interfacePackage».*;
	import «PackageManager.objectPackage».*;
	import «PackageManager.exceptionPackage».*;
	import «Naming.ANNO_USER_AUTH.classImport»;
	import «Naming.CLASS_ID.classImport»;
	import «Naming.INTERFACE_ID.classImport»;	
	import «Naming.ABSTRACT_CLASS_DAO.classImport»;
	import «Naming.ANNO_PATCH.classImport»;
	import «Naming.CLASS_DB_QUERY.classImport»;
	import javax.ws.rs.QueryParam;
	import javax.ws.rs.core.Response.ResponseBuilder;
	import javax.ws.rs.core.EntityTag;
	«««Import the attirubtes classes
	«FOR imp: attributeImports»
	import «imp»;
	«ENDFOR»
	
	import java.net.URI;
	import java.util.List;
	import java.util.Date;

	«««Create a URI path from the resource name and declare base class
		 
	@Path("/«resource.name.toLowerCase»")
	public class «resource.name»Resource  extends «Naming.CLASS_ABSTRACT_RESOURCE»{

	««« Create the used Framework and generate all the base methods
	
		«var mGen = new JerseyMethodGenerator(config, resource)»
		«mGen.generateGET()»
		«mGen.generateDELETE»
		«mGen.generatePOST()»
		«mGen.generatePUT()»
		«mGen.generatePATCH()»
		«mGen.generateQuery()»
	««« Custom methods for List elements
		«FOR attribute: resource.attributes»
		
			«IF attribute.value instanceof ListReference»
				«mGen.generateQuery(attribute)»
		 	«ELSE»
				«mGen.generate(attribute)»
		 	«ENDIF»
		 «ENDFOR»
	} 	
	'''
	}
}	