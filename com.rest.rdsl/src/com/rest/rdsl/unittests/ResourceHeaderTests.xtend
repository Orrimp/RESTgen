package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourceHeaderTests 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESOURCE_HEADER_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import static org.junit.Assert.fail;
import datagenerator.JsonResource;
import datagenerator.JsonResourceGenerator;

import org.apache.http.Header;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import utility.HttpClient;
import utility.ResponseHeader;
import utility.StatusCode;

public abstract class ResourceHeaderTests extends ResourceTests
{
	abstract protected HttpClient getHttpClient();
	abstract protected JsonResourceGenerator getJsonGenerator();

	@Before
	@Override
	public void setUp()
	{
		super.setUp();
	}
	
	@After
	@Override
	public void tearDown() throws Exception
	{
		super.tearDown();
	}
	
	@Test
	public void testGetId_Successful_ContentTypeCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertContentType(response, "application/json; version=1");
	}
	
	@Test
	public void testGetId_Successful_ContentLengthCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testGetId_Successful_DateCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testGetId_Successful_EtagCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertEtag(response, (Long)resources.get(0).get("iD"));
	}
	
	@Test
	public void testGetId_Successful_LinkCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		String link = RESOURCE_BASE_URL + "/" + resources.get(0).get("iD");
		
		ResponseHeader.assertResourceLink(response, link);
	}
	
	@Test
	public void testGetId_Successful_ServerCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testGetId_UnmodifiedRessource_DateCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequestTwiceForNotModified(DEFAULT_SELF_URL);

		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testGetId_UnmodifiedRessource_EtagCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequestTwiceForNotModified(DEFAULT_SELF_URL);
		
		ResponseHeader.assertEtag(response, (Long)resources.get(0).get("iD"));
	}
	
	@Test
	public void testGetId_UnmodifiedRessource_ServerCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequestTwiceForNotModified(DEFAULT_SELF_URL);
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testGetId_ResourceNotFound_ContentLanguageCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentLanguage(response);	
	}
	
	@Test
	public void testGetId_ResourceNotFound_ContentTypeCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");	
	}
	
	@Test
	public void testGetId_ResourceNotFound_ContentLengthCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testGetId_ResourceNotFound_DateCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertDate(response);	
	}
	
	@Test
	public void testGetId_ResourceNotFound_ServerCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertServer(response);	
	}
	
	@Test
	public void testGetId_InternalServerError_ContentTypeCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testGetId_InternalServerError_ContentLanguageCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testGetId_InternalServerError_ContentLengthCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testGetId_InternalServerError_ConnectionCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");

		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testGetId_InternalServerError_DateCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
	
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testGetId_InternalServerError_ServerCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");

		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testDeleteId_Successful_DateCorrect()
	{
		CloseableHttpResponse response = super.executeDeleteRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testDeleteId_Successful_ServerCorrect()
	{
		CloseableHttpResponse response = super.executeDeleteRequest(DEFAULT_SELF_URL);
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_ContentTypeCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testDeleteId_InternalServerError_ContentLanguageCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_ContentLengthCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_ConnectionCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_DateCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_ServerCorrect()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPostResource_Successful_LocationCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		String link = RESOURCE_BASE_URL + "/" + resource.get("iD");
		
		ResponseHeader.assertLocation(response, link);
	}
	
	@Test
	public void testPostResource_Successful_LinkCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		String link = RESOURCE_BASE_URL + "/" + resource.get("iD");
		
		ResponseHeader.assertResourceLink(response, link);
	}
	
	@Test
	public void testPostResource_Successful_DateCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}

		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPostResource_Successful_ServerCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}

		ResponseHeader.assertServer(response);
	
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_ContentTypeCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_ContentLanguageCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_ContentLengthCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_ConnectionCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_DateCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_ServerCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPutResourceWithId_Successful_LinkCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePutRequest(resource, DEFAULT_SELF_URL);
		
		String link = RESOURCE_BASE_URL + "/" + resources.get(0).get("iD");

		ResponseHeader.assertResourceLink(response, link);
	}
	
	@Test
	public void testPutResourceWithId_Successful_DateCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePutRequest(resource, DEFAULT_SELF_URL);
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPutResourceWithId_Successful_ServerCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePutRequest(resource, DEFAULT_SELF_URL);
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_ContentTypeCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L); 
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_ContentLanguageCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_ContentLengthCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L); 
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_ConnectionCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_DateCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_ServerCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_ContentTypeCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_ContentLanguageCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_ContentLengthCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_ConnectionCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_DateCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_ServerCorrect()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPatchResource_NewResourceNotModified_DateCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		if(StatusCode.isOK(response))
		{
			Header[] headers = response.getHeaders("Etag");
			JsonResource resource = resources.get(0);
				
			response = super.executeConditionalPatchRequest(resource, headers[0].getValue());
		} else
		{
			fail("Could not get resource with selfURI: " + DEFAULT_SELF_URL);
		}
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPatchResource_NewResourceNotModified_EtagCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		if(StatusCode.isOK(response))
		{
			Header[] headers = response.getHeaders("Etag");
			JsonResource resource = resources.get(0);
				
			response = super.executeConditionalPatchRequest(resource, headers[0].getValue());
		} else
		{
			fail("Could not get resource with selfURI: " + DEFAULT_SELF_URL);
		}
		
		ResponseHeader.assertEtag(response, (Long)resources.get(0).get("iD"));
	}
	
	@Test
	public void testPatchResource_NewResourceNotModified_ServerCorrect()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		if(StatusCode.isOK(response))
		{
			Header[] headers = response.getHeaders("Etag");
			JsonResource resource = resources.get(0);
				
			response = super.executeConditionalPatchRequest(resource, headers[0].getValue());
		} else
		{
			fail("Could not get resource with selfURI: " + DEFAULT_SELF_URL);
		}
		
		ResponseHeader.assertServer(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_ContentTypeCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_ContentLanguageCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentLanguage(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_ContentLengthCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertContentLength(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_ConnectionCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertConnection(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_DateCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertDate(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_ServerCorrect()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseHeader.assertServer(response);
	}
}
			''');
	}
}
