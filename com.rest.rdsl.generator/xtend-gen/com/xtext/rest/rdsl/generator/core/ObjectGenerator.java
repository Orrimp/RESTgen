package com.xtext.rest.rdsl.generator.core;

import com.google.common.base.Objects;
import com.xtext.rest.rdsl.generator.core.ObjectParentGenerator;
import com.xtext.rest.rdsl.generator.internals.AnnotationUtils;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.restDsl.Attribute;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import com.xtext.rest.rdsl.restDsl.Type;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
public class ObjectGenerator {
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  private final ResourceType resource;
  
  private final Configuration config;
  
  private final ObjectParentGenerator parent;
  
  private final AnnotationUtils anno;
  
  private final ArrayList<String> imports = new ArrayList<String>();
  
  public ObjectGenerator(final ResourceType resource, final Configuration config, final AnnotationUtils anno, final ObjectParentGenerator parent) {
    this.resource = resource;
    this.config = config;
    this.anno = anno;
    this.parent = parent;
  }
  
  public CharSequence generate(final String packageName) {
    CharSequence _xblockexpression = null;
    {
      this.imports.add("java.util.ArrayList");
      this.imports.add("java.util.List");
      String _classImport = Naming.CLASS_LINK.getClassImport();
      this.imports.add(_classImport);
      List<String> _annoImports = this.anno.getAnnoImports();
      this.imports.addAll(_annoImports);
      String _classImport_1 = Naming.CLASS_OBJPARENT.getClassImport();
      this.imports.add(_classImport_1);
      String idDataType = this.e.getIDDataTyp(this.config);
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("package ");
      _builder.append(packageName, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      {
        for(final String imp : this.imports) {
          _builder.append("import ");
          _builder.append(imp, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.newLine();
      CharSequence _classAnno = this.anno.getClassAnno();
      _builder.append(_classAnno, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public class ");
      String _name = this.resource.getName();
      String _firstUpper = StringExtensions.toFirstUpper(_name);
      _builder.append(_firstUpper, "");
      _builder.append(" ");
      String _extensionType = this.parent.getExtensionType();
      _builder.append(_extensionType, "");
      _builder.append(" ");
      String _className = Naming.CLASS_OBJPARENT.getClassName();
      _builder.append(_className, "");
      _builder.append("{");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence _fieldAnno = this.anno.getFieldAnno();
      _builder.append(_fieldAnno, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("private List<");
      _builder.append(Naming.CLASS_LINK, "\t");
      _builder.append("> hyperlinks = new ArrayList<");
      _builder.append(Naming.CLASS_LINK, "\t");
      _builder.append(">();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _fieldAnno_1 = this.anno.getFieldAnno();
      _builder.append(_fieldAnno_1, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("private ");
      _builder.append(idDataType, "\t");
      _builder.append(" id;");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _fieldAnno_2 = this.anno.getFieldAnno();
      _builder.append(_fieldAnno_2, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("private String selfLink; ");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      CharSequence _constrAnno = this.anno.getConstrAnno();
      _builder.append(_constrAnno, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("public ");
      String _name_1 = this.resource.getName();
      _builder.append(_name_1, "\t");
      _builder.append("(){}");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence _constrAnno_1 = this.anno.getConstrAnno();
      _builder.append(_constrAnno_1, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("public ");
      String _name_2 = this.resource.getName();
      _builder.append(_name_2, "\t");
      _builder.append("(");
      _builder.append(idDataType, "\t");
      _builder.append(" id){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("this();");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("this.id = id;");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("resetLinks();");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence _getMethodAnno = this.anno.getGetMethodAnno();
      _builder.append(_getMethodAnno, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("public ");
      _builder.append(idDataType, "\t");
      _builder.append(" getID(){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("return this.id;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence _setMethodAnno = this.anno.getSetMethodAnno();
      _builder.append(_setMethodAnno, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("public void setID(");
      _builder.append(idDataType, "\t");
      _builder.append(" id){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("this.id = id;");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("resetLinks();");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.newLine();
      {
        Iterable<Attribute> _attributes = this.e.getAttributes(this.resource);
        for(final Attribute attribute : _attributes) {
          _builder.append("\t");
          _builder.append("\t\t");
          _builder.newLine();
          _builder.append("\t");
          CharSequence _fieldAnno_3 = this.anno.getFieldAnno();
          _builder.append(_fieldAnno_3, "\t");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("private ");
          String _simpleNameOfType = this.e.simpleNameOfType(attribute);
          _builder.append(_simpleNameOfType, "\t");
          String _putExtra = this.putExtra(attribute);
          _builder.append(_putExtra, "\t");
          _builder.append(" ");
          String _name_3 = attribute.getName();
          String _firstLower = StringExtensions.toFirstLower(_name_3);
          _builder.append(_firstLower, "\t");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.newLine();
          _builder.append("\t");
          CharSequence _getMethodAnno_1 = this.anno.getGetMethodAnno();
          _builder.append(_getMethodAnno_1, "\t");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("public ");
          String _simpleNameOfType_1 = this.e.simpleNameOfType(attribute);
          _builder.append(_simpleNameOfType_1, "\t");
          String _putExtra_1 = this.putExtra(attribute);
          _builder.append(_putExtra_1, "\t");
          _builder.append(" get");
          String _name_4 = attribute.getName();
          String _firstUpper_1 = StringExtensions.toFirstUpper(_name_4);
          _builder.append(_firstUpper_1, "\t");
          _builder.append("(){");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("\t");
          _builder.append("return this.");
          String _name_5 = attribute.getName();
          String _firstLower_1 = StringExtensions.toFirstLower(_name_5);
          _builder.append(_firstLower_1, "\t\t");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("}");
          _builder.newLine();
          _builder.append("\t");
          _builder.newLine();
          _builder.append("\t");
          CharSequence _setMethodAnno_1 = this.anno.getSetMethodAnno();
          _builder.append(_setMethodAnno_1, "\t");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("public void set");
          String _name_6 = attribute.getName();
          String _firstUpper_2 = StringExtensions.toFirstUpper(_name_6);
          _builder.append(_firstUpper_2, "\t");
          _builder.append("(");
          String _simpleNameOfType_2 = this.e.simpleNameOfType(attribute);
          _builder.append(_simpleNameOfType_2, "\t");
          String _putExtra_2 = this.putExtra(attribute);
          _builder.append(_putExtra_2, "\t");
          _builder.append(" ");
          String _name_7 = attribute.getName();
          String _firstLower_2 = StringExtensions.toFirstLower(_name_7);
          _builder.append(_firstLower_2, "\t");
          _builder.append("){");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("\t");
          _builder.append("this.");
          String _name_8 = attribute.getName();
          String _firstLower_3 = StringExtensions.toFirstLower(_name_8);
          _builder.append(_firstLower_3, "\t\t");
          _builder.append(" = ");
          String _name_9 = attribute.getName();
          String _firstLower_4 = StringExtensions.toFirstLower(_name_9);
          _builder.append(_firstLower_4, "\t\t");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
          {
            Type _type = this.e.getType(attribute);
            if ((_type instanceof ResourceType)) {
              _builder.append("\t");
              _builder.append("\t");
              _builder.append("resetLinks();");
              _builder.newLine();
            }
          }
          _builder.append("\t");
          _builder.append("}");
          _builder.newLine();
        }
      }
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public void resetLinks(){");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("this.hyperlinks.clear();");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("selfLink = \"");
      String _basePath = this.config.getBasePath();
      _builder.append(_basePath, "\t\t");
      _builder.append("/");
      String _name_10 = this.resource.getName();
      String _lowerCase = _name_10.toLowerCase();
      _builder.append(_lowerCase, "\t\t");
      _builder.append("/\" + this.id;");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("this.hyperlinks.add(new ");
      _builder.append(Naming.CLASS_LINK, "\t\t");
      _builder.append("(\"self\", selfLink));");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes_1 = this.e.getAttributes(this.resource);
        final Function1<Attribute,Boolean> _function = new Function1<Attribute,Boolean>() {
          public Boolean apply(final Attribute it) {
            boolean _isList = it.isList();
            return Boolean.valueOf((!_isList));
          }
        };
        Iterable<Attribute> _filter = IterableExtensions.<Attribute>filter(_attributes_1, _function);
        final Function1<Attribute,Boolean> _function_1 = new Function1<Attribute,Boolean>() {
          public Boolean apply(final Attribute it) {
            Type _type = ObjectGenerator.this.e.getType(it);
            return Boolean.valueOf((_type instanceof ResourceType));
          }
        };
        Iterable<Attribute> _filter_1 = IterableExtensions.<Attribute>filter(_filter, _function_1);
        for(final Attribute attribute_1 : _filter_1) {
          {
            String _name_11 = this.resource.getName();
            Type _type_1 = this.e.getType(attribute_1);
            String _name_12 = ((ResourceType) _type_1).getName();
            boolean _notEquals = (!Objects.equal(_name_11, _name_12));
            if (_notEquals) {
              _builder.append("\t");
              _builder.append("if(");
              String _name_13 = attribute_1.getName();
              _builder.append(_name_13, "\t");
              _builder.append("  != null)");
              _builder.newLineIfNotEmpty();
              _builder.append("\t");
              _builder.append("this.hyperlinks.add(new ");
              _builder.append(Naming.CLASS_LINK, "\t");
              _builder.append("(\"rel\", \"");
              String _basePath_1 = this.config.getBasePath();
              _builder.append(_basePath_1, "\t");
              _builder.append("/");
              Type _type_2 = this.e.getType(attribute_1);
              String _name_14 = ((ResourceType) _type_2).getName();
              String _lowerCase_1 = _name_14.toLowerCase();
              _builder.append(_lowerCase_1, "\t");
              _builder.append("\" + \"/\" + ");
              String _name_15 = attribute_1.getName();
              _builder.append(_name_15, "\t");
              _builder.append(".getID()));");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public String getSelfURI(){");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return selfLink;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public List<");
      _builder.append(Naming.CLASS_LINK, "\t");
      _builder.append("> getLinks(){");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("return this.hyperlinks;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public void addLink(String type, String uri){");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("this.hyperlinks.add(new ");
      _builder.append(Naming.CLASS_LINK, "\t\t");
      _builder.append("(type, uri));");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public String toString(){");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return \"");
      String _name_16 = this.resource.getName();
      _builder.append(_name_16, "\t\t");
      _builder.append("\";");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  private String putExtra(final Attribute attribute) {
    boolean _isList = attribute.isList();
    if (_isList) {
      Type _type = this.e.getType(attribute);
      String _nameOfType = this.e.nameOfType(_type);
      String _plus = ("<" + _nameOfType);
      return (_plus + ">");
    } else {
      return "";
    }
  }
}
