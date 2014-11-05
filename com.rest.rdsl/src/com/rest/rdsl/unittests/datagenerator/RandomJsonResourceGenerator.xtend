package com.rest.rdsl.unittests.datagenerator

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class RandomJsonResourceGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RANDOM_JSON_RESOURCE_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import datagenerator.stringdata.*;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpResponse;

public class RandomJsonResourceGenerator extends JsonResourceGenerator
{
	private Class<?> resourceClass;
	
	public RandomJsonResourceGenerator()
	{}
	
	public RandomJsonResourceGenerator(Class<?> resourceClass)
	{
		this.resourceClass = resourceClass;
	}
	
	@Override
	public JsonResource getValidJsonResource()
	{
		JsonResource jsonResource = new JsonResource();
		
		Field[] declaredFields = resourceClass.getDeclaredFields();
		for(int i = 3; i < declaredFields.length; i++)
		{
			Object testData = getRandomValidData(declaredFields[i].getType(), declaredFields[i].getName());
			jsonResource.put(declaredFields[i].getName(), testData);
		}
		
		return jsonResource;
	}
	
	private Object getRandomValidData(Class<?> fieldClass, String fieldName)
	{
		Object result = null;
		
		TestDataGenerator generator = super.generators.get(fieldClass.getSimpleName());
		if(generator != null)
		{
			result = generator.getTestDataWithinLimits(fieldName);
		}
		
		return result;
	}
	
	«generateGeneratorMethod("BelowLimits")»
	«generateRandomDataMethod("BelowLimits")»
	«generateGeneratorMethod("AboveLimits")»
	«generateRandomDataMethod("AboveLimits")»
	«generateGeneratorMethod("BelowLowerBound")»
	«generateRandomDataMethod("BelowLowerBound")»
	«generateGeneratorMethod("AtLowerBound")»
	«generateRandomDataMethod("AtLowerBound")»
	«generateGeneratorMethod("AboveLowerBound")»
	«generateRandomDataMethod("AboveLowerBound")»
	«generateGeneratorMethod("BelowUpperBound")»
	«generateRandomDataMethod("BelowUpperBound")»
	«generateGeneratorMethod("AtUpperBound")»
	«generateRandomDataMethod("AtUpperBound")»
	«generateGeneratorMethod("AboveUpperBound")»
	«generateRandomDataMethod("AboveUpperBound")»
	
	@Override
	public «Naming.JSON_RESOURCE» getJsonResourceWithWrongContextFor(String fieldName)
	{
		«Naming.JSON_RESOURCE» jsonResource = new «Naming.JSON_RESOURCE»();
		
		Field[] declaredFields = resourceClass.getDeclaredFields();
		for(int i = 3; i < declaredFields.length; i++)
		{
			Object testData = null;
			String currentFieldName = declaredFields[i].getName();
			
			if(currentFieldName.equals(fieldName))
			{
				testData = getRandomDataWithWrongContext(declaredFields[i].getType(), currentFieldName);
			} else
			{
				testData = getRandomValidData(declaredFields[i].getType(), currentFieldName);
			}
			
			jsonResource.put(currentFieldName, testData);
		}
		
		return jsonResource;
	}
	
	private Object getRandomDataWithWrongContext(Class<?> fieldClass, String fieldName)
	{
		Object result = null;
		
		TestDataGenerator generator = super.generators.get(fieldClass.getSimpleName());
		if(generator != null)
		{
			result = ((StringGenerator)generator).getTestDataWithWrongContext(fieldName);
		}
		
		return result;
	}
	
	@Override
	public «Naming.JSON_RESOURCE» getJsonResourceWithWrongTypeFor(String fieldName)
	{
		«Naming.JSON_RESOURCE» jsonResource = new «Naming.JSON_RESOURCE»();
		
		Field[] declaredFields = resourceClass.getDeclaredFields();
		for(int i = 3; i < declaredFields.length; i++)
		{
			Object testData = null;
			String currentFieldName = declaredFields[i].getName();
			
			if(currentFieldName.equals(fieldName))
			{
				testData = getRandomDataWithWrongType(currentFieldName);
			} else
			{
				testData = getRandomValidData(declaredFields[i].getType(), currentFieldName);
			}
			
			jsonResource.put(currentFieldName, testData);
		}
		
		return jsonResource;
	}
	
