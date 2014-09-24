package com.rest.rdsl.unittests.datagenerator.doubledata

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class DoubleGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.DOUBLE_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import datagenerator.TestDataGenerator;

public interface DoubleGenerator extends TestDataGenerator
{
	@Override
	public Double getTestDataWithinLimits(String fieldName);
	@Override
	public Double getTestDataBelowLimits(String fieldName);
	@Override
	public Double getTestDataAboveLimits(String fieldName);
	@Override
	public Double getTestDataBelowLowerBound(String fieldName);
	@Override
	public Double getTestDataAtLowerBound(String fieldName);
	@Override
	public Double getTestDataAboveLowerBound(String fieldName);
	@Override
	public Double getTestDataBelowUpperBound(String fieldName);
	@Override
	public Double getTestDataAtUpperBound(String fieldName);
	@Override
	public Double getTestDataAboveUpperBound(String fieldName);
}
			''')
	}
}