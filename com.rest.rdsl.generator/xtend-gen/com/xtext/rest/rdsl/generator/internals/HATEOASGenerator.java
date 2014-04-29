package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.Naming;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class HATEOASGenerator {
  private IFileSystemAccess fsa;
  
  public HATEOASGenerator(final IFileSystemAccess fsa) {
    this.fsa = fsa;
  }
  
  public void generate(final String generationPackage) {
    String _generationLocation = Naming.CLASS_LINK.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _packageName = Naming.CLASS_LINK.getPackageName();
    _builder.append(_packageName, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("import java.net.URI;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("public class ");
    _builder.append(Naming.CLASS_LINK, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private String type;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private URI uri;");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    _builder.append(Naming.CLASS_LINK, "\t");
    _builder.append("(){}");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    _builder.append(Naming.CLASS_LINK, "\t");
    _builder.append("(String type, String uri){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.type = type;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.uri = URI.create(uri);");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    _builder.append(Naming.CLASS_LINK, "\t");
    _builder.append("(String type, URI uri){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.type = type;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.uri = uri;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public String getType(){");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return this.type;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public URI getURI(){");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return this.uri;\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
}
