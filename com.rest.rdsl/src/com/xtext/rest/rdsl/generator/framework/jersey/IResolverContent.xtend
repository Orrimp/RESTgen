package com.xtext.rest.rdsl.generator.framework.jersey

/**
 * Class to inject code inside a Jersey ContextResolver Provider class. 
 */
interface IResolverContent {
	
	def CharSequence getConstructor();
	
	def CharSequence getName();
	
	def CharSequence getClassName();
	
	def CharSequence getImports();
	
	def CharSequence getClassVariables();
	
	def CharSequence getContextMethod();	
}