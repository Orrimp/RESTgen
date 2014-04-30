package com.xtext.rest.rdsl.generator.core

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.restDsl.Configuration
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

/**
 * Implementation of a parent for every object generated in this project. 
 */
class ObjectParentGenerator {
	
	val IFileSystemAccess fsa;
	val Configuration config;
	extension ExtensionMethods e = new ExtensionMethods();
	
	new (IFileSystemAccess fsa, Configuration config){
		this.fsa = fsa;
		this.config = config;
	}
	
	/**
	 * The extension type can be implements or extends depending on the choosen implementation. 
	 */
	def getExtensionType(){
		return "implements";
	}
	
	/**
	 * Generates the object parent class with all its methods and attributes.
	 */
	def generate(String packageName){
		fsa.generateFile(Naming.CLASS_OBJPARENT.generationLocation + Constants.JAVA,
		'''
		package «packageName»;
		
		import java.util.List;
		
		public interface «Naming.CLASS_OBJPARENT» {
		
			public «config.IDDataTyp» getID();
			public String getSelfURI();
			public List<«Naming.CLASS_LINK.className»> getLinks();
		}
		'''
		)
	}
	
}