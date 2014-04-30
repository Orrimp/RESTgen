package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.generator.ResourceTypeCollection

interface IRESTFramework {
	
	public def void generateResources(ResourceTypeCollection resourceCol);
	public def void generateMisc(ResourceTypeCollection resourceCol);
}