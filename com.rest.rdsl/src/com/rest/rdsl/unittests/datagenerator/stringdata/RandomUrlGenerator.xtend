package com.rest.rdsl.unittests.datagenerator.stringdata

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class RandomUrlGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RANDOM_URL_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public class «Naming.RANDOM_URL_GENERATOR» implements «Naming.STRING_CONTEXT_GENERATOR»
{
	public «Naming.RANDOM_URL_GENERATOR»()
	{}
	
	public String generate(int length)
	{
		StringBuffer result = new StringBuffer(length);
		char[] allowedCharacters = new String("abcdefghijklmnopqrstuvwxyz0123456789")
											.toCharArray();
		
		if(length > 10)
		{
			result.append("http://");
			
			for(int i = 7; i < (length - 1); i++)
			{
				int index = (int)(Math.random() * allowedCharacters.length);
				result.append(allowedCharacters[index]);
			}
			
			int offset = (length == 11)? 0 : (int)(Math.random() + 0.5);
			int pointOffset = length - 1 - 2 - offset;
			result.insert(pointOffset, '.');
		}
		
		return result.toString();
	}
}
			''')
	}
}