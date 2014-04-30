package com.xtext.rest.rdsl.generator.core;

import com.xtext.rest.rdsl.generator.ResourceTypeCollection;
import com.xtext.rest.rdsl.generator.framework.IBaseResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.IRESTFramework;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyAbstractResourceGenerator;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyExceptionMapperGenerator;
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyFramework;
import com.xtext.rest.rdsl.generator.framework.spring.ResourceAbstractSpringGenerator;
import com.xtext.rest.rdsl.generator.internals.ExceptionGenerator;
import com.xtext.rest.rdsl.generator.internals.IExceptionGenerator;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription;
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionMapper;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.FRAMEWORK;
import java.util.Collection;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class FrameworkManager {
  private final Configuration config;
  
  private final IFileSystemAccess fsa;
  
  private final ResourceTypeCollection resourceCol;
  
  private IBaseResourceGenerator abstractGenerator;
  
  private IExceptionGenerator exceptionGenerator;
  
  private IRESTFramework restFramework;
  
  public FrameworkManager(final IFileSystemAccess fsa, final Configuration config, final ResourceTypeCollection resourceCol) {
    this.config = config;
    this.fsa = fsa;
    this.resourceCol = resourceCol;
  }
  
  public void generate() {
    FRAMEWORK _framework = this.config.getFramework();
    if (_framework != null) {
      switch (_framework) {
        case JERSEY:
          this.setJerseyEnviroment();
          break;
        case SPRING:
          this.setSpringEnviroment();
          break;
        default:
          break;
      }
    }
    this.restFramework.generateResources(this.resourceCol);
    this.restFramework.generateMisc(this.resourceCol);
    this.abstractGenerator.generate(this.fsa);
    this.generateExceptions(this.fsa);
  }
  
  public IRESTFramework setJerseyEnviroment() {
    IRESTFramework _xblockexpression = null;
    {
      JerseyAbstractResourceGenerator _jerseyAbstractResourceGenerator = new JerseyAbstractResourceGenerator();
      this.abstractGenerator = _jerseyAbstractResourceGenerator;
      JerseyFramework _jerseyFramework = new JerseyFramework(this.fsa, this.config);
      _xblockexpression = this.restFramework = _jerseyFramework;
    }
    return _xblockexpression;
  }
  
  public IBaseResourceGenerator setSpringEnviroment() {
    ResourceAbstractSpringGenerator _resourceAbstractSpringGenerator = new ResourceAbstractSpringGenerator();
    return this.abstractGenerator = _resourceAbstractSpringGenerator;
  }
  
  public void generateExceptions(final IFileSystemAccess fsa) {
    ExceptionGenerator _exceptionGenerator = new ExceptionGenerator(fsa);
    this.exceptionGenerator = _exceptionGenerator;
    final ExceptionMapper exMapper = new ExceptionMapper(this.config);
    final JerseyExceptionMapperGenerator eMapperGen = new JerseyExceptionMapperGenerator(fsa, exMapper);
    Collection<ExceptionDescription> _values = exMapper.values();
    for (final ExceptionDescription exception : _values) {
      {
        this.exceptionGenerator.generateCustomException(exception);
        eMapperGen.generateExceptionMapper(exception);
      }
    }
  }
}
