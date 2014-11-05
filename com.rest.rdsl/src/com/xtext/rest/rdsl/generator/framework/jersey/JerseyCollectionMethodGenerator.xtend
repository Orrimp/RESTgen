package com.xtext.rest.rdsl.generator.framework.jersey

import com.xtext.rest.rdsl.generator.RESTResourceObjects
import com.xtext.rest.rdsl.restDsl.Pagination
import com.xtext.rest.rdsl.restDsl.Caching
import com.xtext.rest.rdsl.restDsl.OffsetPagination
import com.xtext.rest.rdsl.restDsl.CursorPagination
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.RESTState
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.generator.resouces.interal.ExceptionMapper

public class JerseyCollectionMethodGenerator {

	val RESTResourceObjects allResources
	var boolean isPaginationActive;
	var boolean isCachingActive;
	var int pagecount = 0;
	val ExceptionMapper mapper

	public new(RESTResourceObjects allResources) {
		this.mapper = new ExceptionMapper();
		this.allResources = allResources;
		//analyzeResource();
	}

	private def void analyzeResource() {
//		if (resource.traits.extra instanceof Pagination) {
//			isPaginationActive = (resource.traits.extra  as Pagination).isIsPagination
//		} else if (resource.traits.extra instanceof Caching) {
//			isCachingActive = (resource.traits.extra as Caching).isIsCaching;
//		}
	}

	private def getResourceCollectionLinks() {
//		if (isPaginationActive) {
//			if (resource.traits.extra instanceof OffsetPagination) {
//			this.pagecount = (resource.traits.extra as OffsetPagination).elementsCount;
//				'''
//					final URI current = super.uriInfo.getAbsolutePath();
//					final String previous = (page > 1 && count > «(resource.traits.extra as Pagination).paging.elementsCount») ? "«allResources.
//						dispatcheResource.basePath»"  + 	"/«resource.name.toLowerCase»/query/" + (page-1) : ""; 
//					final String next= (page*«(resource.traits.extra as Pagination).paging.elementsCount» < count) ? "«allResources.
//						dispatcheResource.basePath»" + 	"/«resource.name.toLowerCase»/query/" + (page+1) : ""; 
//				'''
//
//			} else if (resource.traits.extra instanceof CursorPagination) {
//				this.pagecount = (resource.traits.extra as CursorPagination).elementsCount;
//			}
//		}
	}

	/**
	 * Generates a method for List<Object> support. The client can request multiple resources at once
	 */
	public def generateQuery() {
		'''
«««		@GET
«««		@Path("/{id }/«resource.name.toLowerCase»/{page}")
«««		@Produces({application/json})
«««		@«Naming.ANNO_USER_AUTH»
«««		public Response get«resource.name.toFirstUpper»(
«««			«FOR attrib: boundResource.resources.get(0).attributes»
«««			«IF !(attrib.value instanceof JavaReference)»
«««			@QueryParam("«attrib.name»") «(attrib.value as JavaReference).javaDataType.dataType.literal» «attrib.name»,
«««			«ENDIF»
«««			«ENDFOR»
«««			@PathParam("page") int page, @PathParam("id") String id){
«««			
«««			try{
«««				int elementsPerPage = «pagecount»;
«««				
«««				//Build Query for the database here
«««				
«««				int count = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resource.name»DAO().count(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
«««				List<«resource.name»> list = «Naming.ABSTRACT_CLASS_DAO».getInstance().create«resource.name»DAO().list(«Naming.CLASS_DB_QUERY.toString.toLowerCase»);
«««				
«««				«resourceCollectionLinks»
«««				return Response.ok(list).link(previous, "previous").link(current, "current").link(next, "next")
«««				   .header("x-Collection-Length", "" + list.size()).build();
«««			}catch(Exception ex){
«««				«mapper.get(400).name» customEx = new  «mapper.get(400).name»();
«««				customEx.setInnerException(ex);
«««				throw customEx;
«««			}
«««		
«««		}
		
		'''
	}
}
