package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionDescription
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants

class JerseyExceptionMapperGenerator {
	var IFileSystemAccess fsa;
	val ExceptionMapper mapper;
	

	new(IFileSystemAccess fsa, ExceptionMapper mapper) {
		this.fsa = fsa;
		this.mapper = mapper;
	}
	

 	def generateExceptionMapper(ExceptionDescription exDesc){
 	val String mapperName = "Mapper";
	fsa.generateFile(Constants.mainPackage + Constants.EXCEPTIONPACKAGE + "/" + exDesc.name  + mapperName + Constants.JAVA,
	'''
	
	package «PackageManager.exceptionPackage»;
	 
	import javax.ws.rs.ext.ExceptionMapper;
	import javax.ws.rs.ext.Provider;
	import javax.ws.rs.core.MediaType;
	import javax.ws.rs.core.Response;
	import javax.ws.rs.core.Response.Status;
	 
	@Provider
	public class «exDesc.name»«mapperName» implements ExceptionMapper<«exDesc.name»>{
		
		@Override
		public Response toResponse(«exDesc.name» ex) {
			return Response.status(Status.«exDesc.statusString»).entity(ex).type(MediaType.APPLICATION_JSON).build();
		}
	}
	''')
		
	}
}