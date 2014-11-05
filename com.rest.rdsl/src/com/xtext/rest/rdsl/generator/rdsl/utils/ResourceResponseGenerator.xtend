package com.xtext.rest.rdsl.generator.rdsl.utils

import com.xtext.rest.rdsl.generator.RESTResourceObjects
import com.xtext.rest.rdsl.management.Constants
import java.util.List
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTState

class ResourceResponseGenerator {

	val List<RESTState> colresources;

	new(IFileSystemAccess fsa, RESTResourceObjects resourceCol) {
		this.colresources = resourceCol.singleResources;
		for (RESTState res : colresources) {
			
			if(res.traits.name != null){
				fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + res.name.toFirstUpper + "Response" + Constants.JAVA, getCollResponse(res));
			}else{
				fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + res.name.toFirstUpper + "GetResponse" + Constants.JAVA, getResponse(res));
				fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + res.name.toFirstUpper + "PostResponse" + Constants.JAVA, postResponse(res));
				fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + res.name.toFirstUpper + "DeleteResponse" + Constants.JAVA, deleteResonse(res));
				fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + res.name.toFirstUpper + "UpdateResponse" + Constants.JAVA, putResponse(res));
			}
			
		}

	}
	
	def getCollResponse(RESTState resource) {
		'''
		/**
		* @author Peter Braun
		*
		* @param <T>
		*/
		
		package «PackageManager.getResponsePackage»;
		
		import java.net.URI;

		import javax.ws.rs.core.Response.ResponseBuilder;
		import javax.ws.rs.core.UriBuilder;
		import javax.ws.rs.core.UriInfo;
		
		import «PackageManager.getObjectPackage».*;
		
		public class «resource.name.toFirstUpper»Response extends AbstractGetCollectionResponse<«resource.name.toFirstUpper»>
		{
			public static «resource.name.toFirstUpper»ResponseBuilder create( UriInfo uriInfo )
			{
				return new «resource.name.toFirstUpper»ResponseBuilder( uriInfo );
			}
		
			private «resource.name.toFirstUpper»Response( )
			{
				super( );
			}
		
			public static class «resource.name.toFirstUpper»ResponseBuilder extends
				AbstractGetCollectionResponse.CollectionResponseBuilder<«resource.name.toFirstUpper»>
			{
				public «resource.name.toFirstUpper»ResponseBuilder( UriInfo uriInfo )
				{
					super( uriInfo );
				}
		
				@Override
				protected void _build( ResponseBuilder builder )
				{
					super._build( builder );
					addLinkToCreate«resource.traits.name.toFirstUpper»( builder );
				}
		
				private void addLinkToCreate«resource.traits.name.toFirstUpper»( ResponseBuilder builder )
				{
					UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder( );
					URI create«resource.traits.name.toFirstUpper»Uri = uriBuilder.build( );
					builder.link( create«resource.traits.name.toFirstUpper»Uri, "create_new«resource.traits.name.toLowerCase»" );
				}
			}
		}
		'''
	}

	def getResponse(RESTState resource) {

		var boolean isResourceBoundToCol = false;

		for (RESTState res : colresources) {
			if(resource.traits.name != null){
				isResourceBoundToCol = true;
			}
		}

		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			import java.net.URI;
			  
			import javax.ws.rs.core.Response.ResponseBuilder;
			import javax.ws.rs.core.UriBuilder;
			import javax.ws.rs.core.UriInfo;
			
			import «PackageManager.getObjectPackage».*;
			  
			public class «resource.name.toFirstUpper»GetResponse extends AbstractGetResponse<«resource.name.toFirstUpper»>
			{
				public static «resource.name.toFirstUpper»ResponseBuilder create( UriInfo uriInfo )
				{
					return new «resource.name.toFirstUpper»ResponseBuilder( uriInfo );
				}
			  
				protected «resource.name.toFirstUpper»GetResponse( )
				{
					super( );
				}
			  
				public static class «resource.name.toFirstUpper»ResponseBuilder extends AbstractGetResponse.SingleResponseBuilder<«resource.name.toFirstUpper»>
				{
					protected «resource.name.toFirstUpper»ResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			  
					public void _build( ResponseBuilder builder )
					{
						addLinkToCreate«resource.name.toFirstUpper»( builder );
						addLinkToUpdate«resource.name.toFirstUpper»( builder );
						addLinkToDelete«resource.name.toFirstUpper»( builder );
						
						«IF isResourceBoundToCol»
						addLinkToGetAll«resource.name.toFirstUpper»( builder );
						«ENDIF»
					}
			  
					«this.createURI("update", resource.name)»
					«this.createURI("create", resource.name)»
					«this.createURI("delete", resource.name)»
			
			«IF isResourceBoundToCol»
				«createCollectionResourceLink(resource)»
			«ENDIF»
				}
			}
		'''
	}

	def putResponse(RESTState resource) {
		'''
		/**
		* @author Peter Braun
		*
		* @param <T>
		*/
		
		package «PackageManager.getResponsePackage»;
		
		import javax.ws.rs.core.UriInfo;
		 
		 
		public class «resource.name.toFirstUpper»UpdateResponse extends AbstractUpdateResponse
		{
			public static «resource.name.toFirstUpper»UpdateResponseBuilder create( UriInfo uriInfo )
			{
				return new «resource.name.toFirstUpper»UpdateResponseBuilder( uriInfo );
			}
		 
			protected «resource.name.toFirstUpper»UpdateResponse( )
			{
				super( );
			}
		 
			public static class «resource.name.toFirstUpper»UpdateResponseBuilder extends AbstractUpdateResponse.AbstractUpdateResponseBuilder
			{
		 
				protected «resource.name.toFirstUpper»UpdateResponseBuilder( UriInfo uriInfo )
				{
					super( uriInfo );
				}
		 
			}
		}
				
		'''
	}

	def postResponse(RESTState resource) {
		
		val int lastIndex = resource.resources.get(0).attributes.length -1;
		val String idDataType = (resource.resources.get(0).attributes.get(lastIndex).value as JavaReference).javaDataType.dataType.literal
		
		'''
		/**
		* @author Peter Braun
		*
		* @param <T>
		*/
		 
		package «PackageManager.getResponsePackage»;
		 
		import javax.ws.rs.core.UriInfo;
		 
		public class «resource.name.toFirstUpper»PostResponse extends AbstractPostResponse<«idDataType.toFirstUpper»>
		{
			public static «resource.name.toFirstUpper»ReponseBuilder create( UriInfo uriInfo )
			{
				return new «resource.name.toFirstUpper»ReponseBuilder( uriInfo );
			}
		  
			protected «resource.name.toFirstUpper»PostResponse( )
			{
				super( );
			}
		  
			public static class «resource.name.toFirstUpper»ReponseBuilder extends AbstractPostResponse.AbstractPostResponseBuilder<«idDataType.toFirstUpper»>
			{
				public «resource.name.toFirstUpper»ReponseBuilder( UriInfo uriInfo )
				{
					super( uriInfo );
				}
			}
		}
		
		'''
	}

	def deleteResonse(RESTState resource) {
		'''
		/**
		* @author Peter Braun
		*
		* @param <T>
		*/
		 
		package «PackageManager.getResponsePackage»;
		 
		import javax.ws.rs.core.UriInfo;
		 
		public class «resource.name.toFirstUpper»DeleteResponse extends AbstractDeleteResponse
		{
			public static «resource.name.toFirstUpper»DeleteResponseBuilder create( UriInfo uriInfo )
			{
				return new «resource.name.toFirstUpper»DeleteResponseBuilder( uriInfo );
			}
		 
			protected «resource.name.toFirstUpper»DeleteResponse( )
			{
				super( );
			}
		 
			public static class «resource.name.toFirstUpper»DeleteResponseBuilder extends AbstractDeleteResponse.AbstractDeleteResponseBuilder
			{
		 
				protected «resource.name.toFirstUpper»DeleteResponseBuilder( UriInfo uriInfo )
				{
					super( uriInfo );
				}
		 
			}
		}
		'''
	}

	def createURI(String method, String name) {

		'''
			private void addLinkTo«method.toFirstUpper»«name.toFirstUpper»( ResponseBuilder response )
			{
				UriBuilder builder = uriInfo.getAbsolutePathBuilder( );
				URI create«name.toFirstUpper»Uri = builder.path( "«name.toFirstLower»" ).build( );
				response.link( create«name.toFirstUpper»Uri, "«method.toLowerCase»_«name.toLowerCase»" );
			}
		'''
	}

	def createCollectionResourceLink(RESTState colRes) {
		
		'''
			private void addLinkToGetAll«colRes.traits.name.toFirstUpper»( ResponseBuilder response )
			{
				UriBuilder builder = uriInfo.getAbsolutePathBuilder( );
				URI create«colRes.traits.name.toFirstUpper»Uri = builder.path( "«colRes.traits.name.toLowerCase»" )
					.queryParam( "offset", "{offset}" )
					.queryParam( "size", "{size}" )
					.build( 0, 10 );
				response.link( create«colRes.traits.name.toFirstUpper»Uri, "get_«colRes.traits.name.toLowerCase»" );
			}
		'''
	}

}
