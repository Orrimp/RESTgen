package com.rest.rdsl.unittests.performance

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class ResourcePerformanceTests 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.PERFORMANCE_TESTS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.MediaType;

import org.apache.http.Header;
import org.apache.http.message.BasicHeader;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.glassfish.jersey.internal.util.Base64;

import org.junit.After;
import org.junit.Before;

import utility.HttpTestClient;
import utility.StatusCode;
import datagenerator.JsonResource;
import datagenerator.JsonResourceGenerator;

public abstract class «Naming.PERFORMANCE_TESTS»
{
	protected List<«Naming.JSON_RESOURCE»> resources;
	protected static String RESOURCE_BASE_URL;
	protected static String DEFAULT_SELF_URL;
	protected abstract «Naming.HTTP_CLIENT» getHttpClient();
	protected abstract «Naming.JSON_RESOURCE_GENERATOR» getJsonGenerator();
	
	@Before
	public void setUp()
	{
		resources = new ArrayList<«Naming.JSON_RESOURCE»>();
		
		for(int i = 0; i < 10; i++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
	
			CloseableHttpResponse response = executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
	}
	
	@After
	public void tearDown() throws Exception
	{
		for(«Naming.JSON_RESOURCE» resource : resources)
		{
			CloseableHttpResponse response = executeDeleteRequest((String)resource.get("selfURI"));
			
			if(!«Naming.STATUS_CODE».isNoContent(response) && !«Naming.STATUS_CODE».isNotFound(response))
			{
				throw new Exception("Database was not cleared successful!");
			}
		}
	}
	
	protected CloseableHttpResponse executeDeleteRequest(String targetURL)
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(targetURL)
							 		  .setCorrectAuthorizationHeader()
							 		  .executeDeleteRequest();
		} catch(Exception e)
		{
			fail("Exception thrown from HttpClient");
		}
		
		return response;
	}
	
	protected CloseableHttpResponse executePostRequest(JsonResource resource)
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setCorrectAuthorizationHeader()
									  .setRequestEntity(resource.toString())
									  .setMediaType(MediaType.APPLICATION_JSON)
									  .executePostRequest();
		} catch(Exception e)
		{
			fail("Exception thrown from HttpClient");
		}
		
		return response;
	}
	
	public long executeDeleteRequest()
	{
		«Naming.HTTP_CLIENT» client = null;
		long before, after, result;
		
		try
		{
			client = getHttpClient().setTargetUrl(RESOURCE_BASE_URL + "/0")
									.setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"));
			
			before = System.currentTimeMillis();
			client.executeDeleteRequest();
			after = System.currentTimeMillis();
			result = after - before;				
		} catch(Exception e)
		{
			result = -1L;
			fail("Exception thrown in HttpClient");
		}
		
		return result;
	}
	
	public long executeGetRequest(String targetUrl)
	{
		«Naming.HTTP_CLIENT» client = null;
		long before, after, result;
		
		try
		{
			client = getHttpClient().setTargetUrl(targetUrl)
									.setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"));
			
			before = System.currentTimeMillis();
			client.executeGetRequest();
			after = System.currentTimeMillis();
			result = after - before;
		} catch(Exception e)
		{
			result = -1L;
			fail("Exception thrown in HttpClient");
		}
		
		return result;
	}
	
	public long executePatchRequest()
	{
		«Naming.HTTP_CLIENT» client = null;
		long before, after, result;
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  .setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"))
									  .executeGetRequest();
		
			if(«Naming.STATUS_CODE».isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				resource.put("iD", resources.get(0).get("iD"));
				
				client = getHttpClient().setTargetUrl(RESOURCE_BASE_URL)
									  	.setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"))
									  	.setRequestEntity(resource.toString())
									  	.setMediaType(MediaType.APPLICATION_JSON)
									  	.addHeader(new BasicHeader("If-Match", «Constants.VALID_IF_MATCH_HEADER»));
									  	
				before = System.currentTimeMillis();
				client.executePatchRequest();
				after = System.currentTimeMillis();
				result = after - before;
			} else
			{
				result = -1L;
				fail("StatusCode was not 200 OK");
			}
		} catch(Exception e)
		{
			result = -1L;
			fail("Exception thrown in HttpClient");
		}
		
		return result;
	}
	
	public long executePostRequest()
	{
		«Naming.HTTP_CLIENT» client = null;
		long before, after, result;
		
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
		
		CloseableHttpResponse response = null;
		try
		{
			client = getHttpClient().setTargetUrl(RESOURCE_BASE_URL)
									.setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"))
									.setRequestEntity(resource.toString())
									.setMediaType(MediaType.APPLICATION_JSON);
			
			before = System.currentTimeMillis();
			response = client.executePostRequest();
			after = System.currentTimeMillis();
			result = after - before;
									  
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			result = -1L;
			fail("Exception thrown in HttpClient");
		}
		
		return result;
	}
	
	public long executePutRequest()
	{
		«Naming.HTTP_CLIENT» client = null;
		long before, after, result;
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  .setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"))
									  .executeGetRequest();
		
			if(«Naming.STATUS_CODE».isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				resource.put("iD", resources.get(0).get("iD"));
				
				client = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  	.setAuthorizationHeader(Base64.encodeAsString("«Constants.VALID_AUTHORIZATION»"))
									  	.setRequestEntity(resource.toString())
									  	.setMediaType(MediaType.APPLICATION_JSON)
									  	.addHeader(new BasicHeader("If-Match", «Constants.VALID_IF_MATCH_HEADER»));
				
				before = System.currentTimeMillis();
				response = client.executePutRequest();
				after = System.currentTimeMillis();
				result = after - before;
			} else
			{
				result = -1L;
				fail("StatusCode was not 200 OK");
			}
		} catch(Exception e)
		{
			result = -1L;
			fail("Exception thrown in HttpClient");
		}
		
		return result;
	}
}
			'''
		);
	}
}