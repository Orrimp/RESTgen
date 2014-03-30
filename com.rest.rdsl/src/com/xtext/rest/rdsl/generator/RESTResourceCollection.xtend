package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.restDsl.RESTResource
import java.util.ArrayList
import java.util.List

class RESTResourceCollection {
	
	val List<RESTResource> resources;
	var RESTResource userResource;
	
	public new (List<RESTResource> resources){
		this.resources = resources;	
	}
	
	public def RESTResource getUserResource(){
		return this.userResource;
	}
	
	public def void setUserResource(RESTResource userResource){
		if(userResource != null)
			this.userResource = userResource;
	}
	
	public def List<RESTResource> getResources(){
		
		if(resources != null){
			return this.resources;
		}
		else{
			return new ArrayList<RESTResource>();
		}
	}
}