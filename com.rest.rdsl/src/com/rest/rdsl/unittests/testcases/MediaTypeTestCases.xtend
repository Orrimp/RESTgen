package com.rest.rdsl.unittests.testcases

import java.util.List

class MediaTypeTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> unsupportedMediaTypeTestCaseSpecifications;
	val String methodMid = "WrongMediaType";
	val String mediaType = "\"text/html\"";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		unsupportedMediaTypeTestCaseSpecifications = specificationsBuilder.buildUnsupportedMediaType;
	}
	
	def generatePATCHCases()
	{
	'''
	«FOR specification: unsupportedMediaTypeTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«specification.setMediaType(mediaType)»
		«testCases.generatePATCH(specification)»
	«ENDFOR»
	'''	
	}
	
	def generatePOSTCases()
	{
	'''
	«FOR specification: unsupportedMediaTypeTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«specification.setMediaType(mediaType)»
		«testCases.generatePOST(specification)»
	«ENDFOR»
	'''	
	}
	
	def generatePUTCases()
	{
	'''
	«FOR specification: unsupportedMediaTypeTestCaseSpecifications»
		«specification.setMethodMid(methodMid)»
		«specification.setMediaType(mediaType)»
		«testCases.generatePUT(specification)»
	«ENDFOR»
	'''	
	}
}