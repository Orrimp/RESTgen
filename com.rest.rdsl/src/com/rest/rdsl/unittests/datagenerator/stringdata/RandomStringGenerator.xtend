package com.rest.rdsl.unittests.datagenerator.stringdata

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class RandomStringGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RANDOM_STRING_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public class «Naming.RANDOM_STRING_GENERATOR» implements «Naming.STRING_CONTEXT_GENERATOR»
{
	public «Naming.RANDOM_STRING_GENERATOR»()
	{}
	
	public String generate(int length)
	{
		String result = "";
		if(length > 0)
		{
			StringBuffer buffer = new StringBuffer(length);
		
			char[] allowedCharacters = new String("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
												.toCharArray();
		
			for(int i = 0; i < length; i++)
			{
				int index = (int)(Math.random() * allowedCharacters.length);
				buffer.append(allowedCharacters[index]);
			}
			
			result = buffer.toString();
		}
		
		return result;
	}
}
			''')
	}
}