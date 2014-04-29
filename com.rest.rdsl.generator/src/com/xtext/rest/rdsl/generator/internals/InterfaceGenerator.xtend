package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants

public class InterfaceGenerator {
	
	private var IFileSystemAccess fsa
	private var RESTConfiguration config
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	new(IFileSystemAccess fsa, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	def generateID(){
		fsa.generateFile( Naming.INTERFACE_ID.generationLocation + Constants.JAVA, 
	'''
	package «PackageManager.interfacePackage»;
	
	public interface «Naming.INTERFACE_ID»{
		public «config.IDDataTyp» generateID();
	}
	
	''');
	}
	
	def generateDecoder(){
		fsa.generateFile(Naming.INTERFACE_AUTH_DECODER.generationLocation + Constants.JAVA,
		'''
		package «PackageManager.interfacePackage»;

		public interface «Naming.INTERFACE_AUTH_DECODER» {

			String[] decode(String header);
			
		}
		
	''');
	}
}