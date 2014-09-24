package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.List

class IntervallTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> unprocessableEntityTestCaseSpecifications;
	val String lowerBoundParams = "method = \"" + Constants.PRIMITIVES_WITH_LOWER_BOUND_PARAMS + "\"";
	val String upperBoundParams = "method = \"" + Constants.PRIMITIVES_WITH_UPPER_BOUND_PARAMS + "\"";
	val String methodParams = "String attribute";
	
	val String lowerBoundMethodMid = "AttributeBelowLimits";
	val String upperBoundMethodMid = "AttributeAboveLimits";
	val String lowerBoundGeneratorCall = "getJsonResourceBelowLimitsFor(attribute)";
	val String upperBoundGeneratorCall = "getJsonResourceAboveLimitsFor(attribute)";
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		unprocessableEntityTestCaseSpecifications = specificationsBuilder.buildUnprocessableEntity();
	}
	
	def generatePATCHCases()
	{
		'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(lowerBoundMethodMid)»
		«testCases.generatePATCH(specification, lowerBoundParams, methodParams, lowerBoundGeneratorCall)»
	«ENDFOR»
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(upperBoundMethodMid)»
		«testCases.generatePATCH(specification, upperBoundParams, methodParams, upperBoundGeneratorCall)»
	«ENDFOR»
		'''	
	}
	
	def generatePOSTCases()
	{
		'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(lowerBoundMethodMid)»
		«testCases.generatePOST(specification, lowerBoundParams, methodParams, lowerBoundGeneratorCall)»
	«ENDFOR»
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(upperBoundMethodMid)»
		«testCases.generatePOST(specification, upperBoundParams, methodParams, upperBoundGeneratorCall)»
	«ENDFOR»
		'''
	}
	
	def generatePUTCases()
	{
		'''
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(lowerBoundMethodMid)»
		«testCases.generatePUT(specification, lowerBoundParams, methodParams, lowerBoundGeneratorCall)»
	«ENDFOR»
	«FOR specification: unprocessableEntityTestCaseSpecifications»
		«specification.setMethodMid(upperBoundMethodMid)»
		«testCases.generatePUT(specification, upperBoundParams, methodParams, upperBoundGeneratorCall)»
	«ENDFOR»
		'''
	}
}