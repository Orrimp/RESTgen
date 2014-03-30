package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.HTTPMETHOD
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.jersey.JerseyCacheGenerator
import com.xtext.rest.rdsl.generator.framework.MethodGenerator

class JerseyMethodGenerator extends MethodGenerator{
	
	var RESTConfiguration config = null;
	var mime = ""
	var counter = 0;
	val String idRegex;
	val String idDataType;
	val ExceptionMapper mapper;
	val String resourceName;
	val RESTResource resource;
	val JerseyCacheGenerator caching; 
	
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	new(RESTConfiguration configuration, RESTResource resource) {
		this.config = configuration;
		this.mapper = new ExceptionMapper(configuration);
		this.resource = resource;
		this.resourceName = resource.name;
		
		mime = createMime();
		idRegex = createRegex();
		idDataType = config.getIDDataTyp;
		caching = new JerseyCacheGenerator(resource, config);	
	}

	def generate(Attribute attribute){
			
		switch(attribute.method){
			case HTTPMETHOD.GET: generateGETAttribute(attribute)
			case HTTPMETHOD.DELETE: "" //To delete a value of an attribute the developer has to use PATCH or PUT method
			case HTTPMETHOD.HEAD: generateHEAD(attribute)
			case HTTPMETHOD.OPTIONS: generateOPTIONS(attribute)			
			case HTTPMETHOD.DEFAULT: generateGETAttribute(attribute)
			case HTTPMETHOD.NONE: return ""
		}
	}

	
	public override generateGETAttribute(Attribute attribute)'''
		
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
		«attribute.value.nameOfType» «attribute.name.toFirstLower» = «resourceName.toFirstLower».get«attribute.name.toFirstUpper»();
		
		return Response.ok(«attribute.name.toFirstLower»).links(getLinks(«resourceName.toFirstLower»))«header».build();
	}
	'''
	
	private def generateHEAD(Attribute attribute)'''
	««««« JAX-RS generates HEAD from GET autmoatically and resonpose wihtout a body.
	'''
	
