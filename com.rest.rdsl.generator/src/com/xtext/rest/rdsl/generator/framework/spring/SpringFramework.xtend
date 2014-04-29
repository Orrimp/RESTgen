package com.xtext.rest.rdsl.generator.framework.spring

import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator

class SpringFramework implements IRESTFramework {
	
	val IFileSystemAccess fsa;
	val RESTConfiguration config
	
	new(IFileSystemAccess fsa, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	override generateResources(RESTResourceCollection resourceCol) {
		val IResourceGenerator generator = new SpringResourceGenerator()	
		for(r: resourceCol.getResources){
			fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/" + r.name + "Resource" + Constants.JAVA, generator.generate(r, config))
		}	
	}
	
	override generateMisc(RESTResourceCollection resourceCol) {
		
	}
	
}