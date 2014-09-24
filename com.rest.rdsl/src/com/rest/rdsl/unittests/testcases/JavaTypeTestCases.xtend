package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.List

class JavaTypeTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> internalServerErrorTestCaseSpecifications;
	val String methodMid = "AttributeWithWrongJavaType";
	val String junitParams = "method = \"" + Constants.NON_STRING_ATTRIBUTE_PARAMS + "\"";
	val String methodParams = "String attribute";
	val String generatorCall = "getJsonResourceWithWrongTypeFor(attribute)";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		internalServerErrorTestCaseSpecifications = specificationsBuilder.buildInternalServerError();
	}
	
	def generatePATCHCases()
	{
	'''
	«FOR specification: internalServerErrorTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePATCH(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePOSTCases()
	{
	'''
	«FOR specification: internalServerErrorTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePOST(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePUTCases()
	{
	'''
	«FOR specification: internalServerErrorTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePUT(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
}