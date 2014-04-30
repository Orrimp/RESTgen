package com.xtext.rest.rdsl.generator.framework.jersey;

import com.xtext.rest.rdsl.generator.ResourceTypeCollection;
import com.xtext.rest.rdsl.generator.framework.IRESTFramework;
import com.xtext.rest.rdsl.generator.framework.IResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.jersey.CustomAnnotations;
import com.xtext.rest.rdsl.generator.framework.jersey.GensonResolverContent;
import com.xtext.rest.rdsl.generator.framework.jersey.IResolverContent;
import com.xtext.rest.rdsl.generator.framework.jersey.JAXBResolverContent;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyBaseContextResolver;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyResourceGenerator;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import java.util.List;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class JerseyFramework implements IRESTFramework {
  private final IFileSystemAccess fsa;
  
  private final Configuration config;
  
  public JerseyFramework(final IFileSystemAccess fsa, final Configuration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generateResources(final ResourceTypeCollection resourceCol) {
    final IResourceGenerator generator = new JerseyResourceGenerator();
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
    List<ResourceType> _resources = resourceCol.getResources();
    final IResolverContent jaxb = new JAXBResolverContent(this.fsa, _resources);
    List<ResourceType> _resources_1 = resourceCol.getResources();
    final IResolverContent genson = new GensonResolverContent(this.fsa, _resources_1);
    final JerseyBaseContextResolver gensonResolver = new JerseyBaseContextResolver(this.fsa, genson);
    gensonResolver.generateResolver();
    final JerseyBaseContextResolver jaxbResolver = new JerseyBaseContextResolver(this.fsa, jaxb);
    ResourceType _userResource = resourceCol.getUserResource();
    final CustomAnnotations annons = new CustomAnnotations(this.config, this.fsa, _userResource);
    annons.generateAuth();
    annons.generatePATCH();
  }
}
