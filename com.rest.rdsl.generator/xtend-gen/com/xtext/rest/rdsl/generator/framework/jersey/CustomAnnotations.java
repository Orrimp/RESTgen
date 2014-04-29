package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.framework.jersey.CustomJerseyFilter;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class CustomAnnotations {
  private final RESTResource resource;
  
  private final RESTConfiguration config;
  
  private final IFileSystemAccess fsa;
  
  public CustomAnnotations(final RESTConfiguration config, final IFileSystemAccess fsa, final RESTResource resource) {
    this.config = config;
    this.fsa = fsa;
    this.resource = resource;
  }
  
  public void generatePATCH() {
    String _generationLocation = Naming.ANNO_PATCH.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _frameworkPackage = PackageManager.getFrameworkPackage();
    _builder.append(_frameworkPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    {
      List<String> _baseImports = Naming.ANNO_PATCH.getBaseImports();
      for(final String imp : _baseImports) {
        _builder.append("import ");
        _builder.append(imp, "");
        _builder.append(";");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.newLine();
    _builder.append("import javax.ws.rs.HttpMethod;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("@NameBinding");
    _builder.newLine();
    _builder.append("@Target( { ElementType.TYPE, ElementType.METHOD } )");
    _builder.newLine();
    _builder.append("@Retention( value = RetentionPolicy.RUNTIME )");
    _builder.newLine();
    _builder.append("@HttpMethod(\"PATCH\") ");
    _builder.newLine();
    _builder.append("public @interface ");
    _builder.append(Naming.ANNO_PATCH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("{}");
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
  
  public void generateAuth() {
    String _generationLocation = Naming.ANNO_USER_AUTH.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _authPackage = PackageManager.getAuthPackage();
    _builder.append(_authPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    {
      List<String> _baseImports = Naming.ANNO_USER_AUTH.getBaseImports();
      for(final String imp : _baseImports) {
        _builder.append("import ");
        _builder.append(imp, "");
        _builder.append(";");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.newLine();
    _builder.append("@NameBinding");
    _builder.newLine();
    _builder.append("@Target( { ElementType.TYPE, ElementType.METHOD } )");
    _builder.newLine();
    _builder.append("@Retention( value = RetentionPolicy.RUNTIME )");
    _builder.newLine();
    _builder.append("public @interface ");
    _builder.append(Naming.ANNO_USER_AUTH, "");
    _builder.newLineIfNotEmpty();
    _builder.append("{}");
    _builder.newLine();
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
    final CustomJerseyFilter filter = new CustomJerseyFilter(this.config, this.fsa, this.resource);
    filter.generateFilter();
  }
}
