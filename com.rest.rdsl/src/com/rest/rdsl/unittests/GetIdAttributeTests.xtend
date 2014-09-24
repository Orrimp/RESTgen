package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess

class GetIdAttributeTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResource resource;
	val AttributeExtractor attributeExtractor;
	val TestClassHeader testClassHeader;
	
	val String testClassSuffix = "GetIdAttributeTests";
	
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
public class «resource.name»«testClassSuffix» extends «Naming.RESOURCE_GET_ID_ATTRIBUTE_TESTS»
{
	«testClassHeader.generatePrivateMembers»
	«testClassHeader.generateClientMethod»
	«testClassHeader.generateGeneratorMethod»
	«testClassHeader.generateBeforeMethod»
	«testClassHeader.generateAfterMethod»
	
	«MethodParams.generatePrimitivesMethod(attributeExtractor)»
}
			'''
		);
	}
}