package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.MethodNotAllowedTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class MethodNotAllowedTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResource resource;
	val AttributeExtractor attributeExtractor;
	val TestClassHeader testClassHeader;
	
	val String testCasePrefix;
	val String testCaseUrl = "DEFAULT_SELF_URL + \"/\" + attribute";
	val String testClassSuffix = "MethodNotAllowedTests";
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		this.resource = resource;
		attributeExtractor = new AttributeExtractor(resource);
		testCasePrefix = "test" + resource.name;
		testClassHeader = new TestClassHeader(config, resource);
	}
	
	def generate()
	{
		fsa.generateFile(PackageManager.unitTestPackage + "/" + resource.name + testClassSuffix + Constants.JAVA,
			"unit-test",
			'''
package «PackageManager.unitTestPackage»;

«testClassHeader.generateDefaultImportsWithJUnitParams»

@RunWith(JUnitParamsRunner.class)
public class «resource.name»«testClassSuffix» extends «Naming.RESOURCE_METHOD_NOT_ALLOWED_TESTS»
{
	«testClassHeader.generatePrivateMembers»
	«testClassHeader.generateClientMethod»
	«testClassHeader.generateGeneratorMethod»
	«testClassHeader.generateBeforeMethod»
	«testClassHeader.generateAfterMethod»
	
	«new MethodNotAllowedTestCases(testCasePrefix, testCaseUrl).generateAttributeEndpoint()»
	
	«MethodParams.generatePrimitivesMethod(attributeExtractor)»
}
			'''
		); 
	}
}