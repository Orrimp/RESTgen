package com.xtext.rest.rdsl.generator.internals;

import com.xtext.rest.rdsl.generator.resources.internal.ExceptionDescription;

/**
 * Represent an Java Exception with given Exception description.
 */
@SuppressWarnings("all")
public interface IExceptionGenerator {
  public abstract void generateCustomException(final ExceptionDescription exDesc);
}
