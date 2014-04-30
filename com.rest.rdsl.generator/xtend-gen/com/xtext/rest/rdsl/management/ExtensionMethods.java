package com.xtext.rest.rdsl.management;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.xtext.rest.rdsl.restDsl.Attribute;
import com.xtext.rest.rdsl.restDsl.ComplexType;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.ID_GEN;
import com.xtext.rest.rdsl.restDsl.Member;
import com.xtext.rest.rdsl.restDsl.PrimitiveKind;
import com.xtext.rest.rdsl.restDsl.PrimitiveType;
import com.xtext.rest.rdsl.restDsl.Type;
import java.util.Arrays;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;

/**
 * @author Vitaliy
 */
@SuppressWarnings("all")
public class ExtensionMethods {
  protected String _nameOfType(final Attribute attribute) {
    boolean _isList = attribute.isList();
    if (_isList) {
      return this.getListName();
    } else {
      Type _type = this.getType(attribute);
      return this.nameOfType(_type);
    }
  }
  
  protected String _simpleNameOfType(final Attribute attribute) {
    return this.nameOfType(attribute);
  }
  
  protected String _nameOfType(final PrimitiveType type) {
    PrimitiveKind _kind = type.getKind();
    boolean _equals = Objects.equal(_kind, PrimitiveKind.STRING);
    if (_equals) {
      return "String";
    } else {
      PrimitiveKind _kind_1 = type.getKind();
      boolean _equals_1 = Objects.equal(_kind_1, PrimitiveKind.INT);
      if (_equals_1) {
        return "Integer";
      } else {
        PrimitiveKind _kind_2 = type.getKind();
        boolean _equals_2 = Objects.equal(_kind_2, PrimitiveKind.DATE);
        if (_equals_2) {
          return "java.util.Date";
        }
      }
    }
    return null;
  }
  
  protected String _simpleNameOfType(final PrimitiveType type) {
    return this.nameOfType(type);
  }
  
  protected String _nameOfType(final ComplexType type) {
    return type.getName();
  }
  
  protected String _simpleNameOfType(final ComplexType type) {
    return this.nameOfType(type);
  }
  
  public Iterable<Attribute> getAttributes(final ComplexType type) {
    EList<Member> _members = type.getMembers();
    return Iterables.<Attribute>filter(_members, Attribute.class);
  }
  
  public String getListName() {
    return "java.util.ArrayList";
  }
  
  public Type getType(final Attribute attribute) {
    Type _referencedType = attribute.getReferencedType();
    boolean _equals = Objects.equal(_referencedType, null);
    if (_equals) {
      return attribute.getInlineType();
    }
    return attribute.getReferencedType();
  }
  
  /**
   * Extends the class Configuration with additional method to convert the ID Data Type to the one handle-able in Java.
   */
  public String getIDDataTyp(final Configuration config) {
    ID_GEN _idtype = config.getIdtype();
    if (_idtype != null) {
      switch (_idtype) {
        case LONG:
          return "Long";
        case UUID:
          return "String";
        default:
          break;
      }
    }
    return "String";
  }
  
  public String nameOfType(final EObject type) {
    if (type instanceof ComplexType) {
      return _nameOfType((ComplexType)type);
    } else if (type instanceof PrimitiveType) {
      return _nameOfType((PrimitiveType)type);
    } else if (type instanceof Attribute) {
      return _nameOfType((Attribute)type);
    } else {
      throw new IllegalArgumentException("Unhandled parameter types: " +
        Arrays.<Object>asList(type).toString());
    }
  }
  
  public String simpleNameOfType(final EObject type) {
    if (type instanceof ComplexType) {
      return _simpleNameOfType((ComplexType)type);
    } else if (type instanceof PrimitiveType) {
      return _simpleNameOfType((PrimitiveType)type);
    } else if (type instanceof Attribute) {
      return _simpleNameOfType((Attribute)type);
    } else {
      throw new IllegalArgumentException("Unhandled parameter types: " +
        Arrays.<Object>asList(type).toString());
    }
  }
}
