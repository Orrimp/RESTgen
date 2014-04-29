package com.xtext.rest.rdsl.generator.framework.jersey

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.generator.framework.IBaseResourceGenerator

class JerseyAbstractResourceGenerator implements IBaseResourceGenerator{
	
	override generate(IFileSystemAccess fsa) {
	 fsa.generateFile(Naming.CLASS_ABSTRACT_RESOURCE.generationLocation + Constants.JAVA,
	 '''
	 package «PackageManager.resourcePackage»;
	 
	 import javax.ws.rs.core.Request;
	 import javax.ws.rs.core.Context;
	 import javax.ws.rs.core.UriInfo;
	 import javax.ws.rs.core.HttpHeaders;
	 import javax.ws.rs.core.Link;
	 import java.util.List;
	 import «Naming.CLASS_LINK.classImport»;
	 import «Naming.CLASS_OBJPARENT.classImport»;
	 
	 public abstract class «Naming.CLASS_ABSTRACT_RESOURCE»{
	 	
	 	//Inject information about the URI and its components
	 	@Context
	 	protected UriInfo uriInfo;
	 	
	 	//Inject content negotiation and preconditions of the reqeust
	 	@Context 
	 	protected Request request;
	 	
	 	@Context 
	 	protected HttpHeaders headers;
	 	
	 	protected Link[] getLinks(«Naming.CLASS_OBJPARENT» resourceObject){
	 		
	 		List<«Naming.CLASS_LINK»> links = resourceObject.getLinks();
	 		Link[] reLinks = new Link[links.size()];
	 		
	 		for(int i  = 0; i < links.size(); ++i){
	 			reLinks[i] = Link.fromUri(links.get(i).getURI()).rel(links.get(i).getType()).build();
	 		}
	 		
	 		return reLinks;
	 		
	 	}
	 }
	 ''')
	}
	
}