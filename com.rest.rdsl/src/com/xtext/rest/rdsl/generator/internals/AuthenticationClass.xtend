package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.restDsl.HTTPBasic
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming

/**
 * Thsi class is for storing all the authorization and authentication information given by the client. 
 */
class AuthenticationClass {
	
	var RESTConfiguration config = null;
	var IFileSystemAccess fsa  = null;
		
	new(RESTConfiguration config, IFileSystemAccess fsa) {
		this.config = config;
		this.fsa = fsa;
	
	}
	
	/**
	 * Generates the class which stores an process the authentication information from client.
	 */
	def generate() {
		val className = Naming.CLASS_USER_AUTH_DATA;
			 fsa.generateFile(Naming.CLASS_USER_AUTH_DATA.generationLocation + Constants.JAVA,
	'''
	package «PackageManager.authPackage»;
	 
	import org.glassfish.jersey.internal.util.Base64;
	import «PackageManager.interfacePackage».«Naming.INTERFACE_AUTH_DECODER»;
	 
	/**
	* This class stores the authentication information extracted from the header.
	«IF config.auth instanceof HTTPBasic»
	* The header, the username and the password are extracted by default using BASE 64 decoder
	«ELSE»
	* The token, the scope, the user... are extracted by default using BASE 64 decoder
	«ENDIF»	
	* A custom decoder can be used given in the constructor using the interface «Naming.INTERFACE_AUTH_DECODER».
	*/
	public class «className»{
	 
		private String header = "";
	«IF config.auth instanceof HTTPBasic»		
		private String name = "";
		private String passwd = "";
	«ELSE»
		private String token = "";
		private String scope = "";
		private String user = "";
	«ENDIF»	
		public «className»(String header){
			this.header = header;
			decodeHeaderB64(header);
		}
		
		public «className»(String header, «Naming.INTERFACE_AUTH_DECODER» decoder){
			this.header = header;
			decodeHeader(header, decoder);
		}
			
		private void decodeHeaderB64(String header){
		«IF config.auth instanceof HTTPBasic»
		 	final String withoutBasic = header.replaceFirst("[Bb]asic ", "");
			final String userColonPass = Base64.decodeAsString(withoutBasic);
		 	final String [] asArray = userColonPass.split(":");
		 	if(asArray.length == 2){
		 	this.name = asArray[0];
		 	this.passwd = asArray[1];
		}
		«ELSE»
			final String tokenReadable = Base64.decodeAsString(header);
			final String[] asArray = tokenReadable.split(":");
			if(asArray.length == 3){
			this.token = asArray[0];
			this.scope = asArray[1];
			this.user = asArray[2];
		}
			«ENDIF»	
		}
		
		private void decodeHeader(String header, «Naming.INTERFACE_AUTH_DECODER» decoder){
		
			String[] asArray = decoder.decode(header);
			«IF config.auth instanceof HTTPBasic»
			if(asArray.length == 2){
				this.name = asArray[0];
				this.passwd = asArray[1];
			}
			«ELSE»
			if(asArray.length == 3){
				this.token = asArray[0];
				this.scope = asArray[1];
				this.user = asArray[2];
			}
			«ENDIF»	
	 	}
	 }
	 '''
	 );
	}
	
}