	private def generateOPTIONS(Attribute attribute)'''
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
				«resourceName.toFirstUpper» «resourceName.toFirstLower» = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(id); 
				if(«resourceName.toFirstLower» == null)
					throw new «this.mapper.get(404).name»();
				«caching.getImplementation»
				
				return Response.ok(«resourceName.toLowerCase»).links(getLinks(«resourceName.toFirstLower»))«caching.getResponse»«header».build();
				
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
	
	//TODO add links to next and prev. Try-Catch
	/**
	 * Generates a method for List<Object> support. The client can request multiple resources at once
	 */
	public def generateQuery(Attribute attribute) {	
		val ListReference reference = attribute.value as ListReference;		
		'''
		@GET
		@Path("/{id «idRegex»}/«reference.innerType.name.toLowerCase»/{page}")
		@Produces(«mime»)
		@«Naming.ANNO_USER_AUTH»
		public Response get«reference.innerType.name.toFirstUpper»(
			«FOR attrib: reference.innerType.attributes»
			«IF !(attrib.value instanceof ListReference)»
			@QueryParam("«attrib.name»") «attrib.value.simpleNameOfType» «attrib.name»,
			«ENDIF»
			«ENDFOR»
			@PathParam("page") int page, @PathParam("id") «config.getIDDataTyp» id){
			
			try{
				int elementsPerPage = «config.paging.elementsCount»;
				
				«Naming.CLASS_DB_QUERY» «Naming.CLASS_DB_QUERY.toString.toLowerCase»  = new «Naming.CLASS_DB_QUERY»();
				«FOR attrib: reference.innerType.attributes»
				«IF !(attrib.value instanceof ListReference)»
				«Naming.CLASS_DB_QUERY.toString.toLowerCase».put("«attrib.name»", «attrib.name»);
				«ENDIF»
				«ENDFOR»
				«Naming.CLASS_DB_QUERY.toString.toLowerCase».setOffset((page*«config.paging.elementsCount»)-«config.paging.elementsCount»);
				«Naming.CLASS_DB_QUERY.toString.toLowerCase».setLimit(«config.paging.elementsCount»);
				«Naming.CLASS_DB_QUERY.toString.toLowerCase».setTable("«resourceName»");
				
				int count = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName»DAO().count(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
				List<«resource.name»> list = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName»DAO().list(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
			
				«resourceCollectionLinks»
				return Response.ok(list).link(previous, "previous").link(current, "current").link(next, "next")
				   .header("x-Collection-Length", "" + list.size())«header».build();
			}catch(Exception ex){
				«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
				customEx.setInnerException(ex);
				throw customEx;
			}
		
		}
		
		'''	
	}
	
	/**
	 * Generates a method for query support on this object. The client can request multiple resources at once
	 */
	public def generateQuery() {	
		val String querName = Naming.CLASS_DB_QUERY.toString.toLowerCase ;
		'''
		@GET
		@Path("/query/{page}")
		@Produces(«mime»)
		@«Naming.ANNO_USER_AUTH»
		public Response get«resourceName»Query(
			«FOR attrib: resource.attributes»
			«IF !(attrib.value instanceof ListReference)»
			@QueryParam("«attrib.name»") «attrib.value.simpleNameOfType» «attrib.name»,
			«ENDIF»
			«ENDFOR»
			@PathParam("page") int page){
				
			try{
				
			«Naming.CLASS_DB_QUERY» «Naming.CLASS_DB_QUERY.toString.toLowerCase»  = new «Naming.CLASS_DB_QUERY»();
			«FOR attrib: resource.attributes»
			«IF !(attrib.value instanceof ListReference)»
			«querName».put("«attrib.name»", «attrib.name»);
			«ENDIF»
			«ENDFOR»
			«querName».setOffset((page*«config.paging.elementsCount»)-«config.paging.elementsCount»);
			«querName».setLimit(«config.paging.elementsCount»);
			«querName».setTable("«resourceName»");
			
			int count = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName»DAO().count(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
			
			«getResourceCollectionLinks()»
			
			List<«resource.name»> list = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName»DAO().list(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
		
			return Response.ok(list ).link(previous, "previous").link(current, "current").link(next, "next")
				   .header("x-Collection-Length", "" + count)«header».build();
				   
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
	public override generatePUT()'''
	
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
		 		«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().update(«resourceName.toFirstLower», id);
		 		return Response.ok().links(getLinks(«resourceName.toFirstLower»))«header».build();
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
	public override generatePOST(){
		
		val String uriPart = config.basePath  + "/" + resourceName.toLowerCase + "/";
	'''
	@POST
	@«Naming.ANNO_USER_AUTH»
	@Consumes(«mime»)
	public Response post«resourceName.toFirstUpper»(«resourceName.toFirstUpper» «resourceName.toFirstLower»){
		
		try{
			«resourceName.toFirstUpper»  res = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(«resourceName.toFirstLower».«Naming.METHOD_NAME_ID_GET»());
			if(res==null){
				«Naming.INTERFACE_ID» idGen = new «Naming.CLASS_ID»();
				«idDataType» newID  = idGen.generateID();
				URI newUri = new URI("«uriPart»" + newID);
				«resourceName.toFirstLower».setID(newID);
				«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().save(«resourceName.toFirstLower»);  
				return Response.created(newUri).links(getLinks(«resourceName.toFirstLower»))«header».build(); 
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
 			«resourceName.toFirstUpper»  «resourceName.toLowerCase»Retrieved = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().load(«resourceName.toFirstLower».«Naming.METHOD_NAME_ID_GET»());

	 	//No Instance in Database -> Creation
		 	if(«resourceName.toLowerCase»Retrieved == null){
		 		throw new «mapper.get(404).name»();
		 	}else{
		 		«caching.getImplementation»
		 		«FOR attrib: resource.attributes»
		 		if( «resourceName.toFirstLower».get«attrib.name.toFirstUpper»() == null)
		 			«resourceName.toFirstLower».set«attrib.name.toFirstUpper»(«resourceName.toLowerCase»Retrieved.get«attrib.name.toFirstUpper»()); 
		 		
		 		«ENDFOR»
		 		«Naming.ABSTRACT_CLASS_DAO».getInstance().create«resourceName.toFirstUpper»DAO().update(«resourceName.toLowerCase»,  «resourceName.toFirstLower».«Naming.METHOD_NAME_ID_GET»());
		 		return Response.noContent().links(getLinks(«resourceName.toFirstLower»))«caching.getResponse»«header».build();
		 	}
	 	}catch(Exception ex){
			«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
			customEx.setInnerException(ex);
			throw customEx;
		}
	}
	
	'''
	}
	
	private def getResourceCollectionLinks() {
		'''
		URI current = super.uriInfo.getAbsolutePath();
		String previous = (page > 1 && count > «config.paging.elementsCount») ? "«config.basePath»"  + 	"/«resource.name.toLowerCase»/query/" + (page-1) : ""; 
		String next= (page*«config.paging.elementsCount» < count) ? "«config.basePath»" + 	"/«resource.name.toLowerCase»/query/" + (page+1) : ""; 
		'''
	}
	
	
	private def createMime() {
		//Every Mime type will be put in extra brakets		
		mime = "{"
		config.mimeType.forEach[s|mime = mime + "\"" + Constants.APPLICATION + s.literal +  "; version=" + config.apiVersion +"\"" + ","]
		mime = mime.substring(0, mime.length() - 1) 
		mime = mime + "}"
		
		return mime;
	}
	
	private def createRegex() {
		switch(config.getIDDataTyp.toLowerCase){
			case "string": 
				return  ": [a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+-[a-z0-9]+"
			case "long":
				return ": d+"
			default: 
				return ""	
		}
	}
		
	private def getName(Attribute attribute) {
		if(!attribute.name.nullOrEmpty){
			return attribute.name; 
		}			
		else{
			return "method" + attribute.method.toString.toUpperCase + (counter+1);
		}
	}
	
	private def getHeader(){
		
		var String headers = "";
		for(head: config.headers){
			headers= headers + ".header(\""+head.name + "\",\"" + head.value +  "\")";
		}
		return headers;
	}

}