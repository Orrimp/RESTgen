package com.xtext.rest.rdsl.generator.rdsl.utils

import com.xtext.rest.rdsl.management.Constants
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.RESTResourceObjects
import com.xtext.rest.rdsl.management.PackageManager

class ResponseGenerator {

	new(IFileSystemAccess fsa) {
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractResponse" + Constants.JAVA, generateAbstractClass());
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractDeleteResponse" + Constants.JAVA, generateDeleteClass());
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractGetResponse" + Constants.JAVA, generateGetClass());
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractUpdateResponse" + Constants.JAVA, generatePutClass());
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractPostResponse" + Constants.JAVA, generatePostClass());
		fsa.generateFile(Constants.mainPackage + Constants.RESPONSE + "/" + "AbstractGetCollectionResponse" + Constants.JAVA, generateCollectionClasss());

	}

	public def generateAbstractClass() {
		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.UriInfo;
			
			public class AbstractResponse{
			protected AbstractResponse( ) {}
			
				public abstract static class AbstractResponseBuilder{
				protected UriInfo uriInfo;
			
					protected AbstractResponseBuilder( UriInfo uriInfo ){
						this.uriInfo = uriInfo;
					}
			
					public abstract Response build( );
				}
			}
			
		'''
	}

	public def generateGetClass() {
		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.Response.ResponseBuilder;
			import javax.ws.rs.core.UriInfo;
			
			public abstract class AbstractGetResponse<T> extends AbstractResponse
			{
			
				protected AbstractGetResponse( )
				{}
			
				public static class SingleResponseBuilder<T> extends AbstractResponse.AbstractResponseBuilder
				{
					protected T result;
			
					protected SingleResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			
					public SingleResponseBuilder<T> withResult( T result )
					{
						this.result = result;
						return this;
					}
			
					public Response build( )
					{
						ResponseBuilder builder = Response.ok( result );
			
						_build( builder );
			
						return builder.build( );
					}
			
					protected void _build( ResponseBuilder builder )
					{}
				}
			}
		'''
	}

	public def generatePutClass() {
		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.UriInfo;
			
			public class AbstractUpdateResponse extends AbstractResponse
			{
				protected AbstractUpdateResponse( )
				{
					super( );
				}
			
				public static class AbstractUpdateResponseBuilder extends AbstractResponse.AbstractResponseBuilder
				{
					public AbstractUpdateResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			
					@Override
					public Response build( )
					{
						return Response.noContent( ).build( );
					}
				}
			
			}
			
		'''
	}

	public def generatePostClass() {
		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			
			
			import java.net.URI;
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.UriBuilder;
			import javax.ws.rs.core.UriInfo;
			
			public class AbstractPostResponse<T> extends AbstractResponse
			{
				protected AbstractPostResponse( )
				{}
			
				public static class AbstractPostResponseBuilder<T> extends AbstractResponse.AbstractResponseBuilder
				{
					protected T newId;
			
					public AbstractPostResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			
					public AbstractPostResponseBuilder<T> withId( T newId )
					{
						this.newId = newId;
						return this;
					}
			
					@Override
					public Response build( )
					{
						return Response.created( createdURI( ) ).build( );
					}
			
					private URI createdURI( )
					{
						UriBuilder builder = uriInfo.getAbsolutePathBuilder( );
						return builder.path( this.newId.toString( ) ).build( );
					}
			
				}
			
			}
		'''
	}

	public def generateDeleteClass() {

		'''
			/**
			* @author Peter Braun
			*
			* @param <T>
			*/
			
			package «PackageManager.getResponsePackage»;
			
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.UriInfo;
			
			public class AbstractDeleteResponse extends AbstractResponse
			{
				protected AbstractDeleteResponse( )
				{
					super( );
				}
			
				public static class AbstractDeleteResponseBuilder extends AbstractResponse.AbstractResponseBuilder
				{
					public AbstractDeleteResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			
					«noContentBuild»
				}
			}
		'''
	}

