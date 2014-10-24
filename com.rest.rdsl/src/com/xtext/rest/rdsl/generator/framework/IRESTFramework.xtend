package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.generator.RESTResourceObjects

interface IRESTFramework {
	
	public def void generateResources(RESTResourceObjects resourceCol);
	public def void generateMisc(RESTResourceObjects resourceCol);
}