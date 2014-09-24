package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource

class TestClassHeader
{
	val RESTConfiguration config;
	val RESTResource resource;
	
	new(RESTConfiguration config, RESTResource resource)
	{
		this.config = config;
		this.resource = resource;
	}
	
	def generateDefaultImports()
	{
		'''
«FOR imp: Naming.STATIC_JUNIT.baseImports»
import «imp»;
«ENDFOR»
import «PackageManager.dataGeneratorPackage».*;
import «PackageManager.dateDataPackage».*;
import «PackageManager.doubleDataPackage».*;
import «PackageManager.longDataPackage».*;
import «PackageManager.stringDataPackage».*;

import javax.ws.rs.core.MediaType;

import org.apache.http.Header;
import org.apache.http.message.BasicHeader;
import org.glassfish.jersey.internal.util.Base64;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

«FOR imp : Naming.APACHE_HTTP.baseImports»
import «imp»;
«ENDFOR»

«FOR imp : Naming.JUNIT.baseImports»
import «imp»;
«ENDFOR»

import «PackageManager.utilityPackage».*;

import «PackageManager.objectPackage».«resource.name»;
		'''
	}
	
	def generateDefaultImportsWithJUnitParams()
	{
		'''
«FOR imp: Naming.STATIC_JUNIT.baseImports»
import «imp»;
«ENDFOR»
import «PackageManager.dataGeneratorPackage».*;
import «PackageManager.dateDataPackage».*;
import «PackageManager.doubleDataPackage».*;
import «PackageManager.longDataPackage».*;
import «PackageManager.stringDataPackage».*;

import javax.ws.rs.core.MediaType;

import org.apache.http.Header;
import org.apache.http.message.BasicHeader;
import org.glassfish.jersey.internal.util.Base64;

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
		'''
	}
	
	def generatePrivateMembers()
	{
		'''
	private «Naming.JSON_RESOURCE_GENERATOR» jsonResourceGenerator = null;
	private Map<String,«Naming.TEST_DATA_GENERATOR»> generators = new HashMap<String,«Naming.TEST_DATA_GENERATOR»>();
	{
		generators.put("Double", new «Naming.DOUBLE_GENERATOR + resource.name»());
		generators.put("Float", new «Naming.DOUBLE_GENERATOR + resource.name»());
		generators.put("Long", new «Naming.LONG_GENERATOR + resource.name»());
		generators.put("Int", new «Naming.LONG_GENERATOR + resource.name»());
		generators.put("String", new «Naming.STRING_GENERATOR + resource.name»());
		generators.put("Date", new «Naming.DATE_GENERATOR + resource.name»());
	}
	 
		'''
	}
	
	def generateClientMethod()
	{
		'''
	@Override
	protected «Naming.HTTP_CLIENT» getHttpClient()
	{
		«Naming.HTTP_CLIENT» client = new «Naming.HTTP_CLIENT_IMPL»(RESOURCE_BASE_URL);
		return client;
	}
	 
		'''
	}
	
	def generateGeneratorMethod()
	{
		'''
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
	 
		'''
	}
	
	def generateBeforeMethod()
	{
		'''
	@Before
	@Override
	public void setUp()
	{
		RESOURCE_BASE_URL = "«config.basePath»/«resource.name.toFirstLower»";
		super.setUp();
		DEFAULT_SELF_URL = (String)resources.get(0).get("selfURI");
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
}
