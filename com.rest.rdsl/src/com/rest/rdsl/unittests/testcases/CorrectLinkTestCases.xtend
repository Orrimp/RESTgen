package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants

class CorrectLinkTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	def generateGETIdCases()
	{
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksGET()»
		«specification.setMethodMid("CheckLinks")»
		«testCases.generateGET(specification)»
	«ENDFOR»
		'''
	}
	
	def generateGETAttributeCases()
	{
		val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
		val String methodParams = "String attribute";
		
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksGET()»
		«specification.setMethodMid("CheckLinks")»
		«testCases.generateGET(specification, junitParams, methodParams)»
	«ENDFOR»
		'''
	}
	
	def generateGETQueryCases()
	{
		val String junitParams = "method = \"" + Constants.QUERY_PARAMS + "\"";
		
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksGETQuery()»
		«specification.setMethodMid("CheckLinksOneOfOnePages")»
		«testCases.generateGETResourceQuery(specification, junitParams, 1, 1)»
	«ENDFOR»
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksGETQuery()»
		«specification.setMethodMid("CheckLinksOneOfTwoPages")»
		«testCases.generateGETResourceQuery(specification, junitParams, 2, 1)»
	«ENDFOR»
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksGETQuery()»
		«specification.setMethodMid("CheckLinksTwoOfTwoPages")»
		«testCases.generateGETResourceQuery(specification, junitParams, 2, 2)»
	«ENDFOR»
		'''
	}
	
	def generatePUTIdCases()
	{
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksPUT()»
		«specification.setMethodMid("UpdatedResource")»
		«testCases.generatePUT(specification)»
	«ENDFOR»
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksCreated()»
		«specification.setMethodMid("CreatedResource")»
		«testCases.generatePUTCreated(specification)»
	«ENDFOR»
		'''		
	}
	
	def generatePOSTCases()
	{
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksCreated()»
		«specification.setMethodMid("CheckLinks")»
		«testCases.generatePOST(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePATCHCases()
	{
		'''
	«FOR specification: new SpecificationsBuilder(testCasePrefix, testCaseUrl).buildLinksPATCH()»
		«specification.setMethodMid("CheckLinks")»
		«testCases.generatePATCH(specification)»
	«ENDFOR»
		'''
	}
}