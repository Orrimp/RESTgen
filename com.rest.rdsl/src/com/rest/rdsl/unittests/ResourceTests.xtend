package com.rest.rdsl.unittests

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class ResourceTests 
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESOURCE_TESTS.generationLocation + Constants.JAVA, "unit-test",
		'''
package «packageName»;

«testSuperClassHeader.generateDefaultImports»
«testSuperClassHeader.generateUtilImports»

public abstract class «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateProtectedMembers»
	«testSuperClassHeader.generateConstants»
	«testSuperClassHeader.generateAbstractMethods»
	
	«testSuperClassHeader.generateBasicBeforeMethod»
	«testSuperClassHeader.generateBasicAfterMethod»
	«testSuperClassHeader.generateExecuteDelete»
	«testSuperClassHeader.generateExecutePost»
}
		''');
	}	
}