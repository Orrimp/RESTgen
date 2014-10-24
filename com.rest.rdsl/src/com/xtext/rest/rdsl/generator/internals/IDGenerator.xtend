package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.restDsl.ID_GEN
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.generator.RESTResourceObjects

public class IDGenerator {
	
	val IFileSystemAccess fsa;
	val RESTResourceObjects resources
	
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	
	public new(IFileSystemAccess access, RESTResourceObjects resources){
		this.fsa = fsa;
		this.resources = resources;
	}
	
	public def generateID(){
		fsa.generateFile(Naming.CLASS_ID.generationLocation + Constants.JAVA, compile())
	}
	
	def compile() {
		switch(resources.globalTraits.idtype){
		case ID_GEN.LONG: return generateLONGClass()
		case ID_GEN.UUID: return generateUUIDClass()
		}
	}
	
	def generateLONGClass() '''
		package «Naming.CLASS_ID.packageName»;
		
		import «Naming.INTERFACE_ID.classImport»;
		
		public class «Naming.CLASS_ID» implements «Naming.INTERFACE_ID»{
			private  long counter = «Constants.LONG_COUTNER_VALUE»;  
			private static «Naming.CLASS_ID» instance = null;
			
			private «Naming.CLASS_ID»(){}
			
			public synchronized static «Naming.CLASS_ID» getInstance(){
				if(instance == null){
					instance = new «Naming.CLASS_ID»();
				}
			
				return instance;
			}
			
			public synchronized Long generateID(){
				return counter++;
			}
		}
	'''
	
	private def generateUUIDClass()'''
	package «Naming.CLASS_ID.packageName»;
	
	import «PackageManager.interfacePackage».«Naming.INTERFACE_ID»;
	import java.util.UUID;
	
	public class «Naming.CLASS_ID» implements «Naming.INTERFACE_ID»{
		
		public String generateID(){
			return UUID.randomUUID().toString();
		}
	}
	'''
		
	
}