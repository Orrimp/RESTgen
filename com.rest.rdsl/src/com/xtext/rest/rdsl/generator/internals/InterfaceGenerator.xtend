package com.xtext.rest.rdsl.generator.internals

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.RESTResourceObjects

public class InterfaceGenerator {
	
	private val RESTResourceObjects resources
	private var IFileSystemAccess fsa
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	new(IFileSystemAccess fsa, RESTResourceObjects resources) {
		this.fsa = fsa;
		this.resources = resources;
	}
	
	def generateID(){
		fsa.generateFile( Naming.INTERFACE_ID.generationLocation + Constants.JAVA, 
	'''
	package «PackageManager.interfacePackage»;
	
	public interface «Naming.INTERFACE_ID»{
		public «resources.globalTraits.idtype.literal.toFirstUpper» generateID();
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