package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.Attribute
import com.xtext.rest.rdsl.restDsl.HTTPMETHOD
import com.xtext.rest.rdsl.restDsl.JavaReference
import com.xtext.rest.rdsl.restDsl.ListReference
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import java.util.HashSet
import java.util.Set
import org.eclipse.xtext.generator.IFileSystemAccess

class DefaultHeaderTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val RESTResource resource;
	val PermutationGenerator permGen;
	
	extension ExtensionMethods e = new ExtensionMethods();

	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		this.resource = resource;
		this.permGen = new PermutationGenerator(resource);
	}
	
	def generate()
	{
		val Set<String> attributeImports = new HashSet<String>()
		for(Attribute attribute: resource.attributes)
		{
			if(attribute.value instanceof JavaReference)
			{
				attributeImports.add(attribute.value.nameOfType);
			}
		}
	
		fsa.generateFile(PackageManager.unitTestPackage + "/" + resource.name + "HeaderTests" + Constants.JAVA, 
			"unit-test",		
		'''
package «PackageManager.unitTestPackage»;

«FOR imp: Naming.STATIC_JUNIT.baseImports»
import «imp»;
«ENDFOR»
import «PackageManager.dataGeneratorPackage».*;
import «PackageManager.dateDataPackage».*;
import «PackageManager.doubleDataPackage».*;
import «PackageManager.longDataPackage».*;
import «PackageManager.stringDataPackage».*;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

«FOR imp : Naming.JUNIT_PARAMS.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.APACHE_HTTP.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.JUNIT.baseImports»
import «imp»;
«ENDFOR»

import «PackageManager.utilityPackage».*;

import «PackageManager.objectPackage».«resource.name»;

@RunWith(JUnitParamsRunner.class)
public class «resource.name»HeaderTests extends «Naming.RESOURCE_HEADER_TESTS»
{
	private «Naming.JSON_RESOURCE_GENERATOR» jsonResourceGenerator = null;
	private Map<String,«Naming.TEST_DATA_GENERATOR»> generators = new HashMap<String,«Naming.TEST_DATA_GENERATOR»>();
	{
		generators.put("Double", new «resource.name + Naming.DOUBLE_GENERATOR»());
		generators.put("Long", new «resource.name + Naming.LONG_GENERATOR»());
		generators.put("String", new «resource.name + Naming.STRING_GENERATOR»());
		generators.put("Date", new «resource.name + Naming.DATE_GENERATOR»());
	}
	
	protected «Naming.HTTP_CLIENT» getHttpClient()
	{
		«Naming.HTTP_CLIENT» client = new «Naming.HTTP_CLIENT_IMPL»(RESOURCE_BASE_URL);
		return client;
	}
	
	@Override
	protected «Naming.JSON_RESOURCE_GENERATOR» getJsonGenerator()
	{
		if(jsonResourceGenerator == null)
		{
			jsonResourceGenerator = new «Naming.RANDOM_JSON_RESOURCE_GENERATOR»(«resource.name».class);
			jsonResourceGenerator.setTestDataGenerators(generators);
		}
		
		return jsonResourceGenerator;
	}
	
	@Before
	@Override
	public void setUp()
	{
		RESOURCE_BASE_URL = "«config.basePath»/«resource.name.toFirstLower»";
		super.setUp();
		DEFAULT_SELF_URL = (String)resources.get(0).get("selfURI");
	}
	
	@After
	@Override
	public void tearDown() throws Exception
	{
		super.tearDown();
	}
	
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void testPatchResource_Successful_LinkCorrect(String jsonResource)
	{
		«Naming.JSON_RESOURCE» resource = new «Naming.JSON_RESOURCE»(jsonResource);
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		String link = RESOURCE_BASE_URL + "/" + resources.get(0).get("iD");
		
		«Naming.RESPONSE_HEADER».assertResourceLink(response, link);
	}
	
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void testPatchResource_Successful_EtagCorrect(String jsonResource)
	{
		«Naming.JSON_RESOURCE» resource = new «Naming.JSON_RESOURCE»(jsonResource);
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePatchRequest(resource);

		ResponseHeader.assertEtag(response, (Long)resources.get(0).get("iD"));
	}
	
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void testPatchResource_Successful_DateCorrect(String jsonResource)
	{
		«Naming.JSON_RESOURCE» resource = new «Naming.JSON_RESOURCE»(jsonResource);
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void testPatchResource_Successful_ServerCorrect(String jsonResource)
	{
		«Naming.JSON_RESOURCE» resource = new «Naming.JSON_RESOURCE»(jsonResource);
		resource.put("iD", resources.get(0).get("iD"));

		CloseableHttpResponse response = super.executePatchRequest(resource);
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@SuppressWarnings("unused")
	private Object[] permutatedPatchResources()
	{
		«permGen.getPermutatedPatchResources()»
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_Succesful_ContentTypeCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL + "/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertContentType(response, "application/json; version=1");
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_Succesful_ContentLengthCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL + "/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_Succesful_LinkCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL + "/" + attribute);
		
		String link = RESOURCE_BASE_URL + "/" + resources.get(0).get("iD");
		
		«Naming.RESPONSE_HEADER».assertResourceLink(response, link);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_Succesful_DateCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL + "/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_Succesful_ServerCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(DEFAULT_SELF_URL + "/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_RessourceNotFound_ContentTypeCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_RessourceNotFound_ContentLanguageCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertContentLanguage(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_RessourceNotFound_ContentLengthCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_RessourceNotFound_DateCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_RessourceNotFound_ServerCorrect(String attribute)
	{
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/0/" + attribute);
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_ContentTypeCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertContentType(response, "text/html;charset=utf-8");
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_ContentLanguageCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertContentLanguage(response);
	}

	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_ContentLengthCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_ConnectionCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertConnection(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_DateCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters({«getNonCollectionAttributes()»})
	public void testGetAttribute_InternalServerError_ServerCorrect(String attribute)
	{
		//TODO getRequest an management API zum Abschalten der DB
		CloseableHttpResponse response = super.executeGetRequest(RESOURCE_BASE_URL + "/-10/" + attribute);

		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_ContentTypeCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentType(response, "application/json; version=1");
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_ContentLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_LinksCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		HashMap<String,String> pageLinks = new HashMap<>();
		pageLinks.put("next", "<>");
		pageLinks.put("current", "<" + url.toString() + ">");
		pageLinks.put("previous", "<>");
		
		«Naming.RESPONSE_HEADER».assertPageLinks(response, pageLinks);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_DateCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_ServerCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromOneAvailablePagesSuccessful_xCollectionLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 10; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 5)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertXCollectionLength(response, 5);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_ContentTypeCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentType(response, "application/json; version=1");
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_ContentLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_LinksCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		HashMap<String,String> pageLinks = new HashMap<>();
		pageLinks.put("next", "<" + url.toString().replace("/query/1", "/query/2") + ">");
		pageLinks.put("current", "<" + url.toString() + ">");
		pageLinks.put("previous", "<>");
		
		«Naming.RESPONSE_HEADER».assertPageLinks(response, pageLinks);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_DateCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_ServerCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageOneFromTwoAvailablePagesSuccessful_xCollectionLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/1?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertXCollectionLength(response, 15);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_ContentTypeCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentType(response, "application/json; version=1");
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_ContentLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertContentLength(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_LinksCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		HashMap<String,String> pageLinks = new HashMap<>();
		pageLinks.put("next", "<>");
		pageLinks.put("current", "<" + url.toString() + ">");
		pageLinks.put("previous", "<" + url.toString().replace("/query/2", "/query/1") + ">");
		
		«Naming.RESPONSE_HEADER».assertPageLinks(response, pageLinks);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_DateCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertDate(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_ServerCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertServer(response);
	}
	
	@Test
	@Parameters(method = "getQueryParameters")
	public void testGetUsersQuery_getPageTwoFromTwoAvailablePagesSuccessful_xCollectionLengthCorrect(HashMap<String,Object> parameters)
	{
		for(int i = 0, j = 0; i < 20; i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getResource();
			
			if(j < 15)
			{
				for(Entry<String,Object> entry : parameters.entrySet())
				{
					resource.put(entry.getKey(), entry.getValue());
				}
			}
			
			CloseableHttpResponse response = super.executePostRequest(resource);
			
			if(«Naming.STATUS_CODE».isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		}
		
		StringBuffer url = new StringBuffer(RESOURCE_BASE_URL);
		url.append("/query/2?");
		
		Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
		while(entrySetIterator.hasNext())
		{
			Entry<String,Object> entry = entrySetIterator.next();
			url.append(entry.getKey());
			url.append("=");
			url.append(entry.getValue());
			
			if(entrySetIterator.hasNext())
			{
				url.append("&");
			}
		}
		
		CloseableHttpResponse response = super.executeGetRequest(url.toString());
		
		«Naming.RESPONSE_HEADER».assertXCollectionLength(response, 15);
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_ContentTypeCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_ContentLanguageCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_ContentLengthCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_ConnectionCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_DateCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@Test
	@Parameters(method="getQueryParameters")
	public void testGetUsersQuery_InternalServerError_ServerCorrect(HashMap<String,Object> parameters)
	{
		//TODO management API -> datenbank deaktivieren -> gleiche methode wie succesful -> statuscode muss 500 sein
		fail("not implemented yet");
	}
	
	@SuppressWarnings({ "unused", "serial" })
	private Object[] getQueryParameters()
	{
		«permGen.getPermutatedQueryParameters()»
	}
}
		''');
	}
	
	def getNonCollectionAttributes()
 	{
 		var result = "";
 		
 		val attributes = resource.getAttributes();
 		for(Attribute a: attributes)
 		{
 			if(!(a.value instanceof ListReference) && !(a.method.equals(HTTPMETHOD.NONE)))
 			{
 				result = result + "\"" + a.name + "\",";
 			}
 		}
 		
 		if(!result.equals(""))
 		{
 			result = result.substring(0, result.length() - 1);
 		}
 		
 		return result;
 	}
}