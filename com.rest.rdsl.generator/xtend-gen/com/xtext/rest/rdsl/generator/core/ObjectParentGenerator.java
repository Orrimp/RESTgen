package com.xtext.rest.rdsl.generator.core;

import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.restDsl.Configuration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.xbase.lib.Extension;

/**
 * Implementation of a parent for every object generated in this project.
 */
@SuppressWarnings("all")
public class ObjectParentGenerator {
  private final IFileSystemAccess fsa;
  
  private final Configuration config;
  
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  public ObjectParentGenerator(final IFileSystemAccess fsa, final Configuration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  /**
   * The extension type can be implements or extends depending on the choosen implementation.
   */
  public String getExtensionType() {
    return "implements";
  }
  
  /**
   * Generates the object parent class with all its methods and attributes.
   */
  public void generate(final String packageName) {
    String _generationLocation = Naming.CLASS_OBJPARENT.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    _builder.append(packageName, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import java.util.List;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("public interface ");
    _builder.append(Naming.CLASS_OBJPARENT, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _iDDataTyp = this.e.getIDDataTyp(this.config);
    _builder.append(_iDDataTyp, "\t");
    _builder.append(" getID();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("public String getSelfURI();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public List<");
    String _className = Naming.CLASS_LINK.getClassName();
    _builder.append(_className, "\t");
    _builder.append("> getLinks();");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
}
