package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.generator.internals.IExceptionGenerator;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.PackageManager;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class ExceptionGenerator implements IExceptionGenerator {
  /**
   * Generate an exception in specific folder under a specific name
   */
  private IFileSystemAccess fsa;
  
  private final String generatePackage = ((Constants.getMainPackage() + Constants.EXCEPTIONPACKAGE) + "/");
  
  public ExceptionGenerator(final IFileSystemAccess fsa) {
    this.fsa = fsa;
  }
  
  public void generateCustomException(final ExceptionDescription exDesc) {
    String _name = exDesc.getName();
    String _plus = (this.generatePackage + _name);
    String _plus_1 = (_plus + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _exceptionPackage = PackageManager.getExceptionPackage();
    _builder.append(_exceptionPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import javax.ws.rs.WebApplicationException;");
    _builder.newLine();
    _builder.append("\t ");
    _builder.newLine();
    _builder.append("public class ");
    String _name_1 = exDesc.getName();
    _builder.append(_name_1, "");
    _builder.append(" extends WebApplicationException {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private String developerMessage = \"\";");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private String userMessage = \"\";");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private Exception innerDeveloperException = null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _name_2 = exDesc.getName();
    _builder.append(_name_2, "\t");
    _builder.append("(){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.developerMessage = \"");
    String _developerMessage = exDesc.getDeveloperMessage();
    _builder.append(_developerMessage, "\t\t");
    _builder.append("\";");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.userMessage = \"");
    String _message = exDesc.getMessage();
    _builder.append(_message, "\t\t");
    _builder.append("\";");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public String getDeveloperMessage(){ ");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return this.developerMessage;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public String getUserMEssage(){");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return this.userMessage;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public void setInnerException(Exception ex){");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.innerDeveloperException = ex;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus_1, _builder);
  }
}
