package com.xtext.rest.rdsl.management

import com.xtext.rest.rdsl.restDsl.ResourceReference
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.ID_GEN

/**
 * @author Vitaliy
 * Class for with extension methods for ResourceReference, JavaReference
 */
class ExtensionMethods {
	
	/** 
	 * @param Reference from type Resource from the dsl
	 * @return returns the name of the reference
	 */
	def dispatch nameOfType(ResourceReference ref){
		return ref?.resourceRef?.name;
	}
	
	/** 
	 * @param Reference from type Java Reference with JvmType
	 * @return returns the name of the reference
	 */
	def dispatch nameOfType(JavaReference ref){
		return ref?.javaDataType?.identifier;
	}
	
	def dispatch nameOfType(ListReference ref){
		return ref?.listDataType?.identifier;
	}
	
	def dispatch simpleNameOfType(JavaReference ref){
		return ref?.javaDataType?.simpleName
	}
	
	def dispatch simpleNameOfType(ListReference ref){
		return ref?.listDataType?.simpleName;
	}
	
	def dispatch simpleNameOfType(ResourceReference ref){
		return ref.nameOfType
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