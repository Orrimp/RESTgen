package com.xtext.rest.rdsl.generator.framework.jersey;

import com.google.common.base.Objects;
import com.xtext.rest.rdsl.generator.framework.MethodGenerator;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyCacheGenerator;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionMapper;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.restDsl.Attribute;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.HTTPMETHOD;
import com.xtext.rest.rdsl.restDsl.Header;
import com.xtext.rest.rdsl.restDsl.MIME;
import com.xtext.rest.rdsl.restDsl.Paging;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import com.xtext.rest.rdsl.restDsl.Type;
import java.util.function.Consumer;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
public class JerseyMethodGenerator extends MethodGenerator {
  private Configuration config = null;
  
  private String mime = "";
  
  private int counter = 0;
  
  private final String idRegex;
  
  private final String idDataType;
  
  private final ExceptionMapper mapper;
  
  private final String resourceName;
  
  private final ResourceType resource;
  
  private final JerseyCacheGenerator caching;
  
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  public JerseyMethodGenerator(final Configuration configuration, final ResourceType resource) {
    this.config = configuration;
    ExceptionMapper _exceptionMapper = new ExceptionMapper(configuration);
    this.mapper = _exceptionMapper;
    this.resource = resource;
    String _name = resource.getName();
    this.resourceName = _name;
    String _createMime = this.createMime();
    this.mime = _createMime;
    String _createRegex = this.createRegex();
    this.idRegex = _createRegex;
    String _iDDataTyp = this.e.getIDDataTyp(this.config);
    this.idDataType = _iDDataTyp;
    JerseyCacheGenerator _jerseyCacheGenerator = new JerseyCacheGenerator(resource, this.config);
    this.caching = _jerseyCacheGenerator;
  }
  
  public CharSequence generate(final Attribute attribute) {
    CharSequence _switchResult = null;
    HTTPMETHOD _method = attribute.getMethod();
    if (_method != null) {
      switch (_method) {
        case GET:
          _switchResult = this.generateGETAttribute(attribute);
          break;
        case DELETE:
          _switchResult = "";
          break;
        case HEAD:
          _switchResult = this.generateHEAD(attribute);
          break;
        case OPTIONS:
          _switchResult = this.generateOPTIONS(attribute);
          break;
        case DEFAULT:
          _switchResult = this.generateGETAttribute(attribute);
          break;
        case NONE:
          return "";
        default:
          break;
      }
    }
    return _switchResult;
  }
  
