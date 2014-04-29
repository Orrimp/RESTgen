package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class InterfaceGenerator {
  private IFileSystemAccess fsa;
  
  private RESTConfiguration config;
  
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  public InterfaceGenerator(final IFileSystemAccess fsa, final RESTConfiguration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generateID() {
    String _generationLocation = Naming.INTERFACE_ID.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _interfacePackage = PackageManager.getInterfacePackage();
    _builder.append(_interfacePackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("public interface ");
    _builder.append(Naming.INTERFACE_ID, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("public ");
    String _iDDataTyp = this.e.getIDDataTyp(this.config);
    _builder.append(_iDDataTyp, "\t");
    _builder.append(" generateID();");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
  
  public void generateDecoder() {
    String _generationLocation = Naming.INTERFACE_AUTH_DECODER.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _interfacePackage = PackageManager.getInterfacePackage();
    _builder.append(_interfacePackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("public interface ");
    _builder.append(Naming.INTERFACE_AUTH_DECODER, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("String[] decode(String header);");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
}
