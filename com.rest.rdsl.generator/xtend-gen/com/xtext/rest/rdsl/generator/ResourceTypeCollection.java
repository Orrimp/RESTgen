package com.xtext.rest.rdsl.generator;

import com.google.common.base.Objects;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("all")
public class ResourceTypeCollection {
  private final List<ResourceType> resources;
  
  private ResourceType userResource;
  
  public ResourceTypeCollection(final List<ResourceType> resources) {
    this.resources = resources;
  }
  
  public ResourceType getUserResource() {
    return this.userResource;
  }
  
  public void setUserResource(final ResourceType userResource) {
    boolean _notEquals = (!Objects.equal(userResource, null));
    if (_notEquals) {
      this.userResource = userResource;
    }
  }
  
  public List<ResourceType> getResources() {
    boolean _notEquals = (!Objects.equal(this.resources, null));
    if (_notEquals) {
      return this.resources;
    } else {
      return new ArrayList<ResourceType>();
    }
  }
}
