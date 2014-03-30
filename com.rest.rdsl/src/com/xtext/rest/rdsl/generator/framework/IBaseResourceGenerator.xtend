package com.xtext.rest.rdsl.generator.framework

import org.eclipse.xtext.generator.IFileSystemAccess

/**
 * Generator to create base resource. In the abstract or normal methods and attributes can be generated, which can be used by ever resource. 
 */
interface IBaseResourceGenerator {
	
	def void generate(IFileSystemAccess access);
}