package com.xtext.rest.rdsl.generator.framework;

import com.xtext.rest.rdsl.generator.ResourceTypeCollection;

@SuppressWarnings("all")
public interface IRESTFramework {
  public abstract void generateResources(final ResourceTypeCollection resourceCol);
  
  public abstract void generateMisc(final ResourceTypeCollection resourceCol);
}
