package com.xtext.rest.rdsl.management;

import org.eclipse.xtext.xbase.lib.StringExtensions;

public class Constants {
	
	/** Packagename for generating class. It will be overridden with the configuration value for package */
	private static String MAINPACKAGE = "com.rest.generat.";
	
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
}