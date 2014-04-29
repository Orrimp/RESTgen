package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionMapper;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.PackageManager;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class JerseyExceptionMapperGenerator {
  private IFileSystemAccess fsa;
  
  private final ExceptionMapper mapper;
  
  public JerseyExceptionMapperGenerator(final IFileSystemAccess fsa, final ExceptionMapper mapper) {
    this.fsa = fsa;
    this.mapper = mapper;
  }
  
  public void generateExceptionMapper(final ExceptionDescription exDesc) {
    final String mapperName = "Mapper";
    String _mainPackage = Constants.getMainPackage();
    String _plus = (_mainPackage + Constants.EXCEPTIONPACKAGE);
    String _plus_1 = (_plus + "/");
    String _name = exDesc.getName();
    String _plus_2 = (_plus_1 + _name);
    String _plus_3 = (_plus_2 + mapperName);
    String _plus_4 = (_plus_3 + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.newLine();
    _builder.append("package ");
    String _exceptionPackage = PackageManager.getExceptionPackage();
    _builder.append(_exceptionPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("import javax.ws.rs.ext.ExceptionMapper;");
    _builder.newLine();
    _builder.append("import javax.ws.rs.ext.Provider;");
    _builder.newLine();
    _builder.append("import javax.ws.rs.core.MediaType;");
    _builder.newLine();
    _builder.append("import javax.ws.rs.core.Response;");
    _builder.newLine();
    _builder.append("import javax.ws.rs.core.Response.Status;");
    _builder.newLine();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("@Provider");
    _builder.newLine();
    _builder.append("public class ");
    String _name_1 = exDesc.getName();
    _builder.append(_name_1, "");
    _builder.append(mapperName, "");
    _builder.append(" implements ExceptionMapper<");
    String _name_2 = exDesc.getName();
    _builder.append(_name_2, "");
    _builder.append(">{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public Response toResponse(");
    String _name_3 = exDesc.getName();
    _builder.append(_name_3, "\t");
    _builder.append(" ex) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return Response.status(Status.");
    String _statusString = exDesc.getStatusString();
    _builder.append(_statusString, "\t\t");
    _builder.append(").entity(ex).type(MediaType.APPLICATION_JSON).build();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus_4, _builder);
  }
}
