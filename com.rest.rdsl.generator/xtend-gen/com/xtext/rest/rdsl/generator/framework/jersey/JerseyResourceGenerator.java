package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.framework.IResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyMethodGenerator;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.Attribute;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class JerseyResourceGenerator implements IResourceGenerator {
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  /**
   * Generate the class which represents a REST resource.
   */
  public CharSequence generate(final ResourceType resource, final Configuration config) {
    CharSequence _xblockexpression = null;
    {
      final Set<String> attributeImports = new HashSet<String>();
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("package ");
      String _resourcePackage = PackageManager.getResourcePackage();
      _builder.append(_resourcePackage, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append(" ");
      _builder.newLine();
      {
        List<String> _baseImports = Naming.FRAMEWORK_JERSEY.getBaseImports();
        for(final String imp : _baseImports) {
          _builder.append("import ");
          _builder.append(imp, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("import ");
      String _interfacePackage = PackageManager.getInterfacePackage();
      _builder.append(_interfacePackage, "");
      _builder.append(".*;");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _objectPackage = PackageManager.getObjectPackage();
      _builder.append(_objectPackage, "");
      _builder.append(".*;");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _exceptionPackage = PackageManager.getExceptionPackage();
      _builder.append(_exceptionPackage, "");
      _builder.append(".*;");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport = Naming.ANNO_USER_AUTH.getClassImport();
      _builder.append(_classImport, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport_1 = Naming.CLASS_ID.getClassImport();
      _builder.append(_classImport_1, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport_2 = Naming.INTERFACE_ID.getClassImport();
      _builder.append(_classImport_2, "");
      _builder.append(";\t");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport_3 = Naming.ABSTRACT_CLASS_DAO.getClassImport();
      _builder.append(_classImport_3, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport_4 = Naming.ANNO_PATCH.getClassImport();
      _builder.append(_classImport_4, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("import ");
      String _classImport_5 = Naming.CLASS_DB_QUERY.getClassImport();
      _builder.append(_classImport_5, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.append("import javax.ws.rs.QueryParam;");
      _builder.newLine();
      _builder.append("import javax.ws.rs.core.Response.ResponseBuilder;");
      _builder.newLine();
      _builder.append("import javax.ws.rs.core.EntityTag;");
      _builder.newLine();
      {
        for(final String imp_1 : attributeImports) {
          _builder.append("import ");
          _builder.append(imp_1, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.newLine();
      _builder.append("import java.net.URI;");
      _builder.newLine();
      _builder.append("import java.util.List;");
      _builder.newLine();
      _builder.append("import java.util.Date;");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t ");
      _builder.newLine();
      _builder.append("@Path(\"/");
      String _name = resource.getName();
      String _lowerCase = _name.toLowerCase();
      _builder.append(_lowerCase, "");
      _builder.append("\")");
      _builder.newLineIfNotEmpty();
      _builder.append("public class ");
      String _name_1 = resource.getName();
      _builder.append(_name_1, "");
      _builder.append("Resource  extends ");
      _builder.append(Naming.CLASS_ABSTRACT_RESOURCE, "");
      _builder.append("{");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      JerseyMethodGenerator mGen = new JerseyMethodGenerator(config, resource);
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generateGET = mGen.generateGET();
      _builder.append(_generateGET, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generateDELETE = mGen.generateDELETE();
      _builder.append(_generateDELETE, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generatePOST = mGen.generatePOST();
      _builder.append(_generatePOST, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generatePUT = mGen.generatePUT();
      _builder.append(_generatePUT, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generatePATCH = mGen.generatePATCH();
      _builder.append(_generatePATCH, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      CharSequence _generateQuery = mGen.generateQuery();
      _builder.append(_generateQuery, "\t");
      _builder.newLineIfNotEmpty();
      {
        Iterable<Attribute> _attributes = this.e.getAttributes(resource);
        for(final Attribute attribute : _attributes) {
          {
            boolean _isList = attribute.isList();
            if (_isList) {
              CharSequence _generateQuery_1 = mGen.generateQuery(attribute);
              _builder.append(_generateQuery_1, "");
              _builder.newLineIfNotEmpty();
            } else {
              CharSequence _generate = mGen.generate(attribute);
              _builder.append(_generate, "");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.append("} \t");
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
}
