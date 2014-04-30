package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.restDsl.ResourceType
import java.util.ArrayList
import java.util.List

class ResourceTypeCollection {
	
	val List<ResourceType> resources;
	var ResourceType userResource;
	
	public new (List<ResourceType> resources){
		this.resources = resources;	
	}
	
	public def ResourceType getUserResource(){
		return this.userResource;
	}
	
	public def void setUserResource(ResourceType userResource){
		if(userResource != null)
			this.userResource = userResource;
	}
	
	public def List<ResourceType> getResources(){
		
		if(resources != null){
			return this.resources;
		}
		else{
			return new ArrayList<ResourceType>();
		}
	}
}