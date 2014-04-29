package com.xtext.rest.rdsl.generator.framework.jersey;

/**
 * Class to inject code inside a Jersey ContextResolver Provider class.
 */
@SuppressWarnings("all")
public interface IResolverContent {
  public abstract CharSequence getConstructor();
  
  public abstract CharSequence getName();
  
  public abstract CharSequence getClassName();
  
  public abstract CharSequence getImports();
  
  public abstract CharSequence getClassVariables();
  
  public abstract CharSequence getContextMethod();
}
