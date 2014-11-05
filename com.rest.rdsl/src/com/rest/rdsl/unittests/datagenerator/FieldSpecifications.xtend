package com.rest.rdsl.unittests.datagenerator

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class FieldSpecifications 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.FIELD_SPECIFICATIONS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public class «Naming.FIELD_SPECIFICATIONS»
{
	private Object upperBound;
	private Object lowerBound;
	private String context;
	
	public «Naming.FIELD_SPECIFICATIONS»(Object lowerBound, Object upperBound, String context)
	{
		this.upperBound = upperBound;
		this.lowerBound = lowerBound;
		this.context = context;
	}
	
	public Object getUpperBound()
	{
		return upperBound;
	}
	
	public Object getLowerBound()
	{
		return lowerBound;
	}
	
	public String getContext()
	{
		return context;
	}
}
			''');
	}
}