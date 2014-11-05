package com.rest.rdsl.unittests.datagenerator.datedata

import com.rest.rdsl.unittests.datagenerator.FieldSpecificationsExtractor
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceDateGenerator 
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
		fsa.generateFile(Naming.DATE_GENERATOR.generationLocation + resource.name + Constants.JAVA, "unit-test",
			'''
package «PackageManager.dateDataPackage»;

import «PackageManager.dataGeneratorPackage».«Naming.FIELD_SPECIFICATIONS»;

import java.util.Map;
import java.util.HashMap;
import java.util.Date;

public class «Naming.DATE_GENERATOR»«resource.name» implements «Naming.DATE_GENERATOR»
{
	«new FieldSpecificationsExtractor(resource).generateFieldSpecifications("L")»
	
	public «Naming.DATE_GENERATOR»«resource.name»()
	{}
	//TODO methods not correct yet
	@Override
	public Date getTestDataWithinLimits(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataBelowLimits(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataAboveLimits(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataBelowLowerBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataAtLowerBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataAboveLowerBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataBelowUpperBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataAtUpperBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
	
	@Override
	public Date getTestDataAboveUpperBound(String fieldName)
	{
		long dateValue = (long)(Math.random() * 1000000000000L + 1000000000000L);
		Date date = new Date(dateValue);
		return date;
	}
}
			''')
	}
}