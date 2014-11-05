package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.List

class InternalServerErrorTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> specifications;
	val String methodMid = "InternalServerError"; 
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		specifications = specificationsBuilder.buildInternalServerError()
	}
	
	def generateAttributeEndpoint()
	{
		val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
		val String methodParams = "String attribute";
		
		'''
	«FOR specification: specifications»
		«specification.setMethodMid(methodMid)»
		«testCases.generateGET(specification, junitParams, methodParams)»
	«ENDFOR»
		'''
	}
	
	def generateGetIdEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generateGET(specification)»
	«ENDFOR»
		'''
	}
	
	def generateDeleteIdEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePutIdEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePUT(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePostEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePOST(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePatchEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePATCH(specification, "getValidJsonResource()")»
	«ENDFOR»
		'''
	}
	
	def generateGetQueryEndpoint()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid(methodMid)»
		«testCases.generateGET(specification)»
	«ENDFOR»
		'''
	}
}