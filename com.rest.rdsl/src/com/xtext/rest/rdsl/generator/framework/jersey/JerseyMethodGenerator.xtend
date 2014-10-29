package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.HTTPMETHOD
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyCacheGenerator
import com.xtext.rest.rdsl.generator.framework.MethodGenerator
import com.xtext.rest.rdsl.restDsl.SingleResource
import com.xtext.rest.rdsl.generator.RESTResourceObjects

class JerseyMethodGenerator extends MethodGenerator {

	var mime = ""
	var counter = 0;
	val String idRegex;
	val String idDataType;
	val ExceptionMapper mapper;
	val String resourceName;
	val SingleResource resource;
	val JerseyCacheGenerator caching;

	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();

	val RESTResourceObjects allResources

	new(RESTResourceObjects allResources, SingleResource resource) {
		this.mapper = new ExceptionMapper();
		this.resource = resource;
		this.allResources = allResources;
		this.resourceName = resource.name;

		mime = createMime();
		idRegex = createRegex();
		idDataType = allResources.globalTraits.idtype.literal.toFirstUpper;
		caching = new JerseyCacheGenerator(resource);
	}

	def generate(Attribute attribute) {
		generateGETAttribute(attribute)

	//		switch(attribute.method){
	//			case HTTPMETHOD.GET: generateGETAttribute(attribute)
	//			case HTTPMETHOD.DELETE: "" //To delete a value of an attribute the developer has to use PATCH or PUT method
	//			case HTTPMETHOD.HEAD: generateHEAD(attribute)
	//			case HTTPMETHOD.OPTIONS: generateOPTIONS(attribute)			
	//			case HTTPMETHOD.DEFAULT: generateGETAttribute(attribute)
	//			case HTTPMETHOD.NONE: return ""
	//		}
	}

	public override generateGETAttribute(Attribute attribute){
		
		if("id".compareTo(attribute.name) == 0){
			return "";
		}
	'''
			
		@GET
		@Path("/{id «idRegex»}/«attribute.name»")
		@Produces(«mime»)
		@«Naming.ANNO_USER_AUTH»
		public Response get«getName(attribute).toFirstUpper»(@PathParam("id") «idDataType» id){
			
			«resourceName.toFirstUpper» «resourceName.toFirstLower» = null;
			try{
				
				«resourceName.toFirstLower» = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(id); 
				
			}catch(Exception ex){
				«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
				customEx.setInnerException(ex);
				throw customEx;
			}
			
			if(«resourceName.toFirstLower» == null){
				throw new «mapper.get(404).name»();
			}
			
			//Generate ETag
			«attribute.value.nameOfType» «attribute.name.toFirstLower» = «resourceName.toFirstLower».get«attribute.name.
			toFirstUpper»();
			
			return Response.ok(«attribute.name.toFirstLower»).links(null)«header».build();
		}
	'''
	}
	
	
	private def generateHEAD(Attribute attribute) '''
	««««« JAX-RS generates HEAD from GET autmoatically and resonpose wihtout a body.
	'''

	private def generateOPTIONS(Attribute attribute) '''
	««««« JAXR-RS generates OPTIONS and returns WADL in the body
	'''

	override generateDELETE() {
		'''
			@DELETE
			@Path("/{id «idRegex»}")
			@«Naming.ANNO_USER_AUTH»
			public Response deleteId(@PathParam("id") «idDataType» id){  	
				
				try{		
					«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().delete(id);
					return Response.noContent()«header».build();
				}catch(Exception ex){
					«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
					customEx.setInnerException(ex);
					throw customEx;
				}
			}
		'''
	}

	override generateGET() {
		'''
			@GET
			@Path("/{id «idRegex»}")
			@Produces(«mime»)
			@«Naming.ANNO_USER_AUTH»
			public Response getId(@PathParam("id") «idDataType» id){
				
				try{
					«resourceName.toFirstUpper» «resourceName.toFirstLower» = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.
				toFirstUpper»DAO().load(id); 
					if(«resourceName.toFirstLower» == null)
						throw new «this.mapper.get(404).name»();
					«caching.getImplementation»
					
					return Response.ok(«resourceName.toFirstLower»).links(null)«caching.getResponse»«header».build();
					
				}catch(«this.mapper.get(404).name» ext){
					throw ext;
						
				}catch(Exception ex){
					«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
					customEx.setInnerException(ex);
					throw customEx;
				}
				
			}
		'''
	}

