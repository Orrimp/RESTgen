package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.restDsl.CACHING_TYPE;
import com.xtext.rest.rdsl.restDsl.Caching;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
public class JerseyCacheGenerator {
  private final RESTResource resource;
  
  private final RESTConfiguration config;
  
  private String response;
  
  private String implementatation;
  
  public JerseyCacheGenerator(final RESTResource resource, final RESTConfiguration config) {
    this.resource = resource;
    this.config = config;
    this.initialize();
  }
  
  public String initialize() {
    String _switchResult = null;
    Caching _caching = this.config.getCaching();
    CACHING_TYPE _type = _caching.getType();
    if (_type != null) {
      switch (_type) {
        case ETAG:
          _switchResult = this.generateETAG();
          break;
        case EXPIRES:
          _switchResult = this.generateEXPIRES();
          break;
        case MAXAGE:
          _switchResult = this.generateMAXAGE();
          break;
        case MODIFIED:
          _switchResult = this.generateMODIFIED();
          break;
        case DEFAULT:
          _switchResult = this.generateDEFAULT();
          break;
        case NONE:
          _switchResult = "";
          break;
        default:
          return "";
      }
    } else {
      return "";
    }
    return _switchResult;
  }
  
  public String getImplementation() {
    return this.implementatation;
  }
  
  public String getResponse() {
    return this.response;
  }
  
  private String generateDEFAULT() {
    String _xblockexpression = null;
    {
      String _generateMODIFIED = this.generateMODIFIED();
      String _generateEXPIRES = this.generateEXPIRES();
      String _plus = (_generateMODIFIED + _generateEXPIRES);
      String _generateETAG = this.generateETAG();
      String _plus_1 = (_plus + _generateETAG);
      this.implementatation = _plus_1;
      String _generateMODIFIEDResponse = this.generateMODIFIEDResponse();
      String _generateEXPIRESResponse = this.generateEXPIRESResponse();
      String _plus_2 = (_generateMODIFIEDResponse + _generateEXPIRESResponse);
      String _generateETAGResponse = this.generateETAGResponse();
      String _plus_3 = (_plus_2 + _generateETAGResponse);
      _xblockexpression = this.response = _plus_3;
    }
    return _xblockexpression;
  }
  
  private String generateMODIFIED() {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("ResponseBuilder rb = super.request.evaluatePreconditions(new Date());");
      _builder.newLine();
      _builder.append("//Precondition met results in null");
      _builder.newLine();
      _builder.append("if(rb!= null)");
      _builder.newLine();
      _builder.append("{");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("return  Response.notModified().build();");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.append(" ");
      _builder.newLine();
      this.implementatation = _builder.toString();
      String _generateMODIFIEDResponse = this.generateMODIFIEDResponse();
      _xblockexpression = this.response = _generateMODIFIEDResponse;
    }
    return _xblockexpression;
  }
  
  private String generateMAXAGE() {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("CacheControl cacheControl = new CacheControl();");
      _builder.newLine();
      _builder.append("cacheControl.setMaxAge(");
      Caching _caching = this.config.getCaching();
      String _time = _caching.getTime();
      _builder.append(_time, "");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append(" ");
      _builder.newLine();
      this.implementatation = _builder.toString();
      String _generatesMAXAGEResponse = this.generatesMAXAGEResponse();
      _xblockexpression = this.response = _generatesMAXAGEResponse;
    }
    return _xblockexpression;
  }
  
  private String generateEXPIRES() {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      this.implementatation = _builder.toString();
      String _generateEXPIRESResponse = this.generateEXPIRESResponse();
      _xblockexpression = this.response = _generateEXPIRESResponse;
    }
    return _xblockexpression;
  }
  
  private String generateETAG() {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("String eTagValue = ");
      String _generateETAGValue = this.generateETAGValue();
      _builder.append(_generateETAGValue, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("EntityTag eTag = new EntityTag(eTagValue);");
      _builder.newLine();
      _builder.append("eTagValue = \"\" + eTag.hashCode();");
      _builder.newLine();
      _builder.newLine();
      _builder.append("ResponseBuilder rb = super.request.evaluatePreconditions(eTag);");
      _builder.newLine();
      _builder.append("//Precondition met results in null");
      _builder.newLine();
      _builder.append("if(rb!= null)");
      _builder.newLine();
      _builder.append("{");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("return  Response.notModified(eTag).build();");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.append(" ");
      _builder.newLine();
      this.implementatation = _builder.toString();
      String _generateETAGResponse = this.generateETAGResponse();
      _xblockexpression = this.response = _generateETAGResponse;
    }
    return _xblockexpression;
  }
  
  private String generateETAGValue() {
    String _name = this.resource.getName();
    String _firstLower = StringExtensions.toFirstLower(_name);
    String _plus = (_firstLower + ".");
    String _plus_1 = (_plus + Naming.METHOD_NAME_ID_GET);
    String _plus_2 = (_plus_1 + "()");
    String _plus_3 = (_plus_2 + " + \"");
    String _name_1 = this.resource.getName();
    String _plus_4 = (_plus_3 + _name_1);
    String _plus_5 = (_plus_4 + "\"");
    String _plus_6 = (_plus_5 + " + ");
    return (_plus_6 + "new Date()");
  }
  
  private String generateMODIFIEDResponse() {
    return ".lastModified(new Date())";
  }
  
  private String generatesMAXAGEResponse() {
    return ".cacheControl(cacheControl)";
  }
  
  private String generateEXPIRESResponse() {
    return ".expires(new Date())";
  }
  
  private String generateETAGResponse() {
    return ".tag(eTagValue)";
  }
}
