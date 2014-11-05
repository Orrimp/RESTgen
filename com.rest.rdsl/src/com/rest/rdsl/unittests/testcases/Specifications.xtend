package com.rest.rdsl.unittests.testcases

import java.util.ArrayList
import java.util.List

class Specifications 
{
	val String testCasePrefix;
	val String testCaseUrl;
	
	var List<TestCaseSpecification> specifications;
	
	new(String testCasePrefix, String testCaseUrl)
	{
		this.testCasePrefix = testCasePrefix;
		this.testCaseUrl = testCaseUrl;
		this.specifications = new ArrayList<TestCaseSpecification>();
	}
	
	def status200()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status200", testCaseUrl, 
								"StatusCode.assertOK(response)")
		);
		
		return this;
	}
	
	def status201()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status201", testCaseUrl, 
								"StatusCode.assertCreated(response)")
		);
		
		return this;
	}
	
	def status204()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status204", testCaseUrl, 
								"StatusCode.assertNoContent(response)")
		);
		
		return this;
	}
	
	def status304()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status304", testCaseUrl, 
								"StatusCode.assertNotModified(response)")
		);
		
		return this;
	}
	
	def status400()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status400", testCaseUrl, 
								"StatusCode.assertBadRequest(response)")
		);
		
		return this;
	}
	
	def message400()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectBadRequestMessage", testCaseUrl, 
									  "ResponseBody.assertBadRequestMessage(response)")
		);
		
		return this;
	}
	
	def status401()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status401", testCaseUrl, 
								"StatusCode.assertUnauthorized(response)")
		);
		
		return this;
	}
	
	def message401()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectUnauthorizedMessage", testCaseUrl, 
									  "ResponseBody.assertUnauthorizedMessage(response)")
		);
		
		return this;
	}
	
	def status403()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status403", testCaseUrl, 
								"StatusCode.assertForbidden(response)")
		);
		
		return this;
	}
	
	def message403()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectForbiddenMessage", testCaseUrl, 
									  "ResponseBody.assertForbiddenMessage(response)")
		);
		
		return this;
	}
	
	def status404()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status404", testCaseUrl, 
								"StatusCode.assertNotFound(response)")
		);
		
		return this;
	}
	
	def message404()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct404Message", testCaseUrl, 
								"ResponseBody.assertNotFoundMessage(response)")
		);
		
		return this;
	}
	
	def status405()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status405", testCaseUrl,
								"StatusCode.assertMethodNotAllowed(response)")
		);
		
		return this;
	}
	
	def message405()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct405Message", testCaseUrl, 
								"ResponseBody.assertMethodNotAllowedMessage(response)")
		);
		
		return this;
	}
	
	def status412()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status412", testCaseUrl, 
								"StatusCode.assertPreconditionFailed(response)")
		);
		
		return this;
	}
	
	def message412()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct412Message", testCaseUrl, 
								"ResponseBody.assertPreconditionFailedMessage(response)")
		);
		
		return this;
	}
	
	def status415()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status415", testCaseUrl, 
								"StatusCode.assertUnsupportedMediaType(response)")
		);
		
		return this;	
	}
	
	def message415()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct415Message", testCaseUrl, 
								"ResponseBody.assertUnsupportedMediaTypeMessage(response)")
		);
		
		return this;
	}
	
	def status422()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status422", testCaseUrl, 
								"StatusCode.assertUnprocessableEntity(response)")
		);
		
		return this;
	}
	
	def message422()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct422Message", testCaseUrl, 
								"ResponseBody.assertUnprocessableEntityMessage(response)")
		);
		
		return this;
	}
	
	def status428()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status428", testCaseUrl, 
								"StatusCode.assertPreconditionRequired(response)")
		);
		
		return this;
	}
	
	def message428()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct428Message", testCaseUrl, 
								"ResponseBody.assertPreconditionFailedMessage(response)")
		);
		
		return this;
	}
	
	def status500()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Status500", testCaseUrl, 
								"StatusCode.assertInternalServerError(response)")
		);
		
		return this;
	}
	
	def message500()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "Correct500Message", testCaseUrl, 
								"ResponseBody.assertInternalServerErrorMessage(response)")
		);
		
		return this;
	}
	
	def emptyBody()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "EmptyResponseBody", testCaseUrl, 
									  "ResponseBody.assertIsEmpty(response)")
		);
		
		return this;
	}
	
	def correctJsonResource()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectJsonResource", testCaseUrl, 
									  "ResponseBody.assertResource(response, resources.get(0))")
		);
		
		return this;
	}
	
	def correctAttribute()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectAttributeValue", testCaseUrl, 
									  "ResponseBody.assertResourceAttribute(response, resources.get(0).get(attribute));")
		);
		
		return this;
	}
	
	def correctPage()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "CorrectPage", testCaseUrl, 
									  "ResponseBody.assertQueryPage(response, localResources)")
		);
		
		return this;
	}
	
	def allow(String allowedMethods)
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "AllowCorrect", testCaseUrl, 
								"ResponseHeader.assertAllow(response, \"" + allowedMethods + "\")")
		);
		
		return this;
	}
	
	def contentTypeJson()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ContentTypeCorrect", testCaseUrl, 
								"ResponseHeader.assertContentType(response, \"application/json; version=1\")")
		);
		
		return this;
	}
	
	def contentTypeTextHtml()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ContentTypeCorrect", testCaseUrl, 
								"ResponseHeader.assertContentType(response, \"text/html;charset=utf-8\")")
		);
		
		return this;
	}
	
	def contentLength()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ContentLengthCorrect", testCaseUrl, 
								"ResponseHeader.assertContentLength(response)")
		);
		
		return this;
	}
	
	def contentLanguage()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ContentLanguageCorrect", testCaseUrl, 
								"ResponseHeader.assertContentLanguage(response)")
		);
		
		return this;
	}
	
	def connection()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ConnectionCorrect", testCaseUrl, 
								"ResponseHeader.assertConnection(response)")
		);
		
		return this;
	}
	
	def date()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "DateCorrect", testCaseUrl, 
								"ResponseHeader.assertDate(response)")
		);
		
		return this;
	}
	
	def etag()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "EtagCorrect", testCaseUrl, 
									  "ResponseHeader.assertEtag(response, (Long)resources.get(0).get(\"iD\"))")
		);
		
		return this;
	}
	
	def link()
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("String link = RESOURCE_BASE_URL + \"/\" + resources.get(0).get(\"iD\")");
		
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LinkCorrect", testCaseUrl, preAssert,
									  "ResponseHeader.assertResourceLink(response, link)")
		);
		
		return this;
	}
	
	def linkPost()
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("String link = RESOURCE_BASE_URL + \"/\" + resource.get(\"iD\")");
		
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LinkCorrect", testCaseUrl, preAssert,
									  "ResponseHeader.assertResourceLink(response, link)")
		);
		
		return this;
	}
	
	def link(Long id)
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("String link = RESOURCE_BASE_URL + \"/" + id + "\"");
		
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LinkCorrect", testCaseUrl, preAssert,
									  "ResponseHeader.assertResourceLink(response, link)")
		);
		
		return this;
	}
	
	def queryLinks(int pages, int page)
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("HashMap<String,String> pageLinks = new HashMap<>()");
		if(page < pages)
		{
			preAssert.add("pageLinks.put(\"next\", \"<\" + nextUrl + \">\")");
		} else
		{	
			preAssert.add("pageLinks.put(\"next\", \"<>\")");
		}
		preAssert.add("pageLinks.put(\"current\", \"<\" + url + \">\")");
		if(page > 1)
		{
			preAssert.add("pageLinks.put(\"previous\", \"<\" + previousUrl + \">\")");
		} else
		{
			preAssert.add("pageLinks.put(\"previous\", \"<>\")");
		}
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LinkCorrect", testCaseUrl, preAssert,
									  "ResponseHeader.assertPageLinks(response, pageLinks)")
		);
		
		return this;
	}

	def locationPost()
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("String link = RESOURCE_BASE_URL + \"/\" + resource.get(\"iD\")");
		
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LocationCorrect", testCaseUrl, preAssert, 
									  "ResponseHeader.assertLocation(response, link)")
		);
		
		return this;
	}
	
	def location(Long id)
	{
		var List<String> preAssert = new ArrayList<String>();
		preAssert.add("String link = RESOURCE_BASE_URL + \"/" + id + "\"");
		
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "LocationCorrect", testCaseUrl, preAssert, 
									  "ResponseHeader.assertLocation(response, link)")
		);
		
		return this;
	}
	
	def server()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ServerCorrect", testCaseUrl, 
								"ResponseHeader.assertServer(response)")
		);
		
		return this;
	}
	
	def xCollectionLength(int size)
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "xCollectionLengthCorrect", testCaseUrl, 
									  "ResponseHeader.assertXCollectionLength(response, " + size + ")")
		);
		
		return this;
	}
	
	def reachableLinkHeader()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableLinkHeader", testCaseUrl, 
								"ResponseLinks.assertLinkHeader(response)")
		);
		
		return this;
	}
	
	def reachableLocationHeader()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableLocationHeader", testCaseUrl, 
								"ResponseLinks.assertLocationHeader(response)")
		);
		
		return this;
	}
	
	def reachableBodyLinks()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableBodyLinks", testCaseUrl, 
								"ResponseLinks.assertBodyLinks(response)")
		);
		
		return this;
	}
	
	def reachableBodySelfUri()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableBodySelfUri", testCaseUrl, 
								"ResponseLinks.assertBodySelfUri(response)")
		);
		
		return this;
	}
	
	def reachableQueryBodyLinks()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableBodyLinks", testCaseUrl, 
								"ResponseLinks.assertQueryBodyLinks(response)")
		);
		
		return this;
	}
	
	def reachableQueryBodySelfUris()
	{
		specifications.add(
			new TestCaseSpecification(testCasePrefix, "ReachableBodySelfUri", testCaseUrl, 
								"ResponseLinks.assertQueryBodySelfUris(response)")
		);
		
		return this;
	}
	
	def build()
	{
		return this.specifications;
	}
}