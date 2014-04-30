package com.xtext.rest.rdsl.generator.framework

import com.xtext.rest.rdsl.restDsl.ResourceType
import com.xtext.rest.rdsl.restDsl.Configuration

/**
 * Class for representing different resource generators. For Example Jersey and Spring Frameworks get their own ResourceGenerators
 */
interface IResourceGenerator {
	def CharSequence generate(ResourceType resource, Configuration config);
}