package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.ExtensionMethods;
import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.ID_GEN;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class IDGenerator {
  private final IFileSystemAccess fsa;
  
  private final RESTConfiguration config;
  
  @Extension
  private ExtensionMethods e = new ExtensionMethods();
  
  public IDGenerator(final IFileSystemAccess fsa, final RESTConfiguration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generateID() {
    String _generationLocation = Naming.CLASS_ID.getGenerationLocation();
    String _plus = (_generationLocation + Constants.JAVA);
    CharSequence _compile = this.compile(this.config);
    this.fsa.generateFile(_plus, _compile);
  }
  
  public CharSequence compile(final RESTConfiguration config) {
    ID_GEN _idtype = config.getIdtype();
    if (_idtype != null) {
      switch (_idtype) {
        case LONG:
          return this.generateLONGClass(config);
        case UUID:
          return this.generateUUIDClass(config);
        default:
          break;
      }
    }
    return null;
  }
  
  public CharSequence generateLONGClass(final RESTConfiguration config) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _packageName = Naming.CLASS_ID.getPackageName();
    _builder.append(_packageName, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import ");
    String _classImport = Naming.INTERFACE_ID.getClassImport();
    _builder.append(_classImport, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("public class ");
    _builder.append(Naming.CLASS_ID, "");
    _builder.append(" implements ");
    _builder.append(Naming.INTERFACE_ID, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("private  long counter = ");
    _builder.append(Constants.LONG_COUTNER_VALUE, "\t");
    _builder.append(";  ");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("private static ");
    _builder.append(Naming.CLASS_ID, "\t");
    _builder.append(" instance = null;");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("protected ");
    _builder.append(Naming.CLASS_ID, "\t");
    _builder.append("(){}");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public synchronized static ");
    _builder.append(Naming.CLASS_ID, "\t");
    _builder.append(" getInstantce(){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if(instance == null){");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("instance = new ");
    _builder.append(Naming.CLASS_ID, "\t\t\t");
    _builder.append("();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return instance;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public synchronized ");
    String _iDDataTyp = this.e.getIDDataTyp(config);
    _builder.append(_iDDataTyp, "\t");
    _builder.append(" generateID(){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return counter++;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  private CharSequence generateUUIDClass(final RESTConfiguration config) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _packageName = Naming.CLASS_ID.getPackageName();
    _builder.append(_packageName, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import ");
    String _interfacePackage = PackageManager.getInterfacePackage();
    _builder.append(_interfacePackage, "");
    _builder.append(".");
    _builder.append(Naming.INTERFACE_ID, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("import java.util.UUID;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("public class ");
    _builder.append(Naming.CLASS_ID, "");
    _builder.append(" implements ");
    _builder.append(Naming.INTERFACE_ID, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _iDDataTyp = this.e.getIDDataTyp(config);
    _builder.append(_iDDataTyp, "\t");
    _builder.append(" generateID(){");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return UUID.randomUUID().toString();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
