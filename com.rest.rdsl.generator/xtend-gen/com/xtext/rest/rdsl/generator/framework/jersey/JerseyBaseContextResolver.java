package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.PackageManager;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class JerseyBaseContextResolver {
  private final IFileSystemAccess fsa;
  
  private final IResolverContent resolver;
  
  public JerseyBaseContextResolver(final IFileSystemAccess fsa, final IResolverContent resolver) {
    this.fsa = fsa;
    this.resolver = resolver;
  }
  
  public void generateResolver() {
    String _mainPackage = Constants.getMainPackage();
    String _plus = (_mainPackage + Constants.RESOURCEPACKAGE);
    String _plus_1 = (_plus + "/");
    CharSequence _className = this.resolver.getClassName();
    String _plus_2 = (_plus_1 + _className);
    String _plus_3 = (_plus_2 + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _resourcePackage = PackageManager.getResourcePackage();
    _builder.append(_resourcePackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import javax.ws.rs.ext.Provider;");
    _builder.newLine();
    _builder.append("import javax.ws.rs.ext.ContextResolver;");
    _builder.newLine();
    _builder.newLine();
    CharSequence _imports = this.resolver.getImports();
    _builder.append(_imports, "");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("@Provider");
    _builder.newLine();
    _builder.append("public class ");
    CharSequence _className_1 = this.resolver.getClassName();
    _builder.append(_className_1, "");
    _builder.append(" implements ContextResolver<");
    CharSequence _name = this.resolver.getName();
    _builder.append(_name, "");
    _builder.append("> {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    CharSequence _classVariables = this.resolver.getClassVariables();
    _builder.append(_classVariables, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public  ");
    CharSequence _className_2 = this.resolver.getClassName();
    _builder.append(_className_2, "    ");
    _builder.append("() throws Exception {");
    _builder.newLineIfNotEmpty();
    _builder.append("    \t");
    CharSequence _constructor = this.resolver.getConstructor();
    _builder.append(_constructor, "    \t");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.append("    ");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public ");
    CharSequence _name_1 = this.resolver.getName();
    _builder.append(_name_1, "    ");
    _builder.append(" getContext(Class<?> objectType) {");
    _builder.newLineIfNotEmpty();
    _builder.append("        ");
    CharSequence _contextMethod = this.resolver.getContextMethod();
    _builder.append(_contextMethod, "        ");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus_3, _builder);
  }
}
