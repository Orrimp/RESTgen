package com.xtext.rest.rdsl.generator.framework.spring

import com.xtext.rest.rdsl.generator.ResourceTypeCollection
import com.xtext.rest.rdsl.restDsl.Configuration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator

class SpringFramework implements IRESTFramework {
	
	val IFileSystemAccess fsa;
	val Configuration config
	
	new(IFileSystemAccess fsa, Configuration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	override generateResources(ResourceTypeCollection resourceCol) {
		val IResourceGenerator generator = new SpringResourceGenerator()	
		for(r: resourceCol.getResources){
			fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/" + r.name + "Resource" + Constants.JAVA, generator.generate(r, config))
		}	
	}
	
	override generateMisc(ResourceTypeCollection resourceCol) {
		
	}
	
}