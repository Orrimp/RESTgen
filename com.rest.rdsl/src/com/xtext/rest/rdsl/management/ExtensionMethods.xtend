package com.xtext.rest.rdsl.management

import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.PrimitiveType
import com.xtext.rest.rdsl.restDsl.ResourceReference

/**
 * @author Vitaliy
 * Class for with extension methods for ResourceReference, JavaReference
 */
class ExtensionMethods {
	
	/** 
	 * @param Reference from type Resource from the dsl
	 * @return returns the name of the reference
	 */
	def dispatch String nameOfType(ResourceReference ref){
		return ref?.resourceRef?.name;
	}
	
	/** 
	 * @param Reference from type Java Reference with JvmType
	 * @return returns the name of the reference
	 */
	def dispatch String nameOfType(JavaReference ref){
		return ref?.javaDataType?.dataType.literal;
	}
	
	def dispatch String fullNameOfType(JavaReference reference){
		return fullJavaNameOfType(reference?.javaDataType)
	}

	
	private def fullJavaNameOfType(PrimitiveType pType) {
		switch(pType.dataType){
			case STRING: return "java.lang.String"
			case LONG: return "java.lang.Long"
			case INT: return "java.lang.Integer"
			case FLOAT: return "java.lang.Float"
		}
	}
}