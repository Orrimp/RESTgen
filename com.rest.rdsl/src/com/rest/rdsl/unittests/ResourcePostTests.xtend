package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.CorrectLinkTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.rest.rdsl.unittests.testcases.UnknownAttributeTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourcePostTests
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;

	val String testCasePrefix = "testPostResource";
	val String testCaseUrl = "RESOURCE_BASE_URL";
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_POST_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImports»

public abstract class «Naming.RESOURCE_POST_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generatePOSTCases()»
	«new UnknownAttributeTestCases(testCasePrefix, testCaseUrl).generatePOSTCases()»
	«new CorrectLinkTestCases(testCasePrefix, testCaseUrl).generatePOSTCases()»
	«new OutlierTestCases(testCasePrefix, testCaseUrl).generatePOSTCases()»
}
			'''
		);
	}
}
