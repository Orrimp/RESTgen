package com.xtext.rest.rdsl.generator.core;

import com.xtext.rest.rdsl.generator.ResourceTypeCollection
import com.xtext.rest.rdsl.generator.internals.ExceptionGenerator
import com.xtext.rest.rdsl.restDsl.FRAMEWORK
import com.xtext.rest.rdsl.restDsl.Configuration
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.internals.IExceptionGenerator
import com.xtext.rest.rdsl.generator.framework.spring.ResourceAbstractSpringGenerator
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyAbstractResourceGenerator
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyFramework
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyExceptionMapperGenerator
import com.xtext.rest.rdsl.generator.framework.IBaseResourceGenerator
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionMapper

class FrameworkManager {
	
	val Configuration config;
	val IFileSystemAccess fsa
	val ResourceTypeCollection resourceCol;
	var IBaseResourceGenerator abstractGenerator;
	var IExceptionGenerator exceptionGenerator
	var IRESTFramework restFramework;
	
	new(IFileSystemAccess fsa, Configuration config, ResourceTypeCollection resourceCol) {
		this.config = config;
		this.fsa = fsa;
		this.resourceCol = resourceCol;
	}
	
	def generate() {
		//Initialize generators for the specified framework.
		//Difference is in resource genrators, exception generators
		switch(config.framework){
			case FRAMEWORK.JERSEY: setJerseyEnviroment() 
			case FRAMEWORK.SPRING: setSpringEnviroment()
		}	
		
		this.restFramework.generateResources(resourceCol);
		this.restFramework.generateMisc(resourceCol);
		
		abstractGenerator.generate(fsa);
		generateExceptions(fsa);
	}
	
	def setJerseyEnviroment(){
		this.abstractGenerator = new JerseyAbstractResourceGenerator()
		this.restFramework = new JerseyFramework(fsa, config);
	}
	
	def setSpringEnviroment(){
		this.abstractGenerator = new ResourceAbstractSpringGenerator()
	}
	
	def generateExceptions(IFileSystemAccess fsa) {
		exceptionGenerator = new ExceptionGenerator(fsa);
		val ExceptionMapper exMapper = new ExceptionMapper(config);
		val JerseyExceptionMapperGenerator eMapperGen =  new JerseyExceptionMapperGenerator(fsa, exMapper);
	
		for(exception: exMapper.values)
		{
			exceptionGenerator.generateCustomException(exception);
			eMapperGen.generateExceptionMapper(exception)  
		} 
	}	
}