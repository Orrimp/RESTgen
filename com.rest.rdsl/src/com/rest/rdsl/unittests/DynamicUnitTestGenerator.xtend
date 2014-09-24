package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.datagenerator.datedata.ResourceDateGenerator
import com.rest.rdsl.unittests.datagenerator.doubledata.ResourceDoubleGenerator
import com.rest.rdsl.unittests.datagenerator.longdata.ResourceLongGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.ResourceStringGenerator
import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess

class DynamicUnitTestGenerator 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResourceCollection resourceCollection;
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResourceCollection resourceCollection)
	{
		this.fsa = fsa;
		this.config = config;
		this.resourceCollection = resourceCollection;
	}	
	
	def doGenerateUnitTests()
	{
//		generateStatusCodeTests();
//		generateHeaderTests();
//		generateBodyTests();
		generateEndpointTests();
		generateMethodNotAllowedTests();
		generateInternalServerErrorTests();
		
		generateDataGenerators();
	}
	
	def generateStatusCodeTests() 
	{
		for(r: resourceCollection.getResources())
		{
			new DefaultStatusCodeTests(fsa, config, r).generate();
		}
	}
	
	def generateHeaderTests() 
	{
		for(r: resourceCollection.getResources())
		{
			new DefaultHeaderTests(fsa, config, r).generate();
		}
	}
	
	def generateBodyTests() 
	{
		for(r: resourceCollection.getResources())
		{
			new DefaultBodyTests(fsa, config, r).generate();
		}
	}
	
	def generateEndpointTests()
	{
		for(r: resourceCollection.getResources())
		{
			new PatchTests(fsa, config, r).generate();
			new PutIdTests(fsa, config, r).generate();
			new PostTests(fsa, config, r).generate();
			new DeleteIdTests(fsa, config, r).generate();
			new GetIdTests(fsa, config, r).generate();
			new GetIdAttributeTests(fsa, config, r).generate();
			new GetQueryTests(fsa, config, r).generate();
		}
	}
	
	def generateMethodNotAllowedTests()
	{
		for(r: resourceCollection.getResources())
		{
			new MethodNotAllowedTests(fsa, config, r).generate();
		}
	}
	
	def generateInternalServerErrorTests()
	{
		for(r: resourceCollection.getResources())
		{
			new InternalServerErrorTests(fsa, config, r).generate();
		}
	}
	
	def generateDataGenerators()
	{
		for(r: resourceCollection.getResources())
		{
			new ResourceDateGenerator(fsa, config, r).generate();
			new ResourceDoubleGenerator(fsa, config, r).generate();
			new ResourceLongGenerator(fsa, config, r).generate();
			new ResourceStringGenerator(fsa, config, r).generate();
		}
	}
}