package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.BoundaryTestCases
import com.rest.rdsl.unittests.testcases.ContextTestCases
import com.rest.rdsl.unittests.testcases.IntervallTestCases
import com.rest.rdsl.unittests.testcases.JavaTypeTestCases
import com.rest.rdsl.unittests.testcases.MediaTypeTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class PutIdTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResource resource;
	val AttributeExtractor attributeExtractor;
	val TestClassHeader testClassHeader;
	
	val String testClassSuffix = "PutIdTests";
	val String testCasePrefix = "testPutId";
	val String testCaseUrl = "DEFAULT_SELF_URL";
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		this.resource = resource;
		this.attributeExtractor = new AttributeExtractor(resource);
		this.testClassHeader = new TestClassHeader(config, resource);
	}
	
	def generate()
	{
		fsa.generateFile(PackageManager.unitTestPackage + "/" + resource.name + testClassSuffix + Constants.JAVA, "unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testClassHeader.generateDefaultImportsWithJUnitParams»

@RunWith(JUnitParamsRunner.class)
public class «resource.name»«testClassSuffix» extends «Naming.RESOURCE_PUT_ID_TESTS»
{
	«testClassHeader.generatePrivateMembers»
	«testClassHeader.generateClientMethod»
	«testClassHeader.generateGeneratorMethod»
	«testClassHeader.generateBeforeMethod»
	«testClassHeader.generateAfterMethod»
	
	«new IntervallTestCases(testCasePrefix, testCaseUrl).generatePUTCases()»
	«new BoundaryTestCases(testCasePrefix, testCaseUrl).generatePUTCases()»
	«new ContextTestCases(testCasePrefix, testCaseUrl).generatePUTCases()»
	«new MediaTypeTestCases(testCasePrefix, testCaseUrl).generatePUTCases()»
	«new JavaTypeTestCases(testCasePrefix, testCaseUrl).generatePUTCases()»

	«MethodParams.generatePrimitivesMethod(attributeExtractor)»
	«MethodParams.generatePrimitivesWithLowerBound(attributeExtractor)»
	«MethodParams.generatePrimitivesWithUpperBound(attributeExtractor)»
	«MethodParams.generateStringsMethod(attributeExtractor)»
	«MethodParams.generateStringsWithContextMethod(attributeExtractor)»
	«MethodParams.generateNonStringsMethod(attributeExtractor)»
}
			'''
		)
	}
}