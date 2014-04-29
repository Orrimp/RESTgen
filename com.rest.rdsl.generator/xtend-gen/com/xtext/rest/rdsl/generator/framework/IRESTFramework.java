package com.xtext.rest.rdsl.generator.framework;

import com.xtext.rest.rdsl.generator.RESTResourceCollection;

@SuppressWarnings("all")
public interface IRESTFramework {
  public abstract void generateResources(final RESTResourceCollection resourceCol);
  
  public abstract void generateMisc(final RESTResourceCollection resourceCol);
}
