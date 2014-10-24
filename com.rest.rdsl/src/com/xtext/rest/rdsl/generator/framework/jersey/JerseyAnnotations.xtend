package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.restDsl.SingleResource

class CustomAnnotations {
	val SingleResource resource;
	val IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa, SingleResource resource) {
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
		val CustomJerseyFilter filter = new CustomJerseyFilter(fsa, resource);
		filter.generateFilter();
		}	
}