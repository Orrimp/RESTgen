package com.xtext.rest.rdsl.generator.framework;

import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTResource;

/**
 * Class for representing different resource generators. For Example Jersey and Spring Frameworks get their own ResourceGenerators
 */
@SuppressWarnings("all")
public interface IResourceGenerator {
  public abstract CharSequence generate(final RESTResource resource, final RESTConfiguration config);
}
