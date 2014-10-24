package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import java.util.List
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.SingleResource

class JAXBResolverContent implements IResolverContent{
	
	val List<SingleResource> resources;
	
	new(IFileSystemAccess fsa, List<SingleResource> resources) {
		this.resources = resources;
	}
	
	
	override CharSequence getConstructor(){
		'''
		@SuppressWarnings("rawtypes")
		Class[] typesArr = new Class[]{«FOR r: resources SEPARATOR ", "» «r.name.toFirstUpper + ".class"» «ENDFOR»};
		JSONConfiguration.MappedBuilder b = JSONConfiguration.mapped();
		b.rootUnwrapping(false);											//Add class name to the JSON OBject. 
		context = new JSONJAXBContext(b.build(), typesArr); //TODO change

		'''
	}
	
	override CharSequence getName(){
		return "JAXBContext";
	}
	
	override CharSequence getClassName(){
		return Naming.JAXB_RESOLVER.className;
	}
	
	override getImports() {
		'''
		
		import javax.xml.bind.JAXBContext;
		
		import com.sun.jersey.api.json.JSONConfiguration;
		import com.sun.jersey.api.json.JSONJAXBContext;
		import java.lang.Exception;
		
		
		«FOR r: resources»
		import «PackageManager.objectPackage».«r.name.toFirstUpper»;
		«ENDFOR»
		'''
	}
	
	override getClassVariables() {
		'''
		private «getName» context;
		'''
	}
	
	override getContextMethod() {
		'''
		return context;
		'''		
	}
	
}