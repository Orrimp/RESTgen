package com.rest.rdsl.unittests.datagenerator

import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.Context
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.PrimitiveType
import com.xtext.rest.rdsl.restDsl.RESTResource

class FieldSpecificationsExtractor 
{
	val RESTResource resource;
	
	new(RESTResource resource)
	{
		this.resource = resource;
	}
	
	def generateFieldSpecifications(String dataTypeSuffix)
	{
		'''
	private Map<String,«Naming.FIELD_SPECIFICATIONS»> fieldSpecifications = new HashMap<String,«Naming.FIELD_SPECIFICATIONS»>();
	{
		«FOR attribute : resource.attributes»
			«getFieldSpecification(attribute, dataTypeSuffix)»
		«ENDFOR»
	}
		'''
	}
	
	private def getFieldSpecification(Attribute attribute, String dataTypeSuffix)
	{
		var String result = ""; 
		if(attribute.value instanceof JavaReference)
		{
			val PrimitiveType primitiveType = (attribute.value as JavaReference).javaDataType;
			val String context = getContext(primitiveType);
			val String lowerBound = getLowerBound(primitiveType);
			val String upperBound = getUpperBound(primitiveType);
			
			result = "fieldSpecifications.put(\"" + attribute.name + "\", new " + Naming.FIELD_SPECIFICATIONS + "(" + lowerBound + dataTypeSuffix + ", " + upperBound + dataTypeSuffix + ", \"" + context + "\"));";
		}
		
		return result;
	}
	
	private def getLowerBound(PrimitiveType primitiveType)
	{
		var String lowerBound;
		
		if(primitiveType.start.nullOrEmpty)
		{
			if("String".equals(primitiveType.dataType.literal))
			{
				lowerBound = "0";
			} else
			{
				lowerBound = Integer.MIN_VALUE.toString();
			}
		} else
		{
			lowerBound = primitiveType.start;
		}
		
		return lowerBound;
	}
	
	private def getUpperBound(PrimitiveType primitiveType)
	{
		var String upperBound;
		
		if(primitiveType.stop.nullOrEmpty)
		{
			if("String".equals(primitiveType.dataType.literal))
			{
				upperBound = "255";
			} else
			{
				upperBound = Integer.MAX_VALUE.toString();
			}
		} else
		{
			upperBound = primitiveType.stop;
		}
		
		return upperBound;
	}
	
	private def getContext(PrimitiveType primitiveType)
	{
		var String context;
		
		try
		{
			if(!primitiveType.context.literal.nullOrEmpty)
			{
				context = primitiveType.context.literal;
			}
		} catch(Exception e)
		{
			context = Context.UNKNOWN.literal;
		}
	}
}