package com.rest.rdsl.unittests.datagenerator

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class JsonResourceGenerator
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.JSON_RESOURCE_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import java.util.Map;

import org.apache.http.HttpResponse;

public abstract class «Naming.JSON_RESOURCE_GENERATOR»
{
	protected Map<String,«Naming.TEST_DATA_GENERATOR»> generators;
	
	public abstract «Naming.JSON_RESOURCE» getValidJsonResource();
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceBelowLimitsFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceAboveLimitsFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceBelowLowerBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceAtLowerBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceAboveLowerBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceBelowUpperBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceAtUpperBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceAboveUpperBoundFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceWithWrongContextFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceWithWrongTypeFor(String fieldName);
	
	public abstract «Naming.JSON_RESOURCE» getJsonResourceWithUnknownAttribute();
	
	public abstract «Naming.JSON_RESOURCE» combine(«Naming.JSON_RESOURCE» jsonResource, HttpResponse response);
	
	public void setTestDataGenerators(Map<String,«Naming.TEST_DATA_GENERATOR»> generators)
	{
		this.generators = generators;
	}
}
			''');
	}
}