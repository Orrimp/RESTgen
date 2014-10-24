package com.xtext.rest.rdsl.generator.framework.spring

import com.xtext.rest.rdsl.generator.RESTResourceObjects
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import org.eclipse.xtext.generator.IFileSystemAccess

class SpringFramework implements IRESTFramework {
	
	val IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa) {
		this.fsa = fsa;
	}
	
	override generateResources(RESTResourceObjects resourceCol) {
//		val IResourceGenerator generator = new SpringResourceGenerator()	
//		for(r: resourceCol.getSingleResources){
//			fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/" + r.name + "Resource" + Constants.JAVA, generator.generate(r))
//		}	
	}
	
	override generateMisc(RESTResourceObjects resourceCol) {
		
	}
	
}