package com.xtext.rest.rdsl.management

import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.ID_GEN
import com.xtext.rest.rdsl.restDsl.JavaType
import com.xtext.rest.rdsl.restDsl.ResourceType
import com.xtext.rest.rdsl.restDsl.RESTResource
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.PrimitiveType
import com.xtext.rest.rdsl.restDsl.IntType
import com.xtext.rest.rdsl.restDsl.StringType
import com.xtext.rest.rdsl.restDsl.DateType

/**
 * @author Vitaliy
 * Class for with extension methods for ResourceReference, JavaReference
 */
class ExtensionMethods {

    /** 
	 * @param Reference from type Resource from the dsl
	 * @return returns the name of the reference
	 */

    
    def dispatch String nameOfType(Attribute ref) {
        if(ref.list) {
            return listName;
        } else {
            return nameOfType(ref.type)
        }
    }
    
    def dispatch String simpleNameOfType(Attribute ref) {
        if(ref.list) {
            return listName;
        } else {
            return simpleNameOfType(ref.type)
        }
    }
    
    def dispatch nameOfType(ResourceType ref) {
        return ref?.resourceRef?.name;
    }

    def dispatch nameOfType(IntType ref) {
        return "Integer";
    }

    def dispatch nameOfType(StringType ref) {
        return "String";
    }

    def dispatch nameOfType(DateType ref) {
        return "java.util.Date";
    }

    def dispatch simpleNameOfType(JavaType ref) {
        return ref?.javaDataType?.simpleName
    }

    def dispatch simpleNameOfType(IntType ref) {
        return nameOfType(ref);
    }

    def dispatch simpleNameOfType(StringType ref) {
        return nameOfType(ref);
    }

    def dispatch simpleNameOfType(ResourceType ref) {
        return nameOfType(ref)
    }

    def dispatch simpleNameOfType(DateType ref) {
        return nameOfType(ref);
    }

    def dispatch getAttributes(RESTResource resource) {
        return resource.members.filter(Attribute)
    }
    
    def getListName() {
        return "java.util.ArrayList";
    }

    /**
	 * Extends the class RESTConfiguration with additional method to convert the ID Data Type to the one handle-able in Java. 
	 */
    def String getIDDataTyp(RESTConfiguration config) {
        switch (config.getIdtype()) {
            case ID_GEN.LONG: return "Long"
            case ID_GEN.UUID: return "String"
        }
        return "String";
    }
}
