package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.restDsl.RESTResource
import com.xtext.rest.rdsl.restDsl.RESTConfiguration

/**
 * Class for representing different resource generators. For Example Jersey and Spring Frameworks get their own ResourceGenerators
 */
interface IResourceGenerator {
	def CharSequence generate(RESTResource resource, RESTConfiguration config);
}