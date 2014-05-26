package com.xtext.rest.rdsl.generator.framework.jersey


import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.PackageManager

class CustomJerseyFilter {

	val RESTConfiguration config;
	val IFileSystemAccess fsa;
	var RESTResource userResource = null;
	
	new(RESTConfiguration config, IFileSystemAccess fsa, RESTResource userResource) {
		this.config = config;
		this.fsa = fsa;
		this.userResource = userResource;
		
	}
		
	def generateFilter() {
		val ExceptionMapper mapper = new ExceptionMapper(config);
		var ex401 = mapper.get(401);
		var ex403 = mapper.get(403);
		
		fsa.generateFile(Naming.CLASS_USER_AUTH_FILTER.generationLocation + Constants.JAVA,
			
			'''
			package «Naming.CLASS_USER_AUTH_FILTER.packageName»;
			
			import «PackageManager.exceptionPackage».*;
			import javax.ws.rs.ext.Provider;
			import javax.ws.rs.core.HttpHeaders;
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.Response.Status;
			import javax.ws.rs.container.ContainerRequestContext;
			import javax.ws.rs.container.ContainerRequestFilter;
			import «PackageManager.objectPackage».*;
			import «Naming.CLASS_USER_AUTH_DATA.classImport»;
			import «Naming.ABSTRACT_CLASS_DAO.classImport»;
			import «PackageManager.getDatabasePackage».«userResource.name»DAO;
			
			import java.io.IOException;
			
			@Provider
			@UserAuthorization
			public class «Naming.CLASS_USER_AUTH_FILTER» implements ContainerRequestFilter {
				@Override
				public void filter(ContainerRequestContext requestContext) throws IOException {
					
					final String authHeader = requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);
					if(authHeader == null){
						requestContext.abortWith(Response.status(Status.BAD_REQUEST)
						.header(HttpHeaders.WWW_AUTHENTICATE, "Basic realm=\"realm\"")
						.entity("Authentication in header missing").build());
					}
					«userResource.name»DAO userDAO = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«userResource.name»DAO();
					«Naming.CLASS_USER_AUTH_DATA» authClass = new «Naming.CLASS_USER_AUTH_DATA»(authHeader);
					try{
						userDAO.authenticate(authClass);
					}
					catch(«ex401.name» ex){
						requestContext.abortWith(Response.status(Status.«ex401.statusString»)
						.header(HttpHeaders.WWW_AUTHENTICATE, "Basic realm=\"realm\"")
						.entity("«ex401.developerMessage»").build());
					}catch(«ex403.name» ex){
						requestContext.abortWith(Response.status(Status.«ex403.statusString»)
						.header(HttpHeaders.WWW_AUTHENTICATE, "Basic realm=\"realm\"")
						.entity("«ex403.developerMessage»").build());
					}
				}
			}
			'''
		)
	}
	
}