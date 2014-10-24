package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.restDsl.SingleResource
import com.xtext.rest.rdsl.restDsl.RESTState
import com.xtext.rest.rdsl.generator.RESTResourceObjects

/**
 * Class for representing different resource generators. For Example Jersey and Spring Frameworks get their own ResourceGenerators
 */
interface IResourceGenerator {
	def CharSequence generate(RESTResourceObjects allResources, RESTState resource);
}