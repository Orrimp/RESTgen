package com.rest.rdsl.unittests.datagenerator.stringdata

import com.rest.rdsl.unittests.datagenerator.FieldSpecificationsExtractor
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceStringGenerator 
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
		fsa.generateFile(Naming.STRING_GENERATOR.generationLocation + resource.name + Constants.JAVA, "unit-test",
			'''
package «PackageManager.stringDataPackage»;

import «PackageManager.dataGeneratorPackage».«Naming.FIELD_SPECIFICATIONS»;

import java.util.Map;
import java.util.HashMap;

public class «Naming.STRING_GENERATOR»«resource.name» implements «Naming.STRING_GENERATOR»
{
	«new FieldSpecificationsExtractor(resource).generateFieldSpecifications("")»
	
	private Map<String,«Naming.STRING_CONTEXT_GENERATOR»> contextGenerators = new HashMap<String,«Naming.STRING_CONTEXT_GENERATOR»>();
	{
		contextGenerators.put("unknown", new «Naming.RANDOM_STRING_GENERATOR»());
		contextGenerators.put("email", new «Naming.RANDOM_EMAIL_GENERATOR»());
		contextGenerators.put("url", new «Naming.RANDOM_URL_GENERATOR»());
	}
	
	public «Naming.STRING_GENERATOR»«resource.name»()
	{}

	@Override
	public String getTestDataWithinLimits(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int lowerBound = (int)specifications.getLowerBound();
			int upperBound = (int)specifications.getUpperBound();
			int length = (int)(Math.random() * (upperBound - lowerBound)) + lowerBound;
		
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataBelowLimits(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int lowerBound = 0;
			int upperBound = (int)specifications.getLowerBound();
			int length = (int)(Math.random() * (upperBound - lowerBound)) + lowerBound;
		
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataAboveLimits(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int lowerBound = (int)specifications.getUpperBound();
			int upperBound = lowerBound + 15;
			int length = (int)(Math.random() * (upperBound - lowerBound)) + lowerBound;
		
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataBelowLowerBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int length = (int)specifications.getLowerBound();
			
			if(length > 0)
			{
				length--;
			}
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataAtLowerBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int lowerBound = (int)specifications.getLowerBound();
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(lowerBound);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataAboveLowerBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int length = (int)specifications.getLowerBound();
			length++;
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataBelowUpperBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int length = (int)specifications.getUpperBound();
			length--;
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataAtUpperBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int upperBound = (int)specifications.getUpperBound();
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(upperBound);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataAboveUpperBound(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int length = (int)specifications.getUpperBound();
			length++;
			
			String fieldContext = specifications.getContext();
			result = contextGenerators.get(fieldContext).generate(length);
		}
		
		return result;
	}
	
	@Override
	public String getTestDataWithWrongContext(String fieldName)
	{
		String result = null;
		
		FieldSpecifications specifications = fieldSpecifications.get(fieldName);
		
		if(specifications != null)
		{
			int lowerBound = (int)specifications.getLowerBound();
			int upperBound = (int)specifications.getUpperBound();
			int length = (int)(Math.random() * (upperBound - lowerBound)) + lowerBound;
		
			result = contextGenerators.get("unknown").generate(length);
		}
		
		return result;
	}
}
			''')
	}
}