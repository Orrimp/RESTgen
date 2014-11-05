package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Constants
import java.util.ArrayList
import java.util.List

class TestCaseSpecification
{
	@Property private String methodPrefix = "";
	@Property private String methodMid = "";
	@Property private String methodSuffix = "";
	@Property private String targetUrl = "";
	@Property private String authorizationHeader = Constants.VALID_AUTHORIZATION;
	@Property private String ifMatchHeader = Constants.VALID_IF_MATCH_HEADER;
	@Property private List<String> preAssert = new ArrayList<String>();
	@Property private String assertion = "";
	@Property private String mediaType = Constants.DEFAULT_MEDIA_TYPE;
	
	new()
	{}
	
	new(String methodPrefix, String methodSuffix, String targetUrl, String assertion)
	{
		this.methodPrefix = methodPrefix;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.assertion = assertion;
	}
	
	new(String methodPrefix, String methodMid, String methodSuffix, String targetUrl, String assertion)
	{
		this.methodPrefix = methodPrefix;
		this.methodMid = methodMid;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.assertion = assertion;
	}
	
	new(String methodPrefix, String methodSuffix, String targetUrl, List<String> preAssert, String assertion)
	{
		this.methodPrefix = methodPrefix;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.preAssert = preAssert;
		this.assertion = assertion;
	}
	
	new(String methodPrefix, String methodMid, String methodSuffix, String targetUrl, String authorizationHeader, String assertion)
	{
		this.methodPrefix = methodPrefix;
		this.methodMid = methodMid;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.authorizationHeader = authorizationHeader;
		this.assertion = assertion;
	}
	
	new(String methodPrefix, String methodMid, String methodSuffix, String targetUrl, List<String> preAssert, String assertion)
	{
		this.methodPrefix = methodPrefix;
		this.methodMid = methodMid;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.preAssert = preAssert;
		this.assertion = assertion;
	}
	
	new(String methodPrefix, String methodMid, String methodSuffix, String targetUrl, String authorizationHeader, 
		List<String> preAssert, String assertion
	)
	{
		this.methodPrefix = methodPrefix;
		this.methodMid = methodMid;
		this.methodSuffix = methodSuffix;
		this.targetUrl = targetUrl;
		this.authorizationHeader = authorizationHeader;
		this.preAssert = preAssert;
		this.assertion = assertion;
	}
	
	def getMethodName()
	{
		return methodPrefix + "_" + methodMid + "_" + methodSuffix;
	}
}
