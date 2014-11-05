package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.ArrayList
import java.util.List

class AuthorizationTestCases
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	val TestCases testCases;
	val SpecificationsBuilder specificationsBuilder;
	
	private List<String> validAuthorizations;
	private int validCount;
	private List<String> unauthorizedAuthorizations;
	private int unauthorizedCount;
	private List<String> forbiddenAuthorizations;
	private int forbiddenCount;
	private List<String> badRequestAuthorizations;
	private int badRequestCount;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		initAuthorizations();
		testCases = new TestCases();
		specificationsBuilder = new SpecificationsBuilder(testCasePrefix, testCaseUrl);
	}
	
	private def initAuthorizations()
	{
		validAuthorizations = new ArrayList<String>();
		validAuthorizations.add("root:0000");
		validCount = validAuthorizations.size();
		
		unauthorizedAuthorizations = new ArrayList<String>();
		unauthorizedAuthorizations.add("root:akjkdf");
		unauthorizedAuthorizations.add("root:");
		unauthorizedAuthorizations.add("Root:0000");
		unauthorizedAuthorizations.add("Root:akjkdf");
		unauthorizedAuthorizations.add("Root:");
		unauthorizedAuthorizations.add(":0000");
		unauthorizedAuthorizations.add(":akjkdf");
		unauthorizedAuthorizations.add(":");
		unauthorizedCount = unauthorizedAuthorizations.size();
		
		forbiddenAuthorizations = new ArrayList<String>();
		forbiddenCount = forbiddenAuthorizations.size();
		
		badRequestAuthorizations = new ArrayList<String>();
		badRequestAuthorizations.add("");
		badRequestCount = badRequestAuthorizations.size();
	}
		
	def generateGETCases()
	{
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulGET()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generateGETAttributeCases()
	{
		val String junitParams = "method = \"" + Constants.PRIMITIVE_ATTRIBUTE_PARAMS + "\"";
		val String methodParams = "String attribute";
		
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulGETAttribute()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification, junitParams, methodParams)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification, junitParams, methodParams)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification, junitParams, methodParams)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGET(specification, junitParams, methodParams)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generateGETQueryCases()
	{
		val String junitParams = "method = \"" + Constants.QUERY_PARAMS + "\""; 
		
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulGETQueryPageOneOfOne()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGETResourceQuery(specification, junitParams, 1, 1)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGETResourceQuery(specification, junitParams, 1, 1)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGETResourceQuery(specification, junitParams, 1, 1)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateGETResourceQuery(specification, junitParams, 1, 1)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generatePOSTCases()
	{
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulPOST()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePOST(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePOST(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePOST(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePOST(specification)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generatePATCHCases()
	{
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulPATCH()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePATCH(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePATCH(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePATCH(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePATCH(specification)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generatePUTCases()
	{
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulPUT()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePUT(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePUT(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePUT(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generatePUT(specification)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
	
	def generateDELETECases()
	{
	'''
	«FOR authorizationHeader: validAuthorizations»
		«FOR specification: specificationsBuilder.buildSuccessfulDELETE()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ValidAuthorization" + validAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateDELETE(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: unauthorizedAuthorizations»
		«FOR specification: specificationsBuilder.buildUnauthorized()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("UnauthorizedAuthorization" + unauthorizedAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateDELETE(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: forbiddenAuthorizations»
		«FOR specification: specificationsBuilder.buildForbidden()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("ForbiddenAuthorization" + forbiddenAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateDELETE(specification)»
		«ENDFOR»
	«ENDFOR»
	«FOR authorizationHeader: badRequestAuthorizations»
		«FOR specification: specificationsBuilder.buildBadRequest()»
			«specification.setAuthorizationHeader(authorizationHeader)»
			«specification.setMethodMid("BadRequestAuthorization" + badRequestAuthorizations.indexOf(authorizationHeader))»
			«testCases.generateDELETE(specification)»
		«ENDFOR»
	«ENDFOR»
	'''
	}
}
