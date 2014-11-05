package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager

class TestSuperClassHeader 
{	
	new()
	{}
	
	def generateDefaultImports()
	{
		'''
«FOR imp : Naming.STATIC_JUNIT.baseImports»
import «imp»;
«ENDFOR»
import «PackageManager.dataGeneratorPackage».*;

import javax.ws.rs.core.MediaType;

import org.apache.http.Header;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.message.BasicHeader;
import org.glassfish.jersey.internal.util.Base64;

«FOR imp : Naming.JUNIT.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.UTILITY.baseImports»
import «imp»;
«ENDFOR»
		'''
	}
	
	def generateDefaultImportsWithJunitParams()
	{
		'''
«FOR imp : Naming.STATIC_JUNIT.baseImports»
import «imp»;
«ENDFOR»
import «PackageManager.dataGeneratorPackage».*;

import javax.ws.rs.core.MediaType;

import org.apache.http.Header;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.message.BasicHeader;
import org.glassfish.jersey.internal.util.Base64;

«FOR imp : Naming.JUNIT_PARAMS.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.JUNIT.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.UTILITY.baseImports»
import «imp»;
«ENDFOR»
		'''
	}
	
	def generateUtilImports()
	{
		'''
import java.net.URLEncoder;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
		'''
	}
	
	def generateAbstractMethods()
	{
		'''
	protected abstract «Naming.HTTP_CLIENT» getHttpClient();
	protected abstract «Naming.JSON_RESOURCE_GENERATOR» getJsonGenerator();
		'''
	}
	
	def generateConstants()
	{
		'''
	protected static String RESOURCE_BASE_URL;
	protected static String DEFAULT_SELF_URL;
		'''
	}
	
	def generateProtectedMembers()
	{
		'''
	protected CloseableHttpResponse response;
	protected List<«Naming.JSON_RESOURCE»> resources;
		'''
	}
	
	def generateBeforeMethod()
	{
		'''
	@Before
	@Override
	public void setUp()
	{
		super.setUp();
	}
	 
		'''
	}
	
	def generateBasicBeforeMethod()
	{
		'''
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
	 
		'''
	}
	
	def generateStopDatabaseBeforeMethod()
	{
		'''
	@Before
	@Override
	public void setUp()
	{
		super.setUp();
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(MANAGEMENT_API + "/stopDatabase")
								      .setCorrectAuthorizationHeader()
									  .executePostRequest();
			if(!«Naming.STATUS_CODE».isCreated(response))
			{
				fail("Database was not stopped!");
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
	}
	 
		'''
	}
	
	def generateAfterMethod()
	{
		'''
	@After
	@Override
	public void tearDown() throws Exception
	{
		super.tearDown();
	}
	 
		'''
	}
	
	def generateBasicAfterMethod()
	{
		'''
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
	 
		'''
	}
	
	def generateStartDatabaseAfterMethod()
	{
		'''
	@After
	@Override
	public void tearDown() throws Exception
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(MANAGEMENT_API + "/startDatabase")
								      .setCorrectAuthorizationHeader()
									  .executePostRequest();
			if(!«Naming.STATUS_CODE».isCreated(response))
			{
				fail("Database was not restarted!");
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		super.tearDown();
	}
	 
		'''
	}
	
	def generateExecuteDelete()
	{
		'''
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
	 
		'''
	}
	
	def generateExecutePost()
	{
		'''
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
	 
		'''
	}
}