	private Object getRandomDataWithWrongType(String fieldName)
	{
		Object result = null;
		
		TestDataGenerator generator = super.generators.get("String");
		if(generator != null)
		{
			result = generator.getTestDataWithinLimits(fieldName);
		}
		
		return result;
	}
	
	@Override
	public JsonResource getJsonResourceWithUnknownAttribute()
	{
		JsonResource jsonResource = new JsonResource();
		
		Field[] declaredFields = resourceClass.getDeclaredFields();
		for(int i = 3; i < declaredFields.length; i++)
		{
			Object testData = getRandomValidData(declaredFields[i].getType(), declaredFields[i].getName());
			jsonResource.put(declaredFields[i].getName(), testData);
		}
		
		String unknownAttribute = (String)super.generators.get("String")
											   .getTestDataWithinLimits(declaredFields[declaredFields.length - 1].getName());
		jsonResource.put(unknownAttribute, "null");
		
		return jsonResource;
	}
	
	@Override
	public JsonResource combine(JsonResource jsonResource, HttpResponse response)
	{
		jsonResource.put("selfURI", getSelfURI(response));
		jsonResource.put("iD", getID((String)jsonResource.get("selfURI")));
		jsonResource.put("links", getLinks(response));
		jsonResource.put("@class", resourceClass.getSimpleName().toLowerCase());
		return jsonResource;
	}
	
	private String getSelfURI(HttpResponse response)
	{
		String selfLink = "";
		
		Header[] headers = response.getHeaders("Link");
		for(Header h : headers)
		{
			HeaderElement[] elements = h.getElements();
			if(elements[0].getParameterByName("rel").getValue().equals("self"))
			{
				selfLink = elements[0].getName();
			}
		}
		
		return selfLink.substring(1, (selfLink.length() - 1));
	}
	
	private Long getID(String selfURI)
	{
		String[] paths = selfURI.split("/");
		return Long.parseLong(paths[paths.length - 1]);
	}
	
	private List<HashMap<String,String>> getLinks(HttpResponse response)
	{
		List<HashMap<String,String>> result = new ArrayList<>();
		
		Header[] headers = response.getHeaders("Link");
		for(Header h : headers)
		{
			HeaderElement[] elements = h.getElements();
			HashMap<String,String> link = new HashMap<>();
			link.put("@class", "simplelink");
			link.put("type", elements[0].getParameterByName("rel").getValue());
			String uri = elements[0].getName();
			link.put("uRI", uri.substring(1, (uri.length() - 1)));
			
			result.add(link);
		}
		return result;
	}
}
			''');
	}
	
	def generateGeneratorMethod(String methodSpecification)
	{
		'''
	@Override
	public «Naming.JSON_RESOURCE» getJsonResource«methodSpecification»For(String fieldName)
	{
		«Naming.JSON_RESOURCE» jsonResource = new «Naming.JSON_RESOURCE»();
		
		Field[] declaredFields = resourceClass.getDeclaredFields();
		for(int i = 3; i < declaredFields.length; i++)
		{
			Object testData = null;
			String currentFieldName = declaredFields[i].getName();
			
			if(currentFieldName.equals(fieldName))
			{
				testData = getRandomData«methodSpecification»(declaredFields[i].getType(), currentFieldName);
			} else
			{
				testData = getRandomValidData(declaredFields[i].getType(), currentFieldName);
			}
			
			jsonResource.put(currentFieldName, testData);
		}
		
		return jsonResource;
	}
	 
		'''
	}
	
	def generateRandomDataMethod(String methodSpecification)
	{
		'''
	private Object getRandomData«methodSpecification»(Class<?> fieldClass, String fieldName)
	{
		Object result = null;
		
		TestDataGenerator generator = super.generators.get(fieldClass.getSimpleName());
		if(generator != null)
		{
			result = generator.getTestData«methodSpecification»(fieldName);
		}
		
		return result;
	}
	 
		'''
	}
}