  public CharSequence generateGETAttribute(final Attribute attribute) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("@GET");
    _builder.newLine();
    _builder.append("@Path(\"/{id ");
    _builder.append(this.idRegex, "");
    _builder.append("}/");
    String _name = attribute.getName();
    _builder.append(_name, "");
    _builder.append("\")");
    _builder.newLineIfNotEmpty();
    _builder.append("@Produces(");
    _builder.append(this.mime, "");
    _builder.append(")");
    _builder.newLineIfNotEmpty();
    _builder.append("@");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public Response get");
    String _name_1 = this.getName(attribute);
    String _firstUpper = StringExtensions.toFirstUpper(_name_1);
    _builder.append(_firstUpper, "");
    _builder.append("(@PathParam(\"id\") ");
    _builder.append(this.idDataType, "");
    _builder.append(" id){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    String _firstUpper_1 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_1, "\t");
    _builder.append(" ");
    String _firstLower = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower, "\t");
    _builder.append(" = null;");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("try{");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("\t\t");
    String _firstLower_1 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_1, "\t\t");
    _builder.append(" = ");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_2 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_2, "\t\t");
    _builder.append("DAO().load(id); ");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}catch(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    ExceptionDescription _get = this.mapper.get(Integer.valueOf(400));
    String _name_2 = _get.getName();
    _builder.append(_name_2, "\t\t");
    _builder.append(" customEx = new  ");
    ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
    String _name_3 = _get_1.getName();
    _builder.append(_name_3, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("customEx.setInnerException(ex);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("throw customEx;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("if(");
    String _firstLower_2 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_2, "\t");
    _builder.append(" == null){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("throw new ");
    ExceptionDescription _get_2 = this.mapper.get(Integer.valueOf(404));
    String _name_4 = _get_2.getName();
    _builder.append(_name_4, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("//Generate ETag");
    _builder.newLine();
    _builder.append("\t");
    Type _type = this.e.getType(attribute);
    String _nameOfType = this.e.nameOfType(_type);
    _builder.append(_nameOfType, "\t");
    _builder.append(" ");
    String _name_5 = attribute.getName();
    String _firstLower_3 = StringExtensions.toFirstLower(_name_5);
    _builder.append(_firstLower_3, "\t");
    _builder.append(" = ");
    String _firstLower_4 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_4, "\t");
    _builder.append(".get");
    String _name_6 = attribute.getName();
    String _firstUpper_3 = StringExtensions.toFirstUpper(_name_6);
    _builder.append(_firstUpper_3, "\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return Response.ok(");
    String _name_7 = attribute.getName();
    String _firstLower_5 = StringExtensions.toFirstLower(_name_7);
    _builder.append(_firstLower_5, "\t");
    _builder.append(").links(getLinks(");
    String _firstLower_6 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_6, "\t");
    _builder.append("))");
    String _header = this.getHeader();
    _builder.append(_header, "\t");
    _builder.append(".build();");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  private CharSequence generateHEAD(final Attribute attribute) {
    StringConcatenation _builder = new StringConcatenation();
    return _builder;
  }
  
  private CharSequence generateOPTIONS(final Attribute attribute) {
    StringConcatenation _builder = new StringConcatenation();
    return _builder;
  }
  
  public CharSequence generateDELETE() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@DELETE");
    _builder.newLine();
    _builder.append("@Path(\"/{id ");
    _builder.append(this.idRegex, "");
    _builder.append("}\")");
    _builder.newLineIfNotEmpty();
    _builder.append("@");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public Response deleteId(@PathParam(\"id\") ");
    _builder.append(this.idDataType, "");
    _builder.append(" id){  \t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("try{\t\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
    _builder.append(".getInstance().create");
    String _firstUpper = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper, "\t\t");
    _builder.append("DAO().delete(id);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return Response.noContent()");
    String _header = this.getHeader();
    _builder.append(_header, "\t\t");
    _builder.append(".build();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}catch(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    ExceptionDescription _get = this.mapper.get(Integer.valueOf(400));
    String _name = _get.getName();
    _builder.append(_name, "\t\t");
    _builder.append(" customEx = new  ");
    ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
    String _name_1 = _get_1.getName();
    _builder.append(_name_1, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("customEx.setInnerException(ex);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("throw customEx;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence generateGET() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@GET");
    _builder.newLine();
    _builder.append("@Path(\"/{id ");
    _builder.append(this.idRegex, "");
    _builder.append("}\")");
    _builder.newLineIfNotEmpty();
    _builder.append("@Produces(");
    _builder.append(this.mime, "");
    _builder.append(")");
    _builder.newLineIfNotEmpty();
    _builder.append("@");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public Response getId(@PathParam(\"id\") ");
    _builder.append(this.idDataType, "");
    _builder.append(" id){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("try{");
    _builder.newLine();
    _builder.append("\t\t");
    String _firstUpper = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper, "\t\t");
    _builder.append(" ");
    String _firstLower = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower, "\t\t");
    _builder.append(" = ");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_1 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_1, "\t\t");
    _builder.append("DAO().load(id); ");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if(");
    String _firstLower_1 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_1, "\t\t");
    _builder.append(" == null)");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("throw new ");
    ExceptionDescription _get = this.mapper.get(Integer.valueOf(404));
    String _name = _get.getName();
    _builder.append(_name, "\t\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    String _implementation = this.caching.getImplementation();
    _builder.append(_implementation, "\t\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return Response.ok(");
    String _lowerCase = this.resourceName.toLowerCase();
    _builder.append(_lowerCase, "\t\t");
    _builder.append(").links(getLinks(");
    String _firstLower_2 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_2, "\t\t");
    _builder.append("))");
    String _response = this.caching.getResponse();
    _builder.append(_response, "\t\t");
    String _header = this.getHeader();
    _builder.append(_header, "\t\t");
    _builder.append(".build();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}catch(");
    ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(404));
    String _name_1 = _get_1.getName();
    _builder.append(_name_1, "\t");
    _builder.append(" ext){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("throw ext;");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}catch(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    ExceptionDescription _get_2 = this.mapper.get(Integer.valueOf(400));
    String _name_2 = _get_2.getName();
    _builder.append(_name_2, "\t\t");
    _builder.append(" customEx = new  ");
    ExceptionDescription _get_3 = this.mapper.get(Integer.valueOf(400));
    String _name_3 = _get_3.getName();
    _builder.append(_name_3, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("customEx.setInnerException(ex);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("throw customEx;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  /**
   * Generates a method for List<Object> support. The client can request multiple resources at once
   */
  public CharSequence generateQuery(final Attribute attribute) {
    CharSequence _xblockexpression = null;
    {
      Type _type = this.e.getType(attribute);
      ResourceType type = ((ResourceType) _type);
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("@GET");
      _builder.newLine();
      _builder.append("@Path(\"/{id ");
      _builder.append(this.idRegex, "");
      _builder.append("}/");
      String _name = type.getName();
      String _lowerCase = _name.toLowerCase();
      _builder.append(_lowerCase, "");
      _builder.append("/{page}\")");
      _builder.newLineIfNotEmpty();
      _builder.append("@Produces(");
      _builder.append(this.mime, "");
      _builder.append(")");
      _builder.newLineIfNotEmpty();
      _builder.append("@");
      _builder.append(Naming.ANNO_USER_AUTH, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public Response get");
      String _name_1 = type.getName();
      String _firstUpper = StringExtensions.toFirstUpper(_name_1);
      _builder.append(_firstUpper, "");
      _builder.append("(");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes = this.e.getAttributes(type);
        for(final Attribute attrib : _attributes) {
          {
            boolean _isList = attrib.isList();
            boolean _not = (!_isList);
            if (_not) {
              _builder.append("\t");
              _builder.append("@QueryParam(\"");
              String _name_2 = attrib.getName();
              _builder.append(_name_2, "\t");
              _builder.append("\") ");
              Type _type_1 = this.e.getType(attrib);
              String _simpleNameOfType = this.e.simpleNameOfType(_type_1);
              _builder.append(_simpleNameOfType, "\t");
              _builder.append(" ");
              String _name_3 = attrib.getName();
              _builder.append(_name_3, "\t");
              _builder.append(",");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("\t");
      _builder.append("@PathParam(\"page\") int page, @PathParam(\"id\") ");
      String _iDDataTyp = this.e.getIDDataTyp(this.config);
      _builder.append(_iDDataTyp, "\t");
      _builder.append(" id){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("try{");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("int elementsPerPage = ");
      Paging _paging = this.config.getPaging();
      int _elementsCount = _paging.getElementsCount();
      _builder.append(_elementsCount, "\t\t");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append(Naming.CLASS_DB_QUERY, "\t\t");
      _builder.append(" ");
      String _string = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_1 = _string.toLowerCase();
      _builder.append(_lowerCase_1, "\t\t");
      _builder.append("  = new ");
      _builder.append(Naming.CLASS_DB_QUERY, "\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes_1 = this.e.getAttributes(type);
        for(final Attribute attrib_1 : _attributes_1) {
          {
            boolean _isList_1 = attrib_1.isList();
            boolean _not_1 = (!_isList_1);
            if (_not_1) {
              _builder.append("\t\t");
              String _string_1 = Naming.CLASS_DB_QUERY.toString();
              String _lowerCase_2 = _string_1.toLowerCase();
              _builder.append(_lowerCase_2, "\t\t");
              _builder.append(".put(\"");
              String _name_4 = attrib_1.getName();
              _builder.append(_name_4, "\t\t");
              _builder.append("\", ");
              String _name_5 = attrib_1.getName();
              _builder.append(_name_5, "\t\t");
              _builder.append(");");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("\t\t");
      String _string_2 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_3 = _string_2.toLowerCase();
      _builder.append(_lowerCase_3, "\t\t");
      _builder.append(".setOffset((page*");
      Paging _paging_1 = this.config.getPaging();
      int _elementsCount_1 = _paging_1.getElementsCount();
      _builder.append(_elementsCount_1, "\t\t");
      _builder.append(")-");
      Paging _paging_2 = this.config.getPaging();
      int _elementsCount_2 = _paging_2.getElementsCount();
      _builder.append(_elementsCount_2, "\t\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      String _string_3 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_4 = _string_3.toLowerCase();
      _builder.append(_lowerCase_4, "\t\t");
      _builder.append(".setLimit(");
      Paging _paging_3 = this.config.getPaging();
      int _elementsCount_3 = _paging_3.getElementsCount();
      _builder.append(_elementsCount_3, "\t\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      String _string_4 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_5 = _string_4.toLowerCase();
      _builder.append(_lowerCase_5, "\t\t");
      _builder.append(".setTable(\"");
      _builder.append(this.resourceName, "\t\t");
      _builder.append("\");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("int count = ");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
      _builder.append(".getInstance().create");
      _builder.append(this.resourceName, "\t\t");
      _builder.append("DAO().count(");
      String _string_5 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_6 = _string_5.toLowerCase();
      _builder.append(_lowerCase_6, "\t\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("List<");
      String _name_6 = this.resource.getName();
      _builder.append(_name_6, "\t\t");
      _builder.append("> list = ");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
      _builder.append(".getInstance().create");
      _builder.append(this.resourceName, "\t\t");
      _builder.append("DAO().list(");
      String _string_6 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_7 = _string_6.toLowerCase();
      _builder.append(_lowerCase_7, "\t\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t\t");
      CharSequence _resourceCollectionLinks = this.getResourceCollectionLinks();
      _builder.append(_resourceCollectionLinks, "\t\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("return Response.ok(list).link(previous, \"previous\").link(current, \"current\").link(next, \"next\")");
      _builder.newLine();
      _builder.append("\t\t   ");
      _builder.append(".header(\"x-Collection-Length\", \"\" + list.size())");
      String _header = this.getHeader();
      _builder.append(_header, "\t\t   ");
      _builder.append(".build();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}catch(Exception ex){");
      _builder.newLine();
      _builder.append("\t\t");
      ExceptionDescription _get = this.mapper.get(Integer.valueOf(400));
      String _name_7 = _get.getName();
      _builder.append(_name_7, "\t\t");
      _builder.append(" customEx = new  ");
      ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
      String _name_8 = _get_1.getName();
      _builder.append(_name_8, "\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("customEx.setInnerException(ex);");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("throw customEx;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  /**
   * Generates a method for query support on this object. The client can request multiple resources at once
   */
  public CharSequence generateQuery() {
    CharSequence _xblockexpression = null;
    {
      String _string = Naming.CLASS_DB_QUERY.toString();
      final String querName = _string.toLowerCase();
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("@GET");
      _builder.newLine();
      _builder.append("@Path(\"/query/{page}\")");
      _builder.newLine();
      _builder.append("@Produces(");
      _builder.append(this.mime, "");
      _builder.append(")");
      _builder.newLineIfNotEmpty();
      _builder.append("@");
      _builder.append(Naming.ANNO_USER_AUTH, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public Response get");
      _builder.append(this.resourceName, "");
      _builder.append("Query(");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes = this.e.getAttributes(this.resource);
        for(final Attribute attrib : _attributes) {
          {
            boolean _isList = attrib.isList();
            boolean _not = (!_isList);
            if (_not) {
              _builder.append("\t");
              _builder.append("@QueryParam(\"");
              String _name = attrib.getName();
              _builder.append(_name, "\t");
              _builder.append("\") ");
              Type _type = this.e.getType(attrib);
              String _simpleNameOfType = this.e.simpleNameOfType(_type);
              _builder.append(_simpleNameOfType, "\t");
              _builder.append(" ");
              String _name_1 = attrib.getName();
              _builder.append(_name_1, "\t");
              _builder.append(",");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("\t");
      _builder.append("@PathParam(\"page\") int page){");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("try{");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append(Naming.CLASS_DB_QUERY, "\t");
      _builder.append(" ");
      String _string_1 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase = _string_1.toLowerCase();
      _builder.append(_lowerCase, "\t");
      _builder.append("  = new ");
      _builder.append(Naming.CLASS_DB_QUERY, "\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes_1 = this.e.getAttributes(this.resource);
        for(final Attribute attrib_1 : _attributes_1) {
          {
            boolean _isList_1 = attrib_1.isList();
            boolean _not_1 = (!_isList_1);
            if (_not_1) {
              _builder.append("\t");
              _builder.append(querName, "\t");
              _builder.append(".put(\"");
              String _name_2 = attrib_1.getName();
              _builder.append(_name_2, "\t");
              _builder.append("\", ");
              String _name_3 = attrib_1.getName();
              _builder.append(_name_3, "\t");
              _builder.append(");");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("\t");
      _builder.append(querName, "\t");
      _builder.append(".setOffset((page*");
      Paging _paging = this.config.getPaging();
      int _elementsCount = _paging.getElementsCount();
      _builder.append(_elementsCount, "\t");
      _builder.append(")-");
      Paging _paging_1 = this.config.getPaging();
      int _elementsCount_1 = _paging_1.getElementsCount();
      _builder.append(_elementsCount_1, "\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append(querName, "\t");
      _builder.append(".setLimit(");
      Paging _paging_2 = this.config.getPaging();
      int _elementsCount_2 = _paging_2.getElementsCount();
      _builder.append(_elementsCount_2, "\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append(querName, "\t");
      _builder.append(".setTable(\"");
      _builder.append(this.resourceName, "\t");
      _builder.append("\");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("int count = ");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t");
      _builder.append(".getInstance().create");
      _builder.append(this.resourceName, "\t");
      _builder.append("DAO().count(");
      String _string_2 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_1 = _string_2.toLowerCase();
      _builder.append(_lowerCase_1, "\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence _resourceCollectionLinks = this.getResourceCollectionLinks();
      _builder.append(_resourceCollectionLinks, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("List<");
      String _name_4 = this.resource.getName();
      _builder.append(_name_4, "\t");
      _builder.append("> list = ");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t");
      _builder.append(".getInstance().create");
      _builder.append(this.resourceName, "\t");
      _builder.append("DAO().list(");
      String _string_3 = Naming.CLASS_DB_QUERY.toString();
      String _lowerCase_2 = _string_3.toLowerCase();
      _builder.append(_lowerCase_2, "\t");
      _builder.append(");");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("return Response.ok(list ).link(previous, \"previous\").link(current, \"current\").link(next, \"next\")");
      _builder.newLine();
      _builder.append("\t\t   ");
      _builder.append(".header(\"x-Collection-Length\", \"\" + count)");
      String _header = this.getHeader();
      _builder.append(_header, "\t\t   ");
      _builder.append(".build();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t   ");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}catch(Exception ex){");
      _builder.newLine();
      _builder.append("\t\t");
      ExceptionDescription _get = this.mapper.get(Integer.valueOf(400));
      String _name_5 = _get.getName();
      _builder.append(_name_5, "\t\t");
      _builder.append(" customEx = new  ");
      ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
      String _name_6 = _get_1.getName();
      _builder.append(_name_6, "\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("customEx.setInnerException(ex);");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("throw customEx;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  /**
   * PUT is only usefull with the object.
   * It is bad idea to update attributes with a PUT instead the whole object should be updated.
   * PUT creates no response body, because PUT is only for updating and creating.
   */
  public CharSequence generatePUT() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.newLine();
    _builder.append("@PUT");
    _builder.newLine();
    _builder.append("@Path(\"/{id ");
    _builder.append(this.idRegex, "");
    _builder.append("}\")");
    _builder.newLineIfNotEmpty();
    _builder.append("@Consumes(");
    _builder.append(this.mime, "");
    _builder.append(")");
    _builder.newLineIfNotEmpty();
    _builder.append("@");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public Response put");
    String _firstUpper = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper, "");
    _builder.append("WithId(");
    String _firstUpper_1 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_1, "");
    _builder.append(" ");
    String _firstLower = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower, "");
    _builder.append(", @PathParam(\"id\") ");
    _builder.append(this.idDataType, "");
    _builder.append(" id){");
    _builder.newLineIfNotEmpty();
    _builder.append(" \t");
    _builder.newLine();
    _builder.append("  \t");
    _builder.newLine();
    _builder.append(" \t");
    _builder.append("try{");
    _builder.newLine();
    _builder.append(" \t\t");
    String _firstUpper_2 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_2, " \t\t");
    _builder.append("  res = ");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, " \t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_3 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_3, " \t\t");
    _builder.append("DAO().load(id);");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t \t");
    _builder.append("//No Instance in Database -> Creation");
    _builder.newLine();
    _builder.append("\t \t");
    _builder.append("if(res == null){");
    _builder.newLine();
    _builder.append("\t \t\t");
    _builder.append("throw new ");
    ExceptionDescription _get = this.mapper.get(Integer.valueOf(404));
    String _name = _get.getName();
    _builder.append(_name, "\t \t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t");
    _builder.append("}else{");
    _builder.newLine();
    _builder.append("\t \t\t");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t \t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_4 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_4, "\t \t\t");
    _builder.append("DAO().update(");
    String _firstLower_1 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_1, "\t \t\t");
    _builder.append(", id);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t\t");
    _builder.append("return Response.ok().links(getLinks(");
    String _firstLower_2 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_2, "\t \t\t");
    _builder.append("))");
    String _header = this.getHeader();
    _builder.append(_header, "\t \t\t");
    _builder.append(".build();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t");
    _builder.append("}");
    _builder.newLine();
    _builder.append(" \t");
    _builder.append("}catch(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
    String _name_1 = _get_1.getName();
    _builder.append(_name_1, "\t\t");
    _builder.append(" customEx = new  ");
    ExceptionDescription _get_2 = this.mapper.get(Integer.valueOf(400));
    String _name_2 = _get_2.getName();
    _builder.append(_name_2, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("customEx.setInnerException(ex);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("throw customEx;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  /**
   * POST is only made for creation.
   * As return the client gets NO BODY but a header with a location of the new element.
   */
  public CharSequence generatePOST() {
    CharSequence _xblockexpression = null;
    {
      String _basePath = this.config.getBasePath();
      String _plus = (_basePath + "/");
      String _lowerCase = this.resourceName.toLowerCase();
      String _plus_1 = (_plus + _lowerCase);
      final String uriPart = (_plus_1 + "/");
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("@POST");
      _builder.newLine();
      _builder.append("@");
      _builder.append(Naming.ANNO_USER_AUTH, "");
      _builder.newLineIfNotEmpty();
      _builder.append("@Consumes(");
      _builder.append(this.mime, "");
      _builder.append(")");
      _builder.newLineIfNotEmpty();
      _builder.append("public Response post");
      String _firstUpper = StringExtensions.toFirstUpper(this.resourceName);
      _builder.append(_firstUpper, "");
      _builder.append("(");
      String _firstUpper_1 = StringExtensions.toFirstUpper(this.resourceName);
      _builder.append(_firstUpper_1, "");
      _builder.append(" ");
      String _firstLower = StringExtensions.toFirstLower(this.resourceName);
      _builder.append(_firstLower, "");
      _builder.append("){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("try{");
      _builder.newLine();
      _builder.append("\t\t");
      String _firstUpper_2 = StringExtensions.toFirstUpper(this.resourceName);
      _builder.append(_firstUpper_2, "\t\t");
      _builder.append("  res = ");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t");
      _builder.append(".getInstance().create");
      String _firstUpper_3 = StringExtensions.toFirstUpper(this.resourceName);
      _builder.append(_firstUpper_3, "\t\t");
      _builder.append("DAO().load(");
      String _firstLower_1 = StringExtensions.toFirstLower(this.resourceName);
      _builder.append(_firstLower_1, "\t\t");
      _builder.append(".");
      _builder.append(Naming.METHOD_NAME_ID_GET, "\t\t");
      _builder.append("());");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("if(res==null){");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append(Naming.INTERFACE_ID, "\t\t\t");
      _builder.append(" idGen = new ");
      _builder.append(Naming.CLASS_ID, "\t\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      _builder.append(this.idDataType, "\t\t\t");
      _builder.append(" newID  = idGen.generateID();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      _builder.append("URI newUri = new URI(\"");
      _builder.append(uriPart, "\t\t\t");
      _builder.append("\" + newID);");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      String _firstLower_2 = StringExtensions.toFirstLower(this.resourceName);
      _builder.append(_firstLower_2, "\t\t\t");
      _builder.append(".setID(newID);");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t\t\t");
      _builder.append(".getInstance().create");
      String _firstUpper_4 = StringExtensions.toFirstUpper(this.resourceName);
      _builder.append(_firstUpper_4, "\t\t\t");
      _builder.append("DAO().save(");
      String _firstLower_3 = StringExtensions.toFirstLower(this.resourceName);
      _builder.append(_firstLower_3, "\t\t\t");
      _builder.append(");  ");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      _builder.append("return Response.created(newUri).links(getLinks(");
      String _firstLower_4 = StringExtensions.toFirstLower(this.resourceName);
      _builder.append(_firstLower_4, "\t\t\t");
      _builder.append("))");
      String _header = this.getHeader();
      _builder.append(_header, "\t\t\t");
      _builder.append(".build(); ");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("}else{");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("throw new ");
      ExceptionDescription _get = this.mapper.get(Integer.valueOf(400));
      String _name = _get.getName();
      _builder.append(_name, "\t\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("}\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}catch(Exception ex){");
      _builder.newLine();
      _builder.append("\t\t");
      ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
      String _name_1 = _get_1.getName();
      _builder.append(_name_1, "\t\t");
      _builder.append(" customEx = new  ");
      ExceptionDescription _get_2 = this.mapper.get(Integer.valueOf(400));
      String _name_2 = _get_2.getName();
      _builder.append(_name_2, "\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("customEx.setInnerException(ex);");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("throw customEx;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence generatePATCH() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@PATCH");
    _builder.newLine();
    _builder.append("@");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("@Consumes(");
    _builder.append(this.mime, "");
    _builder.append(")");
    _builder.newLineIfNotEmpty();
    _builder.append("public Response patch");
    String _firstUpper = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper, "");
    _builder.append("(");
    String _firstUpper_1 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_1, "");
    _builder.append(" ");
    String _firstLower = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower, "");
    _builder.append("){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append(" \t");
    _builder.append("try{");
    _builder.newLine();
    _builder.append(" \t\t\t");
    String _firstUpper_2 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_2, " \t\t\t");
    _builder.append("  ");
    String _lowerCase = this.resourceName.toLowerCase();
    _builder.append(_lowerCase, " \t\t\t");
    _builder.append("Retrieved = ");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, " \t\t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_3 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_3, " \t\t\t");
    _builder.append("DAO().load(");
    String _firstLower_1 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_1, " \t\t\t");
    _builder.append(".");
    _builder.append(Naming.METHOD_NAME_ID_GET, " \t\t\t");
    _builder.append("());");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append(" \t");
    _builder.append("//No Instance in Database -> Creation");
    _builder.newLine();
    _builder.append("\t \t");
    _builder.append("if(");
    String _lowerCase_1 = this.resourceName.toLowerCase();
    _builder.append(_lowerCase_1, "\t \t");
    _builder.append("Retrieved == null){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t\t");
    _builder.append("throw new ");
    ExceptionDescription _get = this.mapper.get(Integer.valueOf(404));
    String _name = _get.getName();
    _builder.append(_name, "\t \t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t");
    _builder.append("}else{");
    _builder.newLine();
    _builder.append("\t \t\t");
    String _implementation = this.caching.getImplementation();
    _builder.append(_implementation, "\t \t\t");
    _builder.newLineIfNotEmpty();
    {
      Iterable<Attribute> _attributes = this.e.getAttributes(this.resource);
      for(final Attribute attrib : _attributes) {
        _builder.append("\t \t\t");
        _builder.append("if( ");
        String _firstLower_2 = StringExtensions.toFirstLower(this.resourceName);
        _builder.append(_firstLower_2, "\t \t\t");
        _builder.append(".get");
        String _name_1 = attrib.getName();
        String _firstUpper_4 = StringExtensions.toFirstUpper(_name_1);
        _builder.append(_firstUpper_4, "\t \t\t");
        _builder.append("() == null)");
        _builder.newLineIfNotEmpty();
        _builder.append("\t \t\t");
        _builder.append("\t");
        String _firstLower_3 = StringExtensions.toFirstLower(this.resourceName);
        _builder.append(_firstLower_3, "\t \t\t\t");
        _builder.append(".set");
        String _name_2 = attrib.getName();
        String _firstUpper_5 = StringExtensions.toFirstUpper(_name_2);
        _builder.append(_firstUpper_5, "\t \t\t\t");
        _builder.append("(");
        String _lowerCase_2 = this.resourceName.toLowerCase();
        _builder.append(_lowerCase_2, "\t \t\t\t");
        _builder.append("Retrieved.get");
        String _name_3 = attrib.getName();
        String _firstUpper_6 = StringExtensions.toFirstUpper(_name_3);
        _builder.append(_firstUpper_6, "\t \t\t\t");
        _builder.append("()); ");
        _builder.newLineIfNotEmpty();
        _builder.append("\t \t\t");
        _builder.newLine();
      }
    }
    _builder.append("\t \t\t");
    _builder.append(Naming.ABSTRACT_CLASS_DAO, "\t \t\t");
    _builder.append(".getInstance().create");
    String _firstUpper_7 = StringExtensions.toFirstUpper(this.resourceName);
    _builder.append(_firstUpper_7, "\t \t\t");
    _builder.append("DAO().update(");
    String _lowerCase_3 = this.resourceName.toLowerCase();
    _builder.append(_lowerCase_3, "\t \t\t");
    _builder.append(",  ");
    String _firstLower_4 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_4, "\t \t\t");
    _builder.append(".");
    _builder.append(Naming.METHOD_NAME_ID_GET, "\t \t\t");
    _builder.append("());");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t\t");
    _builder.append("return Response.noContent().links(getLinks(");
    String _firstLower_5 = StringExtensions.toFirstLower(this.resourceName);
    _builder.append(_firstLower_5, "\t \t\t");
    _builder.append("))");
    String _response = this.caching.getResponse();
    _builder.append(_response, "\t \t\t");
    String _header = this.getHeader();
    _builder.append(_header, "\t \t\t");
    _builder.append(".build();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t \t");
    _builder.append("}");
    _builder.newLine();
    _builder.append(" \t");
    _builder.append("}catch(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    ExceptionDescription _get_1 = this.mapper.get(Integer.valueOf(400));
    String _name_4 = _get_1.getName();
    _builder.append(_name_4, "\t\t");
    _builder.append(" customEx = new  ");
    ExceptionDescription _get_2 = this.mapper.get(Integer.valueOf(400));
    String _name_5 = _get_2.getName();
    _builder.append(_name_5, "\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("customEx.setInnerException(ex);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("throw customEx;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    return _builder;
  }
  
  private CharSequence getResourceCollectionLinks() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("URI current = super.uriInfo.getAbsolutePath();");
    _builder.newLine();
    _builder.append("String previous = (page > 1 && count > ");
    Paging _paging = this.config.getPaging();
    int _elementsCount = _paging.getElementsCount();
    _builder.append(_elementsCount, "");
    _builder.append(") ? \"");
    String _basePath = this.config.getBasePath();
    _builder.append(_basePath, "");
    _builder.append("\"  + \t\"/");
    String _name = this.resource.getName();
    String _lowerCase = _name.toLowerCase();
    _builder.append(_lowerCase, "");
    _builder.append("/query/\" + (page-1) : \"\"; ");
    _builder.newLineIfNotEmpty();
    _builder.append("String next= (page*");
    Paging _paging_1 = this.config.getPaging();
    int _elementsCount_1 = _paging_1.getElementsCount();
    _builder.append(_elementsCount_1, "");
    _builder.append(" < count) ? \"");
    String _basePath_1 = this.config.getBasePath();
    _builder.append(_basePath_1, "");
    _builder.append("\" + \t\"/");
    String _name_1 = this.resource.getName();
    String _lowerCase_1 = _name_1.toLowerCase();
    _builder.append(_lowerCase_1, "");
    _builder.append("/query/\" + (page+1) : \"\"; ");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  private String createMime() {
    this.mime = "{";
    EList<MIME> _mimeType = this.config.getMimeType();
    final Consumer<MIME> _function = new Consumer<MIME>() {
      public void accept(final MIME s) {
        String _literal = s.getLiteral();
        String _plus = (((JerseyMethodGenerator.this.mime + "\"") + Constants.APPLICATION) + _literal);
        String _plus_1 = (_plus + "; version=");
        String _apiVersion = JerseyMethodGenerator.this.config.getApiVersion();
        String _plus_2 = (_plus_1 + _apiVersion);
        String _plus_3 = (_plus_2 + "\"");
        String _plus_4 = (_plus_3 + ",");
        JerseyMethodGenerator.this.mime = _plus_4;
      }
    };
    _mimeType.forEach(_function);
    int _length = this.mime.length();
    int _minus = (_length - 1);
    String _substring = this.mime.substring(0, _minus);
    this.mime = _substring;
    this.mime = (this.mime + "}");
    return this.mime;
  }
  
  private String createRegex() {
    String _iDDataTyp = this.e.getIDDataTyp(this.config);
    String _lowerCase = _iDDataTyp.toLowerCase();
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(_lowerCase,"string")) {
        _matched=true;
        return ": [a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+";
      }
    }
    if (!_matched) {
      if (Objects.equal(_lowerCase,"long")) {
        _matched=true;
        return ": d+";
      }
    }
    return "";
  }
  
  private String getName(final Attribute attribute) {
    String _name = attribute.getName();
    boolean _isNullOrEmpty = StringExtensions.isNullOrEmpty(_name);
    boolean _not = (!_isNullOrEmpty);
    if (_not) {
      return attribute.getName();
    } else {
      HTTPMETHOD _method = attribute.getMethod();
      String _string = _method.toString();
      String _upperCase = _string.toUpperCase();
      String _plus = ("method" + _upperCase);
      return (_plus + Integer.valueOf((this.counter + 1)));
    }
  }
  
  private String getHeader() {
    String headers = "";
    EList<Header> _headers = this.config.getHeaders();
    for (final Header head : _headers) {
      String _name = head.getName();
      String _plus = ((headers + ".header(\"") + _name);
      String _plus_1 = (_plus + "\",\"");
      String _value = head.getValue();
      String _plus_2 = (_plus_1 + _value);
      String _plus_3 = (_plus_2 + "\")");
      headers = _plus_3;
    }
    return headers;
  }
}
