package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.CorrectLinkTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.rest.rdsl.unittests.testcases.PreconditionTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceGetIdTests
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;

	val String testCasePrefix = "testGetId";
	val String testCaseUrl = "DEFAULT_SELF_URL";
	val String notExistingResourceUrl = "RESOURCE_BASE_URL + \"/0\"";
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_GET_ID_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImports»

public abstract class «Naming.RESOURCE_GET_ID_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generateGETCases()»
	«new CorrectLinkTestCases(testCasePrefix, testCaseUrl).generateGETIdCases()»
	«new PreconditionTestCases(testCasePrefix, testCaseUrl).generateGETCases()»
	«new OutlierTestCases(testCasePrefix, notExistingResourceUrl).generateGETCases()»
}
			'''
		);
	}
}
