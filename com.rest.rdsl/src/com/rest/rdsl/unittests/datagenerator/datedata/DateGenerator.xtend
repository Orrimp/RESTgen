package com.rest.rdsl.unittests.datagenerator.datedata

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class DateGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.DATE_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import datagenerator.TestDataGenerator;

import java.util.Date;

public interface DateGenerator extends TestDataGenerator
{
	@Override
	public Date getTestDataWithinLimits(String fieldName);
	@Override
	public Date getTestDataBelowLimits(String fieldName);
	@Override
	public Date getTestDataAboveLimits(String fieldName);
	@Override
	public Date getTestDataBelowLowerBound(String fieldName);
	@Override
	public Date getTestDataAtLowerBound(String fieldName);
	@Override
	public Date getTestDataAboveLowerBound(String fieldName);
	@Override
	public Date getTestDataBelowUpperBound(String fieldName);
	@Override
	public Date getTestDataAtUpperBound(String fieldName);
	@Override
	public Date getTestDataAboveUpperBound(String fieldName);
}
			''')
	}
}