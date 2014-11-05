package com.rest.rdsl.unittests.testcases

class SpecificationsBuilder 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
	}
	
	def buildInternalServerError()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status500()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .connection()
															  .date()
															  .server()
															  .message500()
															  .build();
	}
	
	def buildUnprocessableEntity()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status422()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message422()
															  .build();
	}
	
	def buildUnauthorized()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status401()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message401()
															  .build();
	}
	
	def buildBadRequest()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status400()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .connection()
															  .date()
															  .server()
															  .message400()
															  .build();
	}
	
	def buildForbidden()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status403()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message403()
															  .build();
	}
	
	def buildUnsupportedMediaType()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status415()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message415()
															  .build();
	}
	
	def buildPreconditionRequired()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status428()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message428()
															  .build();
	}
	
	def buildMethodNotAllowed(String allowedMethods)
	{
		return new Specifications(testCasePrefix, testCaseUrl).status405()
															  .allow(allowedMethods)
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message405()
															  .build();
	}
	
	def buildCreated(Long id)
	{
		return new Specifications(testCasePrefix, testCaseUrl).status201()
															  .date()
															  .link(id)
															  .location(id)
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildSuccessfulGET()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status200()
															  .contentTypeJson()
															  .contentLength()
															  .date()
															  .etag()
															  .link()
															  .server()
															  .correctJsonResource()
															  .build();
	}
	
	def buildSuccessfulGETAttribute()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status200()
															  .contentTypeJson()
															  .contentLength()
															  .date()
															  .link()
															  .server()
															  .correctAttribute()
															  .build();
	}
	
	def buildSuccessfulGETQueryPageOneOfOne()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status200()
															  .contentTypeJson()
															  .contentLength()
															  .date()
															  .queryLinks(1, 1)
															  .server()
															  .xCollectionLength(5)
															  .correctPage()
															  .build();
	}
	
	def buildSuccessfulGETQueryPageOneOfTwo()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status200()
															  .contentTypeJson()
															  .contentLength()
															  .date()
															  .queryLinks(2, 1)
															  .server()
															  .xCollectionLength(15)
															  .correctPage()
															  .build();
	}
	
	def buildSuccessfulGETQueryPageTwoOfTwo()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status200()
															  .contentTypeJson()
															  .contentLength()
															  .date()
															  .queryLinks(2, 2)
															  .server()
															  .xCollectionLength(15)
															  .correctPage()
															  .build();
	}
	
	def buildSuccessfulDELETE()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status204()
															  .date()
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildSuccessfulPUT()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status204()
															  .date()
															  .link()
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildSuccessfulPOST()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status201()
															  .date()
															  .linkPost()
															  .locationPost()
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildSuccessfulPATCH()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status204()
															  .date()
															  .etag()
															  .link()
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildNotFound()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status404()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message404()
															  .build();
	}
	
	def buildNotModified()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status304()
															  .date()
															  .etag()
															  .server()
															  .emptyBody()
															  .build();
	}
	
	def buildPreconditionFailed()
	{
		return new Specifications(testCasePrefix, testCaseUrl).status412()
															  .contentTypeTextHtml()
															  .contentLength()
															  .contentLanguage()
															  .date()
															  .server()
															  .message412()
															  .build();
	}
	
	def buildLinksGET()
	{
		return new Specifications(testCasePrefix, testCaseUrl).reachableLinkHeader()
															  .reachableBodyLinks()
															  .reachableBodySelfUri()
															  .build();
	}
	
	def buildLinksGETQuery()
	{
		return new Specifications(testCasePrefix, testCaseUrl).reachableLinkHeader()
															  .reachableQueryBodyLinks()
															  .reachableQueryBodySelfUris()
															  .build();
	}
	
	def buildLinksPUT()
	{
		return new Specifications(testCasePrefix, testCaseUrl).reachableLinkHeader()
															  .build();
	}
	
	def buildLinksCreated()
	{
		return new Specifications(testCasePrefix, testCaseUrl).reachableLinkHeader()
															  .reachableLocationHeader()
															  .build();
	}
	
	def buildLinksPATCH()
	{
		return new Specifications(testCasePrefix, testCaseUrl).reachableLinkHeader()
															  .build();
	}
}
