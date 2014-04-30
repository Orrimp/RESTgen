package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
public class GensonResolverContent implements IResolverContent {
  private final IFileSystemAccess fsa;
  
  private final List<ResourceType> resources;
  
  public GensonResolverContent(final IFileSystemAccess fsa, final List<ResourceType> resources) {
    this.fsa = fsa;
    this.resources = resources;
  }
  
  public CharSequence getConstructor() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("final String ISO8601_DATETIME_FORMAT = \"yyyy-MM-dd\' \'HH:mm:ss\";");
    _builder.newLine();
    _builder.append("final DateFormat format = new SimpleDateFormat(ISO8601_DATETIME_FORMAT);");
    _builder.newLine();
    _builder.append("format.setTimeZone(TimeZone.getTimeZone(\"UTC\"));");
    _builder.newLine();
    _builder.append("format.setLenient(false);");
    _builder.newLine();
    _builder.newLine();
    _builder.append("genson = new Genson.Builder()");
    _builder.newLine();
    _builder.append("\t");
    _builder.append(".setDateFormat(format)");
    _builder.newLine();
    {
      for(final ResourceType res : this.resources) {
        _builder.append("\t");
        _builder.append(".addAlias(\"");
        String _name = res.getName();
        String _lowerCase = _name.toLowerCase();
        _builder.append(_lowerCase, "\t");
        _builder.append("\", ");
        String _name_1 = res.getName();
        String _firstUpper = StringExtensions.toFirstUpper(_name_1);
        _builder.append(_firstUpper, "\t");
        _builder.append(".class)");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("\t");
    _builder.append(".addAlias(\"");
    String _className = Naming.CLASS_LINK.getClassName();
    String _lowerCase_1 = _className.toLowerCase();
    _builder.append(_lowerCase_1, "\t");
    _builder.append("\", ");
    _builder.append(Naming.CLASS_LINK, "\t");
    _builder.append(".class)");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append(".create();");
    _builder.newLine();
    _builder.append("\t ");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence getName() {
    return "Genson";
  }
  
  public CharSequence getClassName() {
    return Naming.GENSON_RESOLVER.getClassName();
  }
  
  public CharSequence getImports() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("import java.text.DateFormat;");
    _builder.newLine();
    _builder.append("import java.text.SimpleDateFormat;");
    _builder.newLine();
    _builder.append("import java.util.TimeZone;");
    _builder.newLine();
    _builder.newLine();
    {
      for(final ResourceType res : this.resources) {
        _builder.append("import ");
        String _objectPackage = PackageManager.getObjectPackage();
        _builder.append(_objectPackage, "");
        _builder.append(".");
        String _name = res.getName();
        String _firstUpper = StringExtensions.toFirstUpper(_name);
        _builder.append(_firstUpper, "");
        _builder.append(";");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.newLine();
    _builder.append("import com.owlike.genson.Genson;");
    _builder.newLine();
    _builder.append("import ");
    String _classImport = Naming.CLASS_LINK.getClassImport();
    _builder.append(_classImport, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence getClassVariables() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("private final Genson genson;");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence getContextMethod() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("return genson;");
    _builder.newLine();
    return _builder;
  }
}
