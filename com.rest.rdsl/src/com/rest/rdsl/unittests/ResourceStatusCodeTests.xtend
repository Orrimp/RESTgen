package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Constants

class ResourceStatusCodeTests 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESOURCE_STATUS_CODE_TESTS.generationLocation + Constants.JAVA, "unit-test", 
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
import utility.StatusCode;
//TODO conditional PUT testcases;
public abstract class ResourceStatusCodeTests extends ResourceTests
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
	public void testGetId_Successful_Status200() throws Exception
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL);

		StatusCode.assertOK(response);
	}
	
	@Test
	public void testGetId_UnmodifiedResource_Status304()
	{
		CloseableHttpResponse response = super.executeGetRequestTwiceForNotModified(DEFAULT_SELF_URL);

		StatusCode.assertNotModified(response);
	}
	
	@Test
	public void testGetId_ResourceNotFound_Status404()
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0");
		
		StatusCode.assertNotFound(response);
	}
	
	@Test
	public void testGetId_InternalServerError_Status500()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10");
		
		StatusCode.assertInternalServerError(response);
	}
	
	@Test
	public void testDeleteId_Successful_Status204()
	{
		CloseableHttpResponse response = super.executeDeleteRequest(DEFAULT_SELF_URL);
		
		StatusCode.assertNoContent(response);
	}
	
	@Test
	public void testDeleteId_InternalServerError_Status500()
	{
		//TODO getRequest an management-endpunkt zum abschalten der DB
		CloseableHttpResponse response = super.executeDeleteRequest(RESOURCE_BASE_URL + "/-10");
		
		StatusCode.assertInternalServerError(response);
	}
	
	@Test
	public void testPostResource_Successful_Status201()
	{
		JsonResource resource = getJsonGenerator().getResource();
		
		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		StatusCode.assertCreated(response);
	}
	
	@Test
	public void testPostResource_ResourceAlreadyExists_Status500()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePostRequest(resource);
		
		if(StatusCode.isCreated(response))
		{
			resource = getJsonGenerator().combine(resource, response);
			resources.add(resource);
		}
		
		StatusCode.assertInternalServerError(response);
	}
	
	@Test
	public void testPutResourceWithId_Successful_Status200()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = super.executePutRequest(resource, DEFAULT_SELF_URL);
		
		StatusCode.assertOK(response);
	}
	
	@Test
	public void testPutResourceWithId_ResourceNotFound_Status404()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = super.executePutRequest(resource, RESOURCE_BASE_URL + "/0");
		
		StatusCode.assertNotFound(response);
	}
	
	@Test
	public void testPatchResource_ResourceNotFound_Status500()
	{
		JsonResource resource = getJsonGenerator().getResource();
		resource.put("iD", 0L);
		
		CloseableHttpResponse response = super.executePatchRequest(resource);

		StatusCode.assertInternalServerError(response);
	}
	
	@Test
	public void testPatchResource_NewResourceNotModified_Status304()
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
		
		StatusCode.assertNotModified(response);
	}
	
	@Test
	public void testPatchResource_RequestEntityHasNoId_Status500()
	{
		JsonResource resource = new JsonResource(resources.get(0));
		resource.remove("iD");
		
		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		StatusCode.assertInternalServerError(response);
	}
}
			''');
	}
}
