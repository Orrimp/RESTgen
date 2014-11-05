package com.rest.rdsl.unittests.datagenerator.longdata

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class LongGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.LONG_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import datagenerator.TestDataGenerator;

public interface LongGenerator extends TestDataGenerator
{
	@Override
	public Long getTestDataWithinLimits(String fieldName);
	@Override
	public Long getTestDataBelowLimits(String fieldName);
	@Override
	public Long getTestDataAboveLimits(String fieldName);
	@Override
	public Long getTestDataBelowLowerBound(String fieldName);
	@Override
	public Long getTestDataAtLowerBound(String fieldName);
	@Override
	public Long getTestDataAboveLowerBound(String fieldName);
	@Override
	public Long getTestDataBelowUpperBound(String fieldName);
	@Override
	public Long getTestDataAtUpperBound(String fieldName);
	@Override
	public Long getTestDataAboveUpperBound(String fieldName);
}
			''')
	}
}