package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.List

class MethodNotAllowedTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> specifications;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	def generateAttributeEndpoint()
	{
		val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
		val String methodParams = "String attribute";
		val String generatorCall = "getValidJsonResource()";
		specifications = specificationsBuilder.buildMethodNotAllowed("GET,OPTIONS");
				
		'''
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedDELETE")»
		«testCases.generateDELETE(specification, junitParams, methodParams)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPATCH")»
		«testCases.generatePATCH(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPOST")»
		«testCases.generatePOST(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPUT")»
		«testCases.generatePUT(specification, junitParams, methodParams, generatorCall)»
	«ENDFOR»
		'''
	}
	
	def generateResourceIdEndpoint()
	{
		specifications = specificationsBuilder.buildMethodNotAllowed("DELETE,GET,OPTIONS,PUT");
		
		'''
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPATCH")»
		«testCases.generatePATCHWithoutParams(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPOST")»
		«testCases.generatePOST(specification)»
	«ENDFOR»
		'''
	}
	
	def generateResourceEndpoint()
	{
		specifications = specificationsBuilder.buildMethodNotAllowed("POST,OPTIONS,PATCH");
		
		'''
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedDELETE")»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedGET")»
		«testCases.generateGET(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPUT")»
		«testCases.generatePUT(specification)»
	«ENDFOR»
		'''
	}
	
	def generateQueryEndpoint()
	{
		specifications = specificationsBuilder.buildMethodNotAllowed("GET,OPTIONS");
		
		'''
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedDELETE")»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPATCH")»
		«testCases.generatePATCHWithoutParams(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPOST")»
		«testCases.generatePOST(specification)»
	«ENDFOR»
	«FOR specification: specifications»
		«specification.setMethodMid("MethodNotAllowedPUT")»
		«testCases.generatePUT(specification)»
	«ENDFOR»
		'''
	}
}