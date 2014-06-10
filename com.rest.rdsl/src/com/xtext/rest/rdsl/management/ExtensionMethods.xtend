package com.xtext.rest.rdsl.management

import com.xtext.rest.rdsl.restDsl.ID_GEN
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.Reference
import com.xtext.rest.rdsl.restDsl.ResourceReference
import com.xtext.rest.rdsl.restDsl.PrimitiveType

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
		return ref?.javaDataType?.literal;
	}
	
	def dispatch String fullNameOfType(JavaReference reference){
		return fullJavaNameOfType(reference?.javaDataType)
	}
	
	def String nameOfInnerType(ListReference ref){
		if(ref.innerType.primitiveType != null){
			return ref.innerType.primitiveType.literal
		}else{
			return ref.innerType.resource.name
		}
		
	}
	
	def String fullNameOfInnerType(ListReference ref){
		fullJavaNameOfType(ref?.innerType?.primitiveType)
	}

	
	private def fullJavaNameOfType(PrimitiveType pType) {
		switch(pType){
			case STRING: return "java.lang.String"
			case DATE: return "java.util.Date"
			case INT: return ""
			case FLOAT: return ""
		}
	}

	/**
	 * Extends the class RESTConfiguration with additional method to convert the ID Data Type to the one handle-able in Java. 
	 */
	def String getIDDataTyp(RESTConfiguration config){
		switch(config.getIdtype()){
			case ID_GEN.LONG: return "Long"
			case ID_GEN.UUID: return "String" 			
		}
		return "String";
	}
}