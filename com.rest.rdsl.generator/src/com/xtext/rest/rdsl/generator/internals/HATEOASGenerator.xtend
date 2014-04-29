package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class HATEOASGenerator {
	private var IFileSystemAccess fsa
	
	new(IFileSystemAccess fsa) {
		this.fsa = fsa;
	}

	def generate(String generationPackage) {
	fsa.generateFile(Naming.CLASS_LINK.generationLocation + Constants.JAVA, 
	'''	
	package «Naming.CLASS_LINK.packageName»;
		
	import java.net.URI;
	
	public class «Naming.CLASS_LINK» {
		
		private String type;
		private URI uri;
		
		public «Naming.CLASS_LINK»(){}
		
		public «Naming.CLASS_LINK»(String type, String uri){
			this.type = type;
			this.uri = URI.create(uri);
		}	
		
		public «Naming.CLASS_LINK»(String type, URI uri){
			this.type = type;
			this.uri = uri;
		}
		
		public String getType(){
			return this.type;
		}
		
		public URI getURI(){
			return this.uri;	
		}
	}
	''')
	}
}