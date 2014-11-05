package com.rest.rdsl.unittests.datagenerator.stringdata

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class StringContextGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.STRING_CONTEXT_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public interface «Naming.STRING_CONTEXT_GENERATOR»
{
	public String generate(int length);
}
			''')
	}
}