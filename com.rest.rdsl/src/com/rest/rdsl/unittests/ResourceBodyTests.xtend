package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants

class ResourceBodyTests 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESOURCE_BODY_TESTS.generationLocation + Constants.JAVA, "unit-test",
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
import utility.ResponseBody;
import utility.StatusCode;

public abstract class ResourceBodyTests extends ResourceTests
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
	public void testGetId_Successful_CorrectJsonResource()
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);
		
		ResponseBody.assertResource(response, resources.get(0));
	}
	
	@Test
	public void testGetId_UnmodifiedRessource_EmptyResponseBody()
	{
		CloseableHttpResponse response = super.executeGetRequestTwiceForNotModified(DEFAULT_SELF_URL);
		
		ResponseBody.assertIsEmpty(response);
	}
	
	@Test
	public void testGetId_ResourceNotFound_Correct404Message()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		ResponseBody.assertResourceNotFoundMessage(response);
	}
	
	@Test
	public void testGetId_InternalServerError_Correct500Message()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseBody.assertInternalServerErrorMessage(response);
	}
	
	@Test
	public void testDeleteId_Successful_EmptyResponseBody()
	{
		CloseableHttpResponse response = super.executeDeleteRequest(DEFAULT_SELF_URL);
		
		ResponseBody.assertIsEmpty(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_Correct500Message()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		ResponseBody.assertInternalServerErrorMessage(response);
	}
	
	@Test
	public void testPostResource_Successful_EmptyResponseBody()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}

		ResponseBody.assertIsEmpty(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_Correct500Message()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		ResponseBody.assertInternalServerErrorMessage(response);
	}
	
	@Test
	public void testPutResourceWithId_Successful_EmptyResponseBody()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = super.executePutRequest(resource, DEFAULT_SELF_URL);
		
		ResponseBody.assertIsEmpty(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_Correct404Message()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		ResponseBody.assertResourceNotFoundMessage(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_Correct404Message()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseBody.assertResourceNotFoundMessage(response);
	}
	
	@Test
	public void testPatchResource_NewResourceNotModified_EmptyResponseBody()
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
		
		ResponseBody.assertIsEmpty(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_Correct500Message()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		ResponseBody.assertInternalServerErrorMessage(response);
	}
}
			''');
	}
}