package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants

class OutlierTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	def generateDELETECases()
	{
		'''
	«FOR specification: specificationsBuilder.buildSuccessfulDELETE()»
		«specification.setMethodMid("ResourceNotFound")»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
		'''
	}
	
	def generateGETCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildNotFound()»
		«specification.setMethodMid("ResourceNotFound")»
		«testCases.generateGET(specification)»
	«ENDFOR»
		'''
	}
	
	def generateGETAttributeCases()
	{
		val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
		val String methodParams = "String attribute";
		
		'''
	«FOR specification: specificationsBuilder.buildNotFound()»
		«specification.setMethodMid("ResourceNotFound")»
		«testCases.generateGET(specification, junitParams, methodParams)»
	«ENDFOR»
		'''
	}
	
	def generateGETQueryCases()
	{
		val String junitParams = "method = \"" + Constants.QUERY_PARAMS + "\"";
		
		'''
	«FOR specification: specificationsBuilder.buildSuccessfulGETQueryPageOneOfTwo»
		«specification.setMethodMid("PageOneOfTwo")»
		«testCases.generateGETResourceQuery(specification, junitParams, 2, 1)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildSuccessfulGETQueryPageTwoOfTwo»
		«specification.setMethodMid("PageTwoOfTwo")»
		«testCases.generateGETResourceQuery(specification, junitParams, 2, 2)»
	«ENDFOR»
		'''
	}
	
	def generatePATCHCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildNotFound()»
		«specification.setMethodMid("ResourceNotFound")»
		«testCases.generatePATCHNotFound(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid("ResourceHasNoId")»
		«testCases.generatePATCHNoId(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePOSTCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildInternalServerError()»
		«specification.setMethodMid("ResourceAlreadyExists")»
		«testCases.generatePOSTAlreadyExists(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePUTCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildCreated(0L)»
		«specification.setMethodMid("CreatedNotExistingResource")»
		«testCases.generatePUTCreated(specification)»
	«ENDFOR»
		'''
	}
}