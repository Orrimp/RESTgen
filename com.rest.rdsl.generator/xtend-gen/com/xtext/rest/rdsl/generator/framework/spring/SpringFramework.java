package com.xtext.rest.rdsl.generator.framework.spring;

import com.xtext.rest.rdsl.generator.ResourceTypeCollection;
import com.xtext.rest.rdsl.generator.framework.IRESTFramework;
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.spring.SpringResourceGenerator;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import java.util.List;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class SpringFramework implements IRESTFramework {
  private final IFileSystemAccess fsa;
  
  private final Configuration config;
  
  public SpringFramework(final IFileSystemAccess fsa, final Configuration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generateResources(final ResourceTypeCollection resourceCol) {
    final IResourceGenerator generator = new SpringResourceGenerator();
    List<ResourceType> _resources = resourceCol.getResources();
    for (final ResourceType r : _resources) {
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
  
  public void generateMisc(final ResourceTypeCollection resourceCol) {
  }
}
