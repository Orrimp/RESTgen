package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.CorrectLinkTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.rest.rdsl.unittests.testcases.PreconditionTestCases
import com.rest.rdsl.unittests.testcases.UnknownAttributeTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourcePatchTests 
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;	

	val String testCasePrefix = "testPatch";
	val String testCaseUrl = "RESOURCE_BASE_URL";
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_PATCH_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImportsWithJunitParams»

@RunWith(JUnitParamsRunner.class)
public abstract class «Naming.RESOURCE_PATCH_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	protected abstract Object[] «Constants.PERMUTATED_PATCH_PARAMS»();
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generatePATCHCases()»
	«new UnknownAttributeTestCases(testCasePrefix, testCaseUrl).generatePATCHCases()»
	«new CorrectLinkTestCases(testCasePrefix, testCaseUrl).generatePATCHCases()»
	«new PreconditionTestCases(testCasePrefix, testCaseUrl).generatePATCHCases()»
	«new OutlierTestCases(testCasePrefix, testCaseUrl).generatePATCHCases()»
}
			'''
		);
	}
}