package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.List

class ContextTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> unprocessableEntityTestCaseSpecifications;
	val String junitParams = "method = \"" + Constants.STRING_ATTRIBUTE_WITH_CONTEXT_PARAMS + "\"";
	val String methodParams = "String attribute";
	val String methodMid = "AttributeWithWrongContext";
	val String generatorCall = "getJsonResourceWithWrongContextFor(attribute)";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		unprocessableEntityTestCaseSpecifications = specificationsBuilder.buildUnprocessableEntity;
	}
	
	def generatePATCHCases()
	{
	'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePATCH(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePOSTCases()
	{
	'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePOST(specification, junitParams,	methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePUTCases()
	{
	'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePUT(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	'''	
	}
}