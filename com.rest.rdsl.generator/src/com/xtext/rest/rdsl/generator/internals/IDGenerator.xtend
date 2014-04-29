package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.restDsl.ID_GEN
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.PackageManager

public class IDGenerator {
	
	val IFileSystemAccess fsa;
	val RESTConfiguration config
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	new(IFileSystemAccess fsa, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	public def generateID(){
		fsa.generateFile(Naming.CLASS_ID.generationLocation + Constants.JAVA, compile(config))
	}
	
	def compile(RESTConfiguration config) {
	
		switch(config.idtype){
		case ID_GEN.LONG: return generateLONGClass(config)
		case ID_GEN.UUID: return generateUUIDClass(config)
		}
	}
	
	def generateLONGClass(RESTConfiguration config) '''
		package «Naming.CLASS_ID.packageName»;
		
		import «Naming.INTERFACE_ID.classImport»;
		
		public class «Naming.CLASS_ID» implements «Naming.INTERFACE_ID»{
			private  long counter = «Constants.LONG_COUTNER_VALUE»;  
			private static «Naming.CLASS_ID» instance = null;
			
			protected «Naming.CLASS_ID»(){}
			
			public synchronized static «Naming.CLASS_ID» getInstantce(){
				if(instance == null){
					instance = new «Naming.CLASS_ID»();
				}
			
				return instance;
			}
			
			public synchronized «config.IDDataTyp» generateID(){
				return counter++;
			}
		}
	'''
	
	private def generateUUIDClass(RESTConfiguration config)'''
	package «Naming.CLASS_ID.packageName»;
	
	import «PackageManager.interfacePackage».«Naming.INTERFACE_ID»;
	import java.util.UUID;
	
	public class «Naming.CLASS_ID» implements «Naming.INTERFACE_ID»{
		
		public «config.IDDataTyp» generateID(){
			return UUID.randomUUID().toString();
		}
	}
	'''
		
	
}