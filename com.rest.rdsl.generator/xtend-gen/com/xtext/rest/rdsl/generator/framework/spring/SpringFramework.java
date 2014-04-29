package com.xtext.rest.rdsl.generator.framework.spring;

import com.xtext.rest.rdsl.generator.RESTResourceCollection;
import com.xtext.rest.rdsl.generator.framework.IRESTFramework;
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.spring.SpringResourceGenerator;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import java.util.List;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class SpringFramework implements IRESTFramework {
  private final IFileSystemAccess fsa;
  
  private final RESTConfiguration config;
  
  public SpringFramework(final IFileSystemAccess fsa, final RESTConfiguration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generateResources(final RESTResourceCollection resourceCol) {
    final IResourceGenerator generator = new SpringResourceGenerator();
    List<RESTResource> _resources = resourceCol.getResources();
    for (final RESTResource r : _resources) {
      String _mainPackage = Constants.getMainPackage();
      String _plus = (_mainPackage + Constants.RESOURCEPACKAGE);
      String _plus_1 = (_plus + "/");
      String _name = r.getName();
      String _plus_2 = (_plus_1 + _name);
      String _plus_3 = (_plus_2 + "Resource");
      String _plus_4 = (_plus_3 + Constants.JAVA);
      CharSequence _generate = generator.generate(r, this.config);
      this.fsa.generateFile(_plus_4, _generate);
    }
  }
  
  public void generateMisc(final RESTResourceCollection resourceCol) {
  }
}