	public def generateCollectionClasss() {
		'''
			
			/**
			* @author Peter Braun
			* @param <T>
			*/
				
			package «PackageManager.getResponsePackage»;
				
			
			import java.net.URI;
			
			import javax.ws.rs.core.Response;
			import javax.ws.rs.core.Response.ResponseBuilder;
			import javax.ws.rs.core.UriBuilder;
			import javax.ws.rs.core.UriInfo;
			
			public abstract class AbstractGetCollectionResponse<T> extends AbstractResponse
			{
				protected AbstractGetCollectionResponse( )
				{}
			
				public abstract static class CollectionResponseBuilder<T> extends AbstractResponse.AbstractResponseBuilder
				{
					private T result;
					protected int offsetFromRequest;
					protected int sizeFromRequest;
					protected int totalNumberOfResults;
			
					protected CollectionResponseBuilder( UriInfo uriInfo )
					{
						super( uriInfo );
					}
			
					public CollectionResponseBuilder<T> usingUri( UriInfo uriInfo )
					{
						this.uriInfo = uriInfo;
						return this;
					}
			
					public CollectionResponseBuilder<T> withResult( T result )
					{
						this.result = result;
						return this;
					}
			
					public CollectionResponseBuilder<T> requestedOffsetWas( int offset )
					{
						this.offsetFromRequest = Math.max( 0, offset );
						return this;
					}
			
					public CollectionResponseBuilder<T> requestedSizeWas( int size )
					{
						this.sizeFromRequest = Math.max( 1, size );
						return this;
					}
			
					public CollectionResponseBuilder<T> totalSizeIs( int size )
					{
						this.totalNumberOfResults = size;
						return this;
					}
			
					@Override
					public Response build( )
					{
						ResponseBuilder builder = Response.ok( result );
			
						addPrevLink( builder );
						addNextLink( builder );
						addTotalNumberOfResults( builder );
			
						_build( builder );
			
						return builder.build( );
					}
			
					protected void _build( ResponseBuilder builder )
					{}
			
					private void addPrevLink( ResponseBuilder builder )
					{
						if ( hasPrevLink( ) )
						{
							builder.link( getPrevUri( uriInfo ), "prev" );
						}
					}
			
					private void addNextLink( ResponseBuilder builder )
					{
						if ( hasNextLink( ) )
						{
							builder.link( getNextUri( uriInfo ), "next" );
						}
					}
			
					private void addTotalNumberOfResults( ResponseBuilder builder )
					{
						builder.header( "X-zettelkasten-totalnumberofresults", Integer.toString( this.totalNumberOfResults ) );
					}
			
					private boolean hasPrevLink( )
					{
						return this.offsetFromRequest > 0;
					}
			
					private boolean hasNextLink( )
					{
						return this.offsetFromRequest + this.sizeFromRequest < this.totalNumberOfResults;
					}
			
					private URI getPrevUri( UriInfo uriInfo )
					{
						UriBuilder uriBuilder = createUriBuilder( uriInfo );
			
						int newOffset = Math.max( this.offsetFromRequest - sizeFromRequest, 0 );
						int newSize = Math.min( this.sizeFromRequest, this.offsetFromRequest );
			
						return uriBuilder.build( newOffset, newSize );
					}
			
					private URI getNextUri( UriInfo uriInfo )
					{
						UriBuilder uriBuilder = createUriBuilder( uriInfo );
			
						int newOffset = Math.min( this.offsetFromRequest + sizeFromRequest, this.totalNumberOfResults - 1 );
						int newSize = Math.min( this.sizeFromRequest, this.totalNumberOfResults - newOffset );
			
						return uriBuilder.build( newOffset, newSize );
					}
			
					private UriBuilder createUriBuilder( UriInfo uriInfo )
					{
						return uriInfo.getAbsolutePathBuilder( ).queryParam( "offset", "{offset}" ).queryParam( "size", "{size}" );
					}
				}
			
			}
		'''
	}

	def noContentBuild() {
		'''
		@Override
		public Response build( )
		{
			return Response.noContent( ).build( );
		}'''
	}

}
