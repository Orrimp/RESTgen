package com.xtext.rest.rdsl.management;

import org.eclipse.xtext.xbase.lib.StringExtensions;

public class Constants {
	
	/** Packagename for generating class. It will be overridden with the configuration value for package */
	private static String MAINPACKAGE = "com.rest";
	
	public static void setMainPackage(String mainPackage){
		if(!StringExtensions.isNullOrEmpty(mainPackage))
			MAINPACKAGE = mainPackage;
	}
	
	public static String getMainPackage(){ 
		return MAINPACKAGE;
	}
	
	public static final String APPLICATION ="application/";
	public static final String JAVA  =".java";
	public static final String OBJECTPACKAGE = "objects";
	public static final String CLIENTPACKAGE = "client";
	public static final String RESOURCEPACKAGE = "resources";
	public static final String EXCEPTIONPACKAGE = "exceptions";
	public static final String INTERFACEPACKAGE = "interfaces";
	public static final String AUTHPACKAGE = "authentication";
	public static final String DAOPACKAGE= "database";
	public static final String LONG_COUTNER_VALUE = "1";
	public static final String WEBPACKAGE = "web";
	public static final String FRAMEWORKPACKAGE = "framework";
	
	public static final String UNITTESTPACKAGE = "unittests";
	public static final String DATAGENERATORPACKAGE = "datagenerator";
	public static final String DATEDATAPACKAGE = "datagenerator.datedata";
	public static final String DOUBLEDATAPACKAGE = "datagenerator.doubledata";
	public static final String LONGDATAPACKAGE = "datagenerator.longdata";
	public static final String STRINGDATAPACKAGE = "datagenerator.stringdata";
	public static final String PERFORMANCEPACKAGE = "performance";
	public static final String UTILITYPACKAGE = "utility";
	
	public static final String VALID_AUTHORIZATION = "root:0000";
	public static final String VALID_IF_MATCH_HEADER = "headers[0].getValue()";
	public static final String DEFAULT_MEDIA_TYPE = "MediaType.APPLICATION_JSON";
	
	public static final String PRIMITIVE_ATTRIBUTE_PARAMS = "getPrimitiveAttributes";
	public static final String PRIMITIVES_WITH_LOWER_BOUND_PARAMS = "getPrimitivesWithLowerBound";
	public static final String PRIMITIVES_WITH_UPPER_BOUND_PARAMS = "getPrimitivesWithUpperBound";
	public static final String STRING_ATTRIBUTE_PARAMS = "getStringAttributes";
	public static final String STRING_ATTRIBUTE_WITH_CONTEXT_PARAMS = "getStringAttributesWithContext";
	public static final String NON_STRING_ATTRIBUTE_PARAMS = "getNonStringAttributes";
	public static final String PERMUTATED_PATCH_PARAMS = "permutatedPatchResources";
	public static final String QUERY_PARAMS = "getQueryParameters";
}