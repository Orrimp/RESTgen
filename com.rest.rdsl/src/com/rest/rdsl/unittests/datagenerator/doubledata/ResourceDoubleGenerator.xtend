package com.rest.rdsl.unittests.datagenerator.doubledata

import com.rest.rdsl.unittests.datagenerator.FieldSpecificationsExtractor
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceDoubleGenerator 
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
		fsa.generateFile(Naming.DOUBLE_GENERATOR.generationLocation + resource.name + Constants.JAVA, "unit-test",
			'''
package «PackageManager.doubleDataPackage»;

import «PackageManager.dataGeneratorPackage».«Naming.FIELD_SPECIFICATIONS»;

import java.util.Map;
import java.util.HashMap;

public class «Naming.DOUBLE_GENERATOR»«resource.name» implements «Naming.DOUBLE_GENERATOR»
{
	«new FieldSpecificationsExtractor(resource).generateFieldSpecifications(".0")»
	
	public «Naming.DOUBLE_GENERATOR»«resource.name»()
	{}

	@Override
	public Double getTestDataWithinLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((double)specifications.getLowerBound(), (double)specifications.getUpperBound());
	}
	
	@Override
	public Double getTestDataBelowLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((double)specifications.getLowerBound() - 1000.0, (double)specifications.getLowerBound());
	}
	
	@Override
	public Double getTestDataAboveLimits(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return generate((double)specifications.getUpperBound(), (double)specifications.getUpperBound() + 1000.0);
	}
	
	@Override
	public Double getTestDataBelowLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getLowerBound() - 0.1;
	}
	
	@Override
	public Double getTestDataAtLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getLowerBound();
	}
	
	@Override
	public Double getTestDataAboveLowerBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getLowerBound() + 0.1;
	}
	
	@Override
	public Double getTestDataBelowUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getUpperBound() - 0.1;
	}
	
	@Override
	public Double getTestDataAtUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getUpperBound();
	}
	
	@Override
	public Double getTestDataAboveUpperBound(String fieldName)
	{
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		return (double)specifications.getUpperBound() + 0.1;
	}
	
	private Double generate(Double lowerBound, Double upperBound)
	{
		return (double)(Math.random()*(upperBound - lowerBound)) + lowerBound;
	}
}
			''');
	}	
}