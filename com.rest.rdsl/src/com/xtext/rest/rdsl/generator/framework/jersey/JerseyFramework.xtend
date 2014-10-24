package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.jersey.JAXBResolverContent
import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyBaseContextResolver
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator
import com.xtext.rest.rdsl.generator.RESTResourceObjects

class JerseyFramework implements IRESTFramework {
	
	val IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa) {
		this.fsa = fsa;
	}
	
	override generateResources(RESTResourceObjects resourceCol) {
		val IResourceGenerator generator = new JerseyResourceGenerator();
		
		for(r: resourceCol.getSingleResources){
			fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/" + r.name + "Resource" + Constants.JAVA, generator.generate(resourceCol, r))
		}
	}
	
	override generateMisc(RESTResourceObjects resourceCol) {
		val IResolverContent jaxb = new JAXBResolverContent(fsa, resourceCol.getSingleResources);
		val IResolverContent genson = new GensonResolverContent(fsa, resourceCol.getSingleResources);
		
		val JerseyBaseContextResolver gensonResolver = new JerseyBaseContextResolver(fsa, genson);
		gensonResolver.generateResolver();  //Mapper to customize JSON or XML output
		val JerseyBaseContextResolver jaxbResolver = new JerseyBaseContextResolver(fsa, jaxb);
		//jaxbResolver.generateResolver();
		
		val CustomAnnotations annons = new CustomAnnotations(fsa, resourceCol.getUserResource);
		annons.generateAuth();
		annons.generatePATCH();
	}
	
}