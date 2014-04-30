package com.xtext.rest.rdsl.management

import com.xtext.rest.rdsl.restDsl.ResourceType
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.Type
import com.xtext.rest.rdsl.restDsl.ComplexType
import com.xtext.rest.rdsl.restDsl.Configuration
import com.xtext.rest.rdsl.restDsl.ID_GEN
import com.xtext.rest.rdsl.restDsl.PrimitiveType
import com.xtext.rest.rdsl.restDsl.PrimitiveKind

/**
 * @author Vitaliy
 */
class ExtensionMethods {

    def dispatch String nameOfType(Attribute attribute) {
        if (attribute.list) {
            return listName;
        } else {
            return nameOfType(attribute.type)
        }
    }

    def dispatch String simpleNameOfType(Attribute attribute) {
        return nameOfType(attribute)
    }

    def dispatch nameOfType(PrimitiveType type) {
        if (type.kind == PrimitiveKind.STRING) {
            return "String"
        } else if (type.kind == PrimitiveKind.INT) {
            return "Integer"
        } else if (type.kind == PrimitiveKind.DATE) {
            return "java.util.Date"
        }
    }

    def dispatch simpleNameOfType(PrimitiveType type) {
        return nameOfType(type)
    }

    def dispatch nameOfType(ComplexType type) {
        return type.name;
    }

    def dispatch simpleNameOfType(ComplexType type) {
        return nameOfType(type);
    }

    def getAttributes(ComplexType type) {
        return type.members.filter(Attribute)
    }

    def getListName() {
        return "java.util.ArrayList";
    }

    def getType(Attribute attribute) {
        if (attribute.referencedType == null) {
            return attribute.inlineType;
        }
        return attribute.referencedType;
    }

    /**
	 * Extends the class Configuration with additional method to convert the ID Data Type to the one handle-able in Java. 
	 */
    def String getIDDataTyp(Configuration config) {
        switch (config.getIdtype()) {
            case ID_GEN.LONG: return "Long"
            case ID_GEN.UUID: return "String"
        }
        return "String";
    }
}
