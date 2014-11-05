package com.rest.rdsl.unittests.datagenerator.stringdata

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class RandomEmailGenerator 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RANDOM_EMAIL_GENERATOR.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public class «Naming.RANDOM_EMAIL_GENERATOR» implements «Naming.STRING_CONTEXT_GENERATOR»
{
	public «Naming.RANDOM_EMAIL_GENERATOR»()
	{}
	
	public String generate(int length)
	{
		StringBuilder result = new StringBuilder(length);
		char[] allowedCharacters = new String("abcdefghijklmnopqrstuvwxyz0123456789")
											.toCharArray();
		
		if(length > 5)
		{
			for(int i = 0; i < (length - 2); i++)
			{
				int index = (int)(Math.random() * allowedCharacters.length);
				result.append(allowedCharacters[index]);
			}
			
			int offset = (length == 6)? 0 : (int)(Math.random() + 0.5);
			int pointOffset = length - 2 - 2 - offset;
			result.insert(pointOffset, '.');
			
			int atOffset = (int)(Math.random() * (pointOffset - 2)) + 1;
			result.insert(atOffset, '@'); 
		}
		
		return result.toString();
	}
}
			''')
	}
}