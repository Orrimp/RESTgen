package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent
import com.xtext.rest.rdsl.management.PackageManager

class JerseyBaseContextResolver {

	val IFileSystemAccess fsa;
	val IResolverContent resolver;
	
	new(IFileSystemAccess fsa, IResolverContent resolver) {
			this.fsa = fsa;
			this.resolver = resolver;
	}
	
	def generateResolver(){

		fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/"  + resolver.getClassName + Constants.JAVA,
		'''
		package «PackageManager.resourcePackage»;
		
		import javax.ws.rs.ext.Provider;
		import javax.ws.rs.ext.ContextResolver;

		«resolver.getImports»
				
		@Provider
		public class «resolver.getClassName» implements ContextResolver<«resolver.getName»> {
			
			«resolver.getClassVariables»
			
		    public  «resolver.getClassName»() throws Exception {
		    	«resolver.getConstructor»
		    }
		    
		    @Override
		    public «resolver.getName» getContext(Class<?> objectType) {
		        «resolver.getContextMethod»
		    }
		}
			'''
		)
	}
}