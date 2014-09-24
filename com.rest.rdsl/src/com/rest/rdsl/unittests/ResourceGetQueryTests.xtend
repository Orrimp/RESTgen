package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.AuthorizationTestCases
import com.rest.rdsl.unittests.testcases.CorrectLinkTestCases
import com.rest.rdsl.unittests.testcases.OutlierTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceGetQueryTests
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val TestSuperClassHeader testSuperClassHeader;	
	val QueryMethods queryMethods;

	val String testCasePrefix = "testGetQuery";
	val String testCaseUrl = "RESOURCE_BASE_URL";
	
	new(IFileSystemAccess fsa, RESTConfiguration config)
	{
		this.fsa = fsa;
		this.config = config;
		testSuperClassHeader = new TestSuperClassHeader();
		queryMethods = new QueryMethods(config);
	}
	
	def generate()
	{
		fsa.generateFile(Naming.RESOURCE_GET_QUERY_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testSuperClassHeader.generateDefaultImportsWithJunitParams»
«testSuperClassHeader.generateUtilImports»

@RunWith(JUnitParamsRunner.class)
public abstract class «Naming.RESOURCE_GET_QUERY_TESTS» extends «Naming.RESOURCE_TESTS»
{
	«testSuperClassHeader.generateAbstractMethods»
	protected abstract Object[] «Constants.QUERY_PARAMS»();
	
	«testSuperClassHeader.generateBeforeMethod»
	«testSuperClassHeader.generateAfterMethod»
	
	«new AuthorizationTestCases(testCasePrefix, testCaseUrl).generateGETQueryCases()»
	«new CorrectLinkTestCases(testCasePrefix, testCaseUrl).generateGETQueryCases()»
	«new OutlierTestCases(testCasePrefix, testCaseUrl).generateGETQueryCases()»
	
	«queryMethods.generateInitQueryTests»
	«queryMethods.generateBelongsTo»
	«queryMethods.generateQueryUrl»
}
			'''
		);
	}
}
