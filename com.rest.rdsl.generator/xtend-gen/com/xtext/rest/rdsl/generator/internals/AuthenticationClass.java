package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.management.ClassPackageInfo;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.Auth;
import com.xtext.rest.rdsl.restDsl.HTTPBasic;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

/**
 * Thsi class is for storing all the authorization and authentication information given by the client.
 */
@SuppressWarnings("all")
public class AuthenticationClass {
  private RESTConfiguration config = null;
  
  private IFileSystemAccess fsa = null;
  
  public AuthenticationClass(final RESTConfiguration config, final IFileSystemAccess fsa) {
    this.config = config;
    this.fsa = fsa;
  }
  
  /**
   * Generates the class which stores an process the authentication information from client.
   */
  public void generate() {
    final ClassPackageInfo className = Naming.CLASS_USER_AUTH_DATA;
    String _generationLocation = Naming.CLASS_USER_AUTH_DATA.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _authPackage = PackageManager.getAuthPackage();
    _builder.append(_authPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("import com.sun.jersey.core.util.Base64;");
    _builder.newLine();
    _builder.append("import ");
    String _interfacePackage = PackageManager.getInterfacePackage();
    _builder.append(_interfacePackage, "");
    _builder.append(".");
    _builder.append(Naming.INTERFACE_AUTH_DECODER, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append("* This class stores the authentication information extracted from the header.");
    _builder.newLine();
    {
      Auth _auth = this.config.getAuth();
      if ((_auth instanceof HTTPBasic)) {
        _builder.append("* The header, the username and the password are extracted by default using BASE 64 decoder");
        _builder.newLine();
      } else {
        _builder.append("* The token, the scope, the user... are extracted by default using BASE 64 decoder");
        _builder.newLine();
      }
    }
    _builder.append("* A custom decoder can be used given in the constructor using the interface ");
    _builder.append(Naming.INTERFACE_AUTH_DECODER, "");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public class ");
    _builder.append(className, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private String header = \"\";");
    _builder.newLine();
    {
      Auth _auth_1 = this.config.getAuth();
      if ((_auth_1 instanceof HTTPBasic)) {
        _builder.append("private String name = \"\";");
        _builder.newLine();
        _builder.append("private String passwd = \"\";");
        _builder.newLine();
      } else {
        _builder.append("private String token = \"\";");
        _builder.newLine();
        _builder.append("private String scope = \"\";");
        _builder.newLine();
        _builder.append("private String user = \"\";");
        _builder.newLine();
      }
    }
    _builder.append("\t");
    _builder.append("public ");
    _builder.append(className, "\t");
    _builder.append("(String header){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.header = header;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("decodeHeaderB64(header);");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    _builder.append(className, "\t");
    _builder.append("(String header, ");
    _builder.append(Naming.INTERFACE_AUTH_DECODER, "\t");
    _builder.append(" decoder){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.header = header;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("decodeHeader(header, decoder);");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private void decodeHeaderB64(String header){");
    _builder.newLine();
    {
      Auth _auth_2 = this.config.getAuth();
      if ((_auth_2 instanceof HTTPBasic)) {
        _builder.append("\t");
        _builder.append(" \t");
        _builder.append("final String withoutBasic = header.replaceFirst(\"[Bb]asic \", \"\");");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("final String userColonPass = Base64.base64Decode(withoutBasic);");
        _builder.newLine();
        _builder.append("\t");
        _builder.append(" \t");
        _builder.append("final String [] asArray = userColonPass.split(\":\");");
        _builder.newLine();
        _builder.append("\t");
        _builder.append(" \t");
        _builder.append("if(asArray.length == 2){");
        _builder.newLine();
        _builder.append("\t");
        _builder.append(" \t");
        _builder.append("this.name = asArray[0];");
        _builder.newLine();
        _builder.append("\t");
        _builder.append(" \t");
        _builder.append("this.passwd = asArray[1];");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("}");
        _builder.newLine();
      } else {
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("final String tokenReadable = Base64.base64Decode(header);");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("final String[] asArray = tokenReadable.split(\":\");");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("if(asArray.length == 3){");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("this.token = asArray[0];");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("this.scope = asArray[1];");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("this.user = asArray[2];");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("}");
        _builder.newLine();
      }
    }
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private void decodeHeader(String header, ");
    _builder.append(Naming.INTERFACE_AUTH_DECODER, "\t");
    _builder.append(" decoder){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("String[] asArray = decoder.decode(header);");
    _builder.newLine();
    {
      Auth _auth_3 = this.config.getAuth();
      if ((_auth_3 instanceof HTTPBasic)) {
        _builder.append("\t\t");
        _builder.append("if(asArray.length == 2){");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("\t");
        _builder.append("this.name = asArray[0];");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("\t");
        _builder.append("this.passwd = asArray[1];");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("}");
        _builder.newLine();
      } else {
        _builder.append("\t\t");
        _builder.append("if(asArray.length == 3){");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("\t");
        _builder.append("this.token = asArray[0];");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("\t");
        _builder.append("this.scope = asArray[1];");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("\t");
        _builder.append("this.user = asArray[2];");
        _builder.newLine();
        _builder.append("\t\t");
        _builder.append("}");
        _builder.newLine();
      }
    }
    _builder.append(" \t");
    _builder.append("}");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("}");
    _builder.newLine();
    this.fsa.generateFile(_plus, _builder);
  }
}
