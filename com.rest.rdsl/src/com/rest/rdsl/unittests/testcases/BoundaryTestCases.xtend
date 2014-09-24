package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.HashMap
import java.util.List
import java.util.Map

class BoundaryTestCases 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases = new TestCases();
	val SpecificationsBuilder specificationsBuilder;
	
	private List<TestCaseSpecification> unprocessableEntityTestCaseSpecifications;
	val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
	val String lowerBoundParams = "method = \"" + Constants.PRIMITIVES_WITH_LOWER_BOUND_PARAMS + "\"";
	val String upperBoundParams = "method = \"" + Constants.PRIMITIVES_WITH_UPPER_BOUND_PARAMS + "\"";
	val String methodParams = "String attribute";
	
	val String lowerBoundMethodMid = "AttributeBelowLowerBound";
	val String upperBoundMethodMid = "AttributeAboveUpperBound";
	val String lowerBoundGeneratorCall = "getJsonResourceBelowLowerBoundFor(attribute)";
	val String upperBoundGeneratorCall = "getJsonResourceAboveLowerBoundFor(attribute)";
	
	private Map<String,String> generatorCalls = new HashMap<String,String>()
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
		unprocessableEntityTestCaseSpecifications = specificationsBuilder.buildUnprocessableEntity();
		
		initGeneratorCalls();
	}
	
	private def initGeneratorCalls()
	{
		generatorCalls.put("AttributeAtLowerBound", "getJsonResourceAtLowerBoundFor(attribute)");
		generatorCalls.put("AttributeAboveLowerBound", "getJsonResourceAboveLowerBoundFor(attribute)");
		generatorCalls.put("AttributeBelowUpperBound", "getJsonResourceBelowUpperBoundFor(attribute)");
		generatorCalls.put("AttributeAtUpperBound", "getJsonResourceAtUpperBoundFor(attribute)");
	}
	
	def generatePATCHCases()
	{
		
		'''
	«FOR generatorCall: generatorCalls.entrySet()»
		«FOR specification: specificationsBuilder.buildSuccessfulPATCH()»
			«specification.setMethodMid(generatorCall.getKey())»
			«testCases.generatePATCH(specification, junitParams, methodParams, generatorCall.getValue())»
		«ENDFOR»
	«ENDFOR»
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
	«FOR generatorCall: generatorCalls.entrySet()»
		«FOR specification: specificationsBuilder.buildSuccessfulPOST()»
			«specification.setMethodMid(generatorCall.getKey())»
			«testCases.generatePOST(specification, junitParams, methodParams, generatorCall.getValue())»
		«ENDFOR»
	«ENDFOR»
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
	«FOR generatorCall: generatorCalls.entrySet()»
		«FOR specification: specificationsBuilder.buildSuccessfulPUT()»
			«specification.setMethodMid(generatorCall.getKey())»
			«testCases.generatePUT(specification, junitParams, methodParams, generatorCall.getValue())»
		«ENDFOR»
	«ENDFOR»
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