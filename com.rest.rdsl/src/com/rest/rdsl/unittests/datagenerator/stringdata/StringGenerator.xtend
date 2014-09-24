package com.rest.rdsl.unittests.datagenerator.stringdata

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class StringGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.STRING_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import datagenerator.TestDataGenerator;

public interface StringGenerator extends TestDataGenerator
{
	@Override
	public String getTestDataWithinLimits(String fieldName);
	@Override
	public String getTestDataBelowLimits(String fieldName);
	@Override
	public String getTestDataAboveLimits(String fieldName);
	@Override
	public String getTestDataBelowLowerBound(String fieldName);
	@Override
	public String getTestDataAtLowerBound(String fieldName);
	@Override
	public String getTestDataAboveLowerBound(String fieldName);
	@Override
	public String getTestDataBelowUpperBound(String fieldName);
	@Override
	public String getTestDataAtUpperBound(String fieldName);
	@Override
	public String getTestDataAboveUpperBound(String fieldName);
	public String getTestDataWithWrongContext(String fieldName);
}
			''')
	}
}