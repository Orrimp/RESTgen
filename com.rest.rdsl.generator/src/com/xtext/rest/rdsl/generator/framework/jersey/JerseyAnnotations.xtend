package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.restDsl.Configuration
import com.xtext.rest.rdsl.restDsl.ResourceType
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class CustomAnnotations {
	val ResourceType resource;
	val Configuration config;
	val IFileSystemAccess fsa;
	
	new(Configuration config, IFileSystemAccess fsa, ResourceType resource) {
		this.config = config;
		this.fsa = fsa;
		this.resource = resource;
	
	}
	
	def generatePATCH() {
		fsa.generateFile(Naming.ANNO_PATCH.generationLocation +  Constants.JAVA,
		'''
		package «PackageManager.frameworkPackage»;
		
		«FOR imp: Naming.ANNO_PATCH.baseImports»
		import «imp»;
		«ENDFOR»
		
		import javax.ws.rs.HttpMethod;
		
		@NameBinding
		@Target( { ElementType.TYPE, ElementType.METHOD } )
		@Retention( value = RetentionPolicy.RUNTIME )
		@HttpMethod("PATCH") 
		public @interface «Naming.ANNO_PATCH»
		{}
		'''
		)
	}
	
	def generateAuth() {
		fsa.generateFile(Naming.ANNO_USER_AUTH.generationLocation + Constants.JAVA,
		'''
		package «PackageManager.authPackage»;

		«FOR imp: Naming.ANNO_USER_AUTH.baseImports»
		import «imp»;
		«ENDFOR»
		
		@NameBinding
		@Target( { ElementType.TYPE, ElementType.METHOD } )
		@Retention( value = RetentionPolicy.RUNTIME )
		public @interface «Naming.ANNO_USER_AUTH»
		{}
		
		'''
		);
		val CustomJerseyFilter filter = new CustomJerseyFilter(config, fsa, resource);
		filter.generateFilter();
		}	
}