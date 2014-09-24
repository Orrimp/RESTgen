package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.CorrectLinkTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants

class ResourceGetIdAttributeTests
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;	

	val String testCasePrefix = "testGetIdAttribute";
	val String testCaseUrl = "DEFAULT_SELF_URL + \"/\" + attribute";
	val String resourceNotFoundUrl = "RESOURCE_BASE_URL + \"/0/\" + attribute";
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_GET_ID_ATTRIBUTE_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImportsWithJunitParams»

@RunWith(JUnitParamsRunner.class)
public abstract class «Naming.RESOURCE_GET_ID_ATTRIBUTE_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	protected abstract Object[] «Constants.PRIMITIVE_ATTRIBUTE_PARAMS»();
	
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generateGETAttributeCases()»
	«new CorrectLinkTestCases(testCasePrefix, testCaseUrl).generateGETAttributeCases()»
	«new OutlierTestCases(testCasePrefix, resourceNotFoundUrl).generateGETAttributeCases()»
}
			'''
		);
	}
}