	/**
	 * PUT is only usefull with the object. 
	 * It is bad idea to update attributes with a PUT instead the whole object should be updated.
	 * PUT creates no response body, because PUT is only for updating and creating. 
	 */
	public override generatePUT() '''
		
		@PUT
		@Path("/{id «idRegex»}")
		@Consumes(«mime»)
		@«Naming.ANNO_USER_AUTH»
		public Response put«resourceName.toFirstUpper»WithId(«resourceName.toFirstUpper» «resourceName.toFirstLower», @PathParam("id") «idDataType» id){
		 	
		 		
		 	try{
		 		«resourceName.toFirstUpper»  res = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(id);
		
			 	//No Instance in Database -> Creation
			 	if(res == null){
			 		throw new «mapper.get(404).name»();
			 	}else{
			 		«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().update(«resourceName.
			toFirstLower», id);
			 		return Response.ok().links(null)«header».build();
			 	}
		 	}catch(Exception ex){
		 	«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
		 	customEx.setInnerException(ex);
		 	throw customEx;
			}
		}
	'''

	/**
	 * POST is only made for creation.
	 * As return the client gets NO BODY but a header with a location of the new element. 
	 */
	public override generatePOST() {

		val String uriPart = allResources.dispatcheResource.basePath + "/" + resourceName.toLowerCase + "/";
		'''
			@POST
			@«Naming.ANNO_USER_AUTH»
			@Consumes(«mime»)
			public Response post«resourceName.toFirstUpper»(«resourceName.toFirstUpper» «resourceName.toFirstLower»){
				
				try{
					«resourceName.toFirstUpper»  res = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(«resourceName.
				toFirstLower».«Naming.METHOD_NAME_ID_GET»());
					if(res==null){
						«Naming.INTERFACE_ID» idGen = «Naming.CLASS_ID».getInstance();
						«idDataType» newID  = idGen.generateID();
						URI newUri = new URI("«uriPart»" + newID);
						«resourceName.toFirstLower».setID(newID);
						«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().save(«resourceName.toFirstLower»);  
						return Response.created(newUri).links(null)«header».build(); 
					}else{
						throw new «mapper.get(400).name»();
					}	
				}catch(Exception ex){
					«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
					customEx.setInnerException(ex);
					throw customEx;
				}
			}
		'''
	}

	public override generatePATCH() {
		'''
			@PATCH
			@«Naming.ANNO_USER_AUTH»
			@Consumes(«mime»)
			public Response patch«resourceName.toFirstUpper»(«resourceName.toFirstUpper» «resourceName.toFirstLower»){
				
					try{
						«resourceName.toFirstUpper»  «resourceName.toLowerCase»Retrieved = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.
				toFirstUpper»DAO().load(«resourceName.toFirstLower».«Naming.METHOD_NAME_ID_GET»());
			
			 	//No Instance in Database -> Creation
			 		if(«resourceName.toLowerCase»Retrieved == null){
			 			throw new «mapper.get(404).name»();
			 		}else{
			 			«caching.getImplementation»
			 			«FOR attrib : resource.resources.get(0).attributes»
			 				if( «resourceName.toFirstLower».get«attrib.name.toFirstUpper»() == null)
			 					«resourceName.toFirstLower».set«attrib.name.toFirstUpper»(«resourceName.toLowerCase»Retrieved.get«attrib.name.
				toFirstUpper»()); 
			 				
			 			«ENDFOR»
			 			«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().update(«resourceName.toLowerCase»,  «resourceName.
				toFirstLower».«Naming.METHOD_NAME_ID_GET»());
			 			return Response.noContent().links(null)«caching.getResponse»«header».build();
			 		}
			 	}catch(Exception ex){
			 	«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
			 	customEx.setInnerException(ex);
			 	throw customEx;
				}
			}
		'''
	}

	private def createMime() {
		var String mimeType = "";
		if (this.allResources.globalTraits.isIsMIME) {
			mimeType = Constants.APPLICATION + this.allResources.globalTraits.mimeType.literal;
		} else {
			mimeType = Constants.APPLICATION + "json"
		}

		//		//Every Mime type will be put in extra brakets		
		//		mime = "{"
		//		config.mimeType.forEach[s|mime = mime + "\"" + Constants.APPLICATION + s.literal +  "; version=" + config.apiVersion +"\"" + ","]
		//		mime = mime.substring(0, mime.length() - 1) 
		//		mime = mime + "}"
		return "\"{" + mimeType + "}\"";
	}

	private def createRegex() {
		if (!this.allResources.globalTraits.isIsIdType) {
			return "";
		}

		switch (this.allResources.globalTraits.idtype.literal.toLowerCase) {
			case "string":
				return ": ([a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+"
			case "long":
				return ": \\\\d+"
			default:
				return ""
		}
	}

	private def getName(Attribute attribute) {
		if (!attribute.name.nullOrEmpty) {
			return attribute.name;
		} else {
			return "method" + attribute?.name?.toString?.toUpperCase + (counter + 1);
		}
	}

	private def getHeader() {
		var String headers = "";
		if (this.allResources.globalTraits.isIsCustomHeader) {
			for (head : this.allResources.globalTraits.headers) {
				headers = headers + ".header(\"" + head.name + "\",\"" + head.value + "\")";
			}
		}

		return headers;
	}

}
