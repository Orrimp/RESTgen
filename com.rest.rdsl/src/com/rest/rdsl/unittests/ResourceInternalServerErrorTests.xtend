package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.InternalServerErrorTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceInternalServerErrorTests 
{
	val IFileSystemAccess fsa;
	val TestSuperClassHeader testSuperClassHeader;
	
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
		testSuperClassHeader = new TestSuperClassHeader();
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_INTERNAL_SERVER_ERROR_TESTS.generationLocation + Constants.JAVA, "unit-test", 
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImportsWithJunitParams»

@RunWith(JUnitParamsRunner.class)
public abstract class «Naming.RESOURCE_INTERNAL_SERVER_ERROR_TESTS» extends «Naming.RESOURCE_TESTS»
{
	protected static String MANAGEMENT_API;
	
	«testSuperClassHeader.generateAbstractMethods»
	protected abstract Object[] «Constants.PERMUTATED_PATCH_PARAMS»();
	
	«testSuperClassHeader.generateStopDatabaseBeforeMethod»
	«testSuperClassHeader.generateStartDatabaseAfterMethod»
	
	«new InternalServerErrorTestCases("testDeleteId", "DEFAULT_SELF_URL").generateDeleteIdEndpoint()»
	«new InternalServerErrorTestCases("testGetId", "DEFAULT_SELF_URL").generateGetIdEndpoint()»
	«new InternalServerErrorTestCases("testGetQuery", "RESOURCE_BASE_URL + \"/query/1\"").generateGetQueryEndpoint()»
	«new InternalServerErrorTestCases("testPatch", "RESOURCE_BASE_URL").generatePatchEndpoint()»
	«new InternalServerErrorTestCases("testPost", "RESOURCE_BASE_URL").generatePostEndpoint()»
	«new InternalServerErrorTestCases("testPutId", "DEFAULT_SELF_URL").generatePutIdEndpoint()»
}
			'''
		);
	}
}