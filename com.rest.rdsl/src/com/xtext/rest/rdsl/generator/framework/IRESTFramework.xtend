package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.generator.RESTResourceCollection

interface IRESTFramework {
	
	public def void generateResources(RESTResourceCollection resourceCol);
	public def void generateMisc(RESTResourceCollection resourceCol);
}