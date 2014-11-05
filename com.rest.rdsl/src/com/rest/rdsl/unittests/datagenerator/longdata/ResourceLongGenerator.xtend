package com.rest.rdsl.unittests.datagenerator.longdata

import com.rest.rdsl.unittests.datagenerator.FieldSpecificationsExtractor
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceLongGenerator 
{
	private IFileSystemAccess fsa;
	private RESTConfiguration config;
	private RESTResource resource;
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		this.resource = resource;
	}
	
	def generate()
	{
		fsa.generateFile(Naming.LONG_GENERATOR.generationLocation + resource.name + Constants.JAVA , "unit-test",
			'''
package «PackageManager.longDataPackage»;

import «PackageManager.dataGeneratorPackage».«Naming.FIELD_SPECIFICATIONS»;

import java.util.Map;
import java.util.HashMap;

public class «Naming.LONG_GENERATOR»«resource.name» implements «Naming.LONG_GENERATOR»
{
	«new FieldSpecificationsExtractor(resource).generateFieldSpecifications("L")»
	
	public «Naming.LONG_GENERATOR»«resource.name»()
	{}
	
	@Override
	public Long getTestDataWithinLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((long)specifications.getLowerBound(), (long)specifications.getUpperBound());
	}
	
	@Override
	public Long getTestDataBelowLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((long)specifications.getLowerBound() - 1000L, (long)specifications.getLowerBound());
	}
	
	@Override
	public Long getTestDataAboveLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((long)specifications.getUpperBound(), (long)specifications.getUpperBound() + 1000L);
	}
	
	@Override
	public Long getTestDataBelowLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getLowerBound() - 1;
	}
	
	@Override
	public Long getTestDataAtLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getLowerBound();
	}
	
	@Override
	public Long getTestDataAboveLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getLowerBound() + 1;
	}
	
	@Override
	public Long getTestDataBelowUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getUpperBound() - 1;
	}
	
	@Override
	public Long getTestDataAtUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getUpperBound();
	}
	
	@Override
	public Long getTestDataAboveUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (long)specifications.getUpperBound() + 1;
	}
	
	private Long generate(Long lowerBound, Long upperBound)
	{
		return (long)(Math.random()*(upperBound - lowerBound)) + lowerBound;
	}
}
			''')
	}
}