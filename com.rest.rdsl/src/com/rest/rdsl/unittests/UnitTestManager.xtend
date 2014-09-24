package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess

class UnitTestManager 
{
	val RESTConfiguration config;
	val IFileSystemAccess fsa;
	val RESTResourceCollection resourceCollection;
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResourceCollection resourceCollection)
	{
		this.config = config;
		this.fsa = fsa;
		this.resourceCollection = resourceCollection;
	}	
	
	def generate()
	{
		new StaticUnitTestGenerator(fsa, config).doGeneratePlatform();
		new DynamicUnitTestGenerator(fsa, config, resourceCollection).doGenerateUnitTests();
	}
}