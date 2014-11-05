package com.rest.rdsl.unittests.testcases

class UnknownAttributeTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases;
	val SpecificationsBuilder specificationsBuilder;
	
	val String methodMid = "UnknownAttribute";
	val String generatorCall = "getJsonResourceWithUnknownAttribute()";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		testCases = new TestCases();
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	def generatePATCHCases()
	{
	'''
	«FOR specification: specificationsBuilder.buildSuccessfulPATCH()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePATCH(specification, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePOSTCases()
	{
	'''
	«FOR specification: specificationsBuilder.buildSuccessfulPOST()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePOST(specification, generatorCall)»
	«ENDFOR»
	'''	
	}
	
	def generatePUTCases()
	{
	'''
	«FOR specification: specificationsBuilder.buildSuccessfulPUT()»
		«specification.setMethodMid(methodMid)»
		«testCases.generatePUT(specification, generatorCall)»
	«ENDFOR»
	'''	
	}	
}