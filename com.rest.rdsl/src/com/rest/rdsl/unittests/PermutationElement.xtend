package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.restDsl.JavaReference

class PermutationElement 
{
	val String key;
	val JavaReference value;
	
	new(String key, JavaReference value)
	{
		this.key = key;
		this.value = value;
	}
	
	new(PermutationElement element)
	{
		this.key = element.getKey();
		this.value = element.getValue();
	}
	
	def String getKey()
	{
		return key;
	}
	
	def JavaReference getValue()
	{
		return value;
	}
	
	override boolean equals(Object o)
	{
		var result = false;
		
		if(o instanceof PermutationElement)
		{
			result = (o as PermutationElement).getKey().equals(key);
		}
		
		return result;
	}
}