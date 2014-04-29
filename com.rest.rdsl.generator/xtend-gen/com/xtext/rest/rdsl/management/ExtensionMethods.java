package com.xtext.rest.rdsl.management;

import com.google.common.collect.Iterables;
import com.xtext.rest.rdsl.restDsl.Attribute;
import com.xtext.rest.rdsl.restDsl.DateType;
import com.xtext.rest.rdsl.restDsl.ID_GEN;
import com.xtext.rest.rdsl.restDsl.IntType;
import com.xtext.rest.rdsl.restDsl.JavaType;
import com.xtext.rest.rdsl.restDsl.Member;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import com.xtext.rest.rdsl.restDsl.StringType;
import com.xtext.rest.rdsl.restDsl.Type;
import java.util.Arrays;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.common.types.JvmType;

/**
 * @author Vitaliy
 * Class for with extension methods for ResourceReference, JavaReference
 */
@SuppressWarnings("all")
public class ExtensionMethods {
  /**
   * @param Reference from type Resource from the dsl
   * @return returns the name of the reference
   */
  protected String _nameOfType(final Attribute ref) {
    boolean _isList = ref.isList();
    if (_isList) {
      return this.getListName();
    } else {
      Type _type = ref.getType();
      return this.nameOfType(_type);
    }
  }
  
  protected String _simpleNameOfType(final Attribute ref) {
    boolean _isList = ref.isList();
    if (_isList) {
      return this.getListName();
    } else {
      Type _type = ref.getType();
      return this.simpleNameOfType(_type);
    }
  }
  
  protected String _nameOfType(final ResourceType ref) {
    RESTResource _resourceRef = null;
    if (ref!=null) {
      _resourceRef=ref.getResourceRef();
    }
    String _name = null;
    if (_resourceRef!=null) {
      _name=_resourceRef.getName();
    }
    return _name;
  }
  
  protected String _nameOfType(final IntType ref) {
    return "Integer";
  }
  
  protected String _nameOfType(final StringType ref) {
    return "String";
  }
  
  protected String _nameOfType(final DateType ref) {
    return "java.util.Date";
  }
  
  protected String _simpleNameOfType(final JavaType ref) {
    JvmType _javaDataType = null;
    if (ref!=null) {
      _javaDataType=ref.getJavaDataType();
    }
    String _simpleName = null;
    if (_javaDataType!=null) {
      _simpleName=_javaDataType.getSimpleName();
    }
    return _simpleName;
  }
  
  protected String _simpleNameOfType(final IntType ref) {
    return this.nameOfType(ref);
  }
  
  protected String _simpleNameOfType(final StringType ref) {
    return this.nameOfType(ref);
  }
  
  protected String _simpleNameOfType(final ResourceType ref) {
    return this.nameOfType(ref);
  }
  
  protected String _simpleNameOfType(final DateType ref) {
    return this.nameOfType(ref);
  }
  
  protected Iterable<Attribute> _getAttributes(final RESTResource resource) {
    EList<Member> _members = resource.getMembers();
    return Iterables.<Attribute>filter(_members, Attribute.class);
  }
  
  public String getListName() {
    return "java.util.ArrayList";
  }
  
  /**
   * Extends the class RESTConfiguration with additional method to convert the ID Data Type to the one handle-able in Java.
   */
  public String getIDDataTyp(final RESTConfiguration config) {
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
  
  public String nameOfType(final EObject ref) {
    if (ref instanceof DateType) {
      return _nameOfType((DateType)ref);
    } else if (ref instanceof IntType) {
      return _nameOfType((IntType)ref);
    } else if (ref instanceof StringType) {
      return _nameOfType((StringType)ref);
    } else if (ref instanceof Attribute) {
      return _nameOfType((Attribute)ref);
    } else if (ref instanceof ResourceType) {
      return _nameOfType((ResourceType)ref);
    } else {
      throw new IllegalArgumentException("Unhandled parameter types: " +
        Arrays.<Object>asList(ref).toString());
    }
  }
  
  public String simpleNameOfType(final EObject ref) {
    if (ref instanceof DateType) {
      return _simpleNameOfType((DateType)ref);
    } else if (ref instanceof IntType) {
      return _simpleNameOfType((IntType)ref);
    } else if (ref instanceof StringType) {
      return _simpleNameOfType((StringType)ref);
    } else if (ref instanceof Attribute) {
      return _simpleNameOfType((Attribute)ref);
    } else if (ref instanceof JavaType) {
      return _simpleNameOfType((JavaType)ref);
    } else if (ref instanceof ResourceType) {
      return _simpleNameOfType((ResourceType)ref);
    } else {
      throw new IllegalArgumentException("Unhandled parameter types: " +
        Arrays.<Object>asList(ref).toString());
    }
  }
  
  public Iterable<Attribute> getAttributes(final RESTResource resource) {
    {
      return _getAttributes(resource);
    }
  }
}
