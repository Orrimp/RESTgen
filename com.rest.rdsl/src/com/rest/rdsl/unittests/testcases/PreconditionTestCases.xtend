package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants

class PreconditionTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	val String CORRECT_PRECONDITION_HEADER = Constants.VALID_IF_MATCH_HEADER;
	val String WRONG_PRECONDITION_HEADER = "headers[0].getValue() + \"12\"";
	val String PRECONDITION_MATCHING = "PreconditionMatching";
	val String PRECONDITION_NOT_MATCHING = "PreconditionNotMatching";
	val String PRECONDITION_REQUIRED = "PreconditionRequired";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	def generateDELETECases()
	{
		'''
	«FOR specification: specificationsBuilder.buildSuccessfulDELETE()»
		«specification.setMethodMid(PRECONDITION_MATCHING)»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionFailed()»
		«specification.setMethodMid(PRECONDITION_NOT_MATCHING)»
		«specification.setIfMatchHeader(WRONG_PRECONDITION_HEADER)»
		«testCases.generateDELETE(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionRequired()»
		«specification.setMethodMid(PRECONDITION_REQUIRED)»
		«testCases.generateDELETENonConditional(specification)»
	«ENDFOR»
		'''
	}
	
	def generateGETCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildNotModified()»
		«specification.setMethodMid("ResourceNotModified")»
		«testCases.generateGETConditional(specification, CORRECT_PRECONDITION_HEADER)»
	«ENDFOR»
	
	«FOR specification: specificationsBuilder.buildSuccessfulGET()»
		«specification.setMethodMid("ResourceWasModified")»
		«testCases.generateGETConditional(specification, WRONG_PRECONDITION_HEADER)»
	«ENDFOR»
		'''
	}
	
	def generatePATCHCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildSuccessfulPATCH()»
		«specification.setMethodMid(PRECONDITION_MATCHING)»
		«testCases.generatePATCHWithoutParams(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionFailed()»
		«specification.setMethodMid(PRECONDITION_NOT_MATCHING)»
		«specification.setIfMatchHeader(WRONG_PRECONDITION_HEADER)»
		«testCases.generatePATCHWithoutParams(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionRequired()»
		«specification.setMethodMid(PRECONDITION_REQUIRED)»
		«testCases.generatePATCHNonConditional(specification)»
	«ENDFOR»
		'''
	}
	
	def generatePUTCases()
	{
		'''
	«FOR specification: specificationsBuilder.buildSuccessfulPUT()»
		«specification.setMethodMid(PRECONDITION_MATCHING)»
		«testCases.generatePUT(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionFailed()»
		«specification.setMethodMid(PRECONDITION_NOT_MATCHING)»
		«specification.setIfMatchHeader(WRONG_PRECONDITION_HEADER)»
		«testCases.generatePUT(specification)»
	«ENDFOR»
	«FOR specification: specificationsBuilder.buildPreconditionRequired()»
		«specification.setMethodMid(PRECONDITION_REQUIRED)»
		«testCases.generatePUTNonConditional(specification)»
	«ENDFOR»
		'''
	}
}