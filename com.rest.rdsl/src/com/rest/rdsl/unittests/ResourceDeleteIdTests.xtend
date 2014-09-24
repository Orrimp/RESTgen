package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.rest.rdsl.unittests.testcases.PreconditionTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceDeleteIdTests
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;

	val String testCasePrefix = "testDeleteId";
	val String testCaseUrl = "DEFAULT_SELF_URL";

	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_DELETE_ID_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImports»

public abstract class «Naming.RESOURCE_DELETE_ID_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generateDELETECases()»
	«new PreconditionTestCases(testCasePrefix, testCaseUrl).generateDELETECases()»
	«new OutlierTestCases(testCasePrefix, testCaseUrl).generateDELETECases()»
}
			'''
		);
	}
}
