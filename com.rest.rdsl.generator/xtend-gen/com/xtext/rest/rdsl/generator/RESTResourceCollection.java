package com.xtext.rest.rdsl.generator;

import com.google.common.base.Objects;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("all")
public class RESTResourceCollection {
  private final List<RESTResource> resources;
  
  private RESTResource userResource;
  
  public RESTResourceCollection(final List<RESTResource> resources) {
    this.resources = resources;
  }
  
  public RESTResource getUserResource() {
    return this.userResource;
  }
  
  public void setUserResource(final RESTResource userResource) {
    boolean _notEquals = (!Objects.equal(userResource, null));
    if (_notEquals) {
      this.userResource = userResource;
    }
  }
  
  public List<RESTResource> getResources() {
    boolean _notEquals = (!Objects.equal(this.resources, null));
    if (_notEquals) {
      return this.resources;
    } else {
      return new ArrayList<RESTResource>();
    }
  }
}
