package com.rest.rdsl.unittests.datagenerator

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class JsonResource
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.JSON_RESOURCE.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import com.owlike.genson.Genson;

public class JsonResource extends HashMap<String,Object>
{
	private static final long serialVersionUID = -69881623160842744L;
	
	private final String ISO8601_DATETIME_FORMAT = "yyyy-MM-dd' 'HH:mm:ss";
	private final DateFormat format = new SimpleDateFormat(ISO8601_DATETIME_FORMAT);
	
	public JsonResource()
	{}
	
	/*
	 * CopyConstructor only constructs flat copy!!
	 */
	public JsonResource(JsonResource jsonResource)
	{
		for(Entry<String,Object> entry: jsonResource.entrySet())
		{
			put(entry.getKey(), entry.getValue());
		}
	}

	public JsonResource(String jsonString)
	{
		Genson genson = new Genson.Builder().setDateFormat(format).create();
		HashMap<String,Object> jsonMap = null;
		
		try
		{
			jsonMap = genson.deserialize(jsonString, this.getClass());
		} catch(Exception e)
		{
			
		}
		
		for(Entry<String,Object> entry: jsonMap.entrySet())
		{
			if(entry.getKey().equals("links"))
			{
				put(entry.getKey(), getLinks(entry.getValue()));
			} else
			{
				put(entry.getKey(), entry.getValue());
			}
		}
	}
	
	private Object getLinks(Object value)
	{
		List<Object> result = new ArrayList<>();
		Object[] links = (Object[])value;
		
		for(int i = 0; i < links.length; i++)
		{
			result.add(links[i]);
		}
		
		return result;
	}

	@Override
	public String toString()
	{
		String jsonData;

		Genson genson = new Genson.Builder().setDateFormat(format).create();
		try
		{
			jsonData = genson.serialize(this);
		} catch(Exception e)
		{
			jsonData = "";
		}
		return jsonData;
	}
}
			''');
	}
}