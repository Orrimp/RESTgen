package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.CACHING_TYPE
import com.xtext.rest.rdsl.restDsl.SingleResource

class JerseyCacheGenerator {
	
	private val SingleResource resource
	private var String response;
	private var String implementatation;
	
	new (SingleResource resource){
		this.resource = resource;
		initialize();
	}
	
	def initialize() {
		switch(resource?.traits?.caching?.type){
			case CACHING_TYPE.ETAG:  generateETAG()
			case CACHING_TYPE.EXPIRES: generateEXPIRES()
			case CACHING_TYPE.MAXAGE:  generateMAXAGE()
			case CACHING_TYPE.MODIFIED:  generateMODIFIED()
			case CACHING_TYPE.DEFAULT: generateDEFAULT()
			case CACHING_TYPE.NONE: ""
			default: return ""
		}
	}
	
	public def getImplementation(){
		return implementatation;
	}
	
	
	public def getResponse(){
		return response;
	}
	

	private def generateDEFAULT() {
		this.implementatation = generateMODIFIED() + generateEXPIRES() + generateETAG();
		this.response = generateMODIFIEDResponse() + generateEXPIRESResponse() + generateETAGResponse() 
	}
	
	
	
	
	private def generateMODIFIED() {
		this.implementatation = 
		'''
		ResponseBuilder rb = super.request.evaluatePreconditions(new Date());
		//Precondition met results in null
		if(rb!= null)
		{
			return  Response.notModified().build();
		}
		 
		''';
		this.response = generateMODIFIEDResponse();
	}
	
	private def generateMAXAGE() {
		this.implementatation = 
		'''
		CacheControl cacheControl = new CacheControl();
		cacheControl.setMaxAge(«resource.traits.caching.time»);
		 
		''';
		this.response = generatesMAXAGEResponse();
	}
	
	private def generateEXPIRES() {
		this.implementatation = '''''';
		this.response = generateEXPIRESResponse();

	}
	
	private def generateETAG() {
		this.implementatation = 
		'''
		String eTagValue = «generateETAGValue()»;
		EntityTag eTag = new EntityTag(eTagValue);
		eTagValue = "" + eTag.hashCode();
		
		ResponseBuilder rb = super.request.evaluatePreconditions(eTag);
		//Precondition met results in null
		if(rb!= null)
		{
			return  Response.notModified(eTag).build();
		}
		 
		''';
		this.response = generateETAGResponse()
	}
	
	
	private def generateETAGValue() {
		return resource.name.toFirstLower + "." + Naming.METHOD_NAME_ID_GET + "()" + " + \"" + resource.name + "\"" + " + "  + "new Date()";
	}
	
	private  def generateMODIFIEDResponse() {
		return ".lastModified(new Date())"
	}
	
	private  def generatesMAXAGEResponse() {
		return ".cacheControl(cacheControl)"
	}
	
	private  def generateEXPIRESResponse() {
		return ".expires(new Date())"
	}
	
	private  def generateETAGResponse() {
		return ".tag(eTagValue)"
	}
	
	
	
}