package com.xtext.rest.rdsl.generator.internals

import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription

/**
 * Represent an Java Exception with given Exception description. 
 */
interface IExceptionGenerator {
		def void generateCustomException(ExceptionDescription exDesc);
}