package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.testcases.InternalServerErrorTestCases
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class InternalServerErrorTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResource resource;
	val PermutationGenerator permGen;
	val AttributeExtractor attributeExtractor;
	val TestClassHeader testClassHeader;
	
	val String testCasePrefix = "testGetIdAttribute";
	val String testCaseUrl = "DEFAULT_SELF_URL + \"/\" + attribute";
	val String testClassSuffix = "InternalServerErrorTests";
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		this.resource = resource;
		this.permGen = new PermutationGenerator(resource);
		attributeExtractor = new AttributeExtractor(resource);
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
public class «resource.name»«testClassSuffix» extends «Naming.RESOURCE_INTERNAL_SERVER_ERROR_TESTS»
{
	«testClassHeader.generatePrivateMembers»
	«testClassHeader.generateClientMethod»
	«testClassHeader.generateGeneratorMethod»
	«testClassHeader.generateBeforeMethod»
	«testClassHeader.generateAfterMethod»

	«new InternalServerErrorTestCases(testCasePrefix, testCaseUrl).generateAttributeEndpoint()»

	«MethodParams.generatePrimitivesMethod(attributeExtractor)»
	«MethodParams.generatePermutatedPatchResources(permGen)»
}
			'''
		)
	}
}