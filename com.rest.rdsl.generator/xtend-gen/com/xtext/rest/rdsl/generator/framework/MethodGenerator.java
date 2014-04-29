package com.xtext.rest.rdsl.generator.framework;

import com.xtext.rest.rdsl.restDsl.Attribute;

@SuppressWarnings("all")
public abstract class MethodGenerator {
  public abstract CharSequence generateGETAttribute(final Attribute attribute);
  
  public abstract CharSequence generatePOST();
  
  public abstract CharSequence generatePUT();
  
  public abstract CharSequence generatePATCH();
  
  public abstract CharSequence generateDELETE();
  
  public abstract CharSequence generateGET();
}
