package com.rest.rdsl.unittests.datagenerator

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class TestDataGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.TEST_DATA_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public interface «Naming.TEST_DATA_GENERATOR»
{
	public Object getTestDataWithinLimits(String fieldName);
	public Object getTestDataBelowLimits(String fieldName);
	public Object getTestDataAboveLimits(String fieldName);
	public Object getTestDataBelowLowerBound(String fieldName);
	public Object getTestDataAtLowerBound(String fieldName);
	public Object getTestDataAboveLowerBound(String fieldName);
	public Object getTestDataBelowUpperBound(String fieldName);
	public Object getTestDataAtUpperBound(String fieldName);
	public Object getTestDataAboveUpperBound(String fieldName);
}
			''')
	}
}