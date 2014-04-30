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
public class JAXBResolverContent implements IResolverContent {
  private final List<ResourceType> resources;
  
  public JAXBResolverContent(final IFileSystemAccess fsa, final List<ResourceType> resources) {
    this.resources = resources;
  }
  
  public CharSequence getConstructor() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@SuppressWarnings(\"rawtypes\")");
    _builder.newLine();
    _builder.append("Class[] typesArr = new Class[]{");
    {
      boolean _hasElements = false;
      for(final ResourceType r : this.resources) {
        if (!_hasElements) {
          _hasElements = true;
        } else {
          _builder.appendImmediate(", ", "");
        }
        _builder.append(" ");
        String _name = r.getName();
        String _firstUpper = StringExtensions.toFirstUpper(_name);
        String _plus = (_firstUpper + ".class");
        _builder.append(_plus, "");
        _builder.append(" ");
      }
    }
    _builder.append("};");
    _builder.newLineIfNotEmpty();
    _builder.append("JSONConfiguration.MappedBuilder b = JSONConfiguration.mapped();");
    _builder.newLine();
    _builder.append("b.rootUnwrapping(false);\t\t\t\t\t\t\t\t\t\t\t//Add class name to the JSON OBject. ");
    _builder.newLine();
    _builder.append("context = new JSONJAXBContext(b.build(), typesArr); //TODO change");
    _builder.newLine();
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence getName() {
    return "JAXBContext";
  }
  
  public CharSequence getClassName() {
    return Naming.JAXB_RESOLVER.getClassName();
  }
  
  public CharSequence getImports() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.newLine();
    _builder.append("import javax.xml.bind.JAXBContext;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("import com.sun.jersey.api.json.JSONConfiguration;");
    _builder.newLine();
    _builder.append("import com.sun.jersey.api.json.JSONJAXBContext;");
    _builder.newLine();
    _builder.append("import java.lang.Exception;");
    _builder.newLine();
    _builder.newLine();
    _builder.newLine();
    {
      for(final ResourceType r : this.resources) {
        _builder.append("import ");
        String _objectPackage = PackageManager.getObjectPackage();
        _builder.append(_objectPackage, "");
        _builder.append(".");
        String _name = r.getName();
        String _firstUpper = StringExtensions.toFirstUpper(_name);
        _builder.append(_firstUpper, "");
        _builder.append(";");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence getClassVariables() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("private ");
    CharSequence _name = this.getName();
    _builder.append(_name, "");
    _builder.append(" context;");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence getContextMethod() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("return context;");
    _builder.newLine();
    return _builder;
  }
}
