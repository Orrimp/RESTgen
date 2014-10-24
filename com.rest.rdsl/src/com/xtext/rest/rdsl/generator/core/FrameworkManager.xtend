package com.xtext.rest.rdsl.generator.core;

import com.xtext.rest.rdsl.generator.internals.ExceptionGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper
import com.xtext.rest.rdsl.generator.internals.IExceptionGenerator
import com.xtext.rest.rdsl.generator.framework.spring.ResourceAbstractSpringGenerator
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyAbstractResourceGenerator
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyFramework
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyExceptionMapperGenerator
import com.xtext.rest.rdsl.generator.framework.IBaseResourceGenerator
import com.xtext.rest.rdsl.generator.framework.IRESTFramework
import com.xtext.rest.rdsl.generator.RESTResourceObjects

class FrameworkManager {
	
	val IFileSystemAccess fsa
	val RESTResourceObjects resourceCol;
	var IBaseResourceGenerator abstractGenerator;
	var IExceptionGenerator exceptionGenerator
	var IRESTFramework restFramework;
	
	new(IFileSystemAccess fsa, RESTResourceObjects resourceCol) {
		this.fsa = fsa;
		this.resourceCol = resourceCol;
	}
	
	def generate() {
		this.setJerseyEnviroment() 
		
		this.restFramework.generateResources(resourceCol);
		this.restFramework.generateMisc(resourceCol);
		
		abstractGenerator.generate(fsa);
		generateExceptions(fsa);
	}
	
	def setJerseyEnviroment(){
		this.abstractGenerator = new JerseyAbstractResourceGenerator()
		this.restFramework = new JerseyFramework(fsa);
	}
	
	def setSpringEnviroment(){
		this.abstractGenerator = new ResourceAbstractSpringGenerator()
	}
	
	def generateExceptions(IFileSystemAccess fsa) {
		exceptionGenerator = new ExceptionGenerator(fsa);
		val ExceptionMapper exMapper = new ExceptionMapper();
		val JerseyExceptionMapperGenerator eMapperGen =  new JerseyExceptionMapperGenerator(fsa, exMapper);
	
		for(exception: exMapper.values)
		{
			exceptionGenerator.generateCustomException(exception);
			eMapperGen.generateExceptionMapper(exception)  
		} 
	}	
}