package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.MethodNotAllowedTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceMethodNotAllowedTests 
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;	

	val testCaseUrl = "RESOURCE_BASE_URL";
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_METHOD_NOT_ALLOWED_TESTS.generationLocation + Constants.JAVA, "unit-test", 
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImports»

public abstract class «Naming.RESOURCE_METHOD_NOT_ALLOWED_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new MethodNotAllowedTestCases("testResourceIdEndpoint", testCaseUrl + " + \"/1\"").generateResourceIdEndpoint()»
	«new MethodNotAllowedTestCases("testResourceEndpoint", testCaseUrl).generateResourceEndpoint()»
	«new MethodNotAllowedTestCases("testResourceQueryEndpoint", testCaseUrl + " + \"/query/1\"").generateQueryEndpoint()»
}
			'''
		);
	}
}