package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.Context
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.PrimitiveType
import com.xtext.rest.rdsl.restDsl.RESTResource
import java.util.ArrayList
import java.util.List

class AttributeExtractor
{
	private val RESTResource resource;
	
	new(RESTResource resource)
	{
		this.resource = resource;
	}
	
	def getPrimitives()
	{
		var List<String> primitives = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(a.value instanceof JavaReference)
 			{
 				primitives.add(a.name);
 			}
 		}
 		
 		return primitives;
	}
	
	def getPrimitivesWithLowerBound()
	{
		var List<String> primitives = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(a.value instanceof JavaReference)
 			{
 				val PrimitiveType primitiveType = (a.value as JavaReference).javaDataType;
 				if("String".equals(primitiveType.dataType.literal) && !"0".equals(primitiveType.start))
 				{
 					primitives.add(a.name);
 				} else if(!primitiveType.start.nullOrEmpty)
 				{
 					primitives.add(a.name);
 				}
 			}
 		}
 		
 		return primitives;
	}
	
	def getPrimitivesWithUpperBound()
	{
		var List<String> primitives = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(a.value instanceof JavaReference)
 			{
 				val PrimitiveType primitiveType = (a.value as JavaReference).javaDataType;
 				if(!primitiveType.stop.nullOrEmpty)
 				{
 					primitives.add(a.name);
 				}
 			}
 		}
 		
 		return primitives;
	}
	
	def getStrings()
	{
		var List<String> strings = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(a.value instanceof JavaReference)
 			{
 				if("String".equals((a.value as JavaReference).javaDataType.dataType.literal))
 				{
 					strings.add(a.name);
 				}
 			}
 		}
 		
 		return strings;
	}
	
	def getStringsWithContext()
	{
		var List<String> stringsWithContext = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
		for(Attribute a: attributes)
		{
			if(a.value instanceof JavaReference)
			{
				val PrimitiveType primitiveType = (a.value as JavaReference).javaDataType;
				val Context context = primitiveType.context;
				if("String".equals(primitiveType.dataType.literal) && (Context.EMAIL.equals(context) || Context.URL.equals(context)))
				{
					stringsWithContext.add(a.name);
				}
			}
		}
		
		return stringsWithContext;
	}
	
	def getNonStrings()
	{
		var List<String> strings = new ArrayList<String>();
		
		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(a.value instanceof JavaReference)
 			{
 				if(!"String".equals(((a.value as JavaReference).javaDataType.dataType.literal)))
 				{
 					strings.add(a.name);
 				}
 			}
 		}
 		
 		return strings;
	}
}
