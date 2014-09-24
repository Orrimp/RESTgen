package com.rest.rdsl.unittests.performance

import com.rest.rdsl.unittests.AttributeExtractor
import com.rest.rdsl.unittests.MethodParams
import com.rest.rdsl.unittests.PermutationGenerator
import com.rest.rdsl.unittests.QueryMethods
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import com.xtext.rest.rdsl.restDsl.RESTResource
import com.xtext.rest.rdsl.restDsl.TestConfiguration
import com.xtext.rest.rdsl.restDsl.TestRatio
import java.util.HashMap
import java.util.Map
import org.eclipse.xtext.generator.IFileSystemAccess

class PerformanceTests 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val TestConfiguration testConfig;
	val RESTResource resource;
	val PermutationGenerator permGen;
	val AttributeExtractor attributeExtractor;
	val QueryMethods queryMethods;
	
	val String testClassSuffix = "PerformanceTests";
	
	var currentRatio = 0.0;
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResource resource)
	{
		this.fsa = fsa;
		this.config = config;
		testConfig = config.testConfig;
		this.resource = resource;
		permGen = new PermutationGenerator(resource);
		attributeExtractor = new AttributeExtractor(resource);
		queryMethods = new QueryMethods(config);
	}
	
	def generate()
	{
		fsa.generateFile(PackageManager.performancePackage + "/" + resource.name + testClassSuffix + Constants.JAVA, "unit-test",
			'''
package «PackageManager.performancePackage»;

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

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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

public class «resource.name»«testClassSuffix» extends «Naming.PERFORMANCE_TESTS»
{
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
	
	private Map<String, «Naming.PERFORMANCE_STATISTICS»> statistics = new HashMap<String, «Naming.PERFORMANCE_STATISTICS»>();
	{
		statistics.put("All", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("DELETE", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("GET", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("GET_ATTRIBUTE", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("GET_QUERY", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("PATCH", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("POST", new «Naming.PERFORMANCE_STATISTICS»());
		statistics.put("PUT", new «Naming.PERFORMANCE_STATISTICS»());
	}
	
	@Override
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
	public void test()
	{
		long testTime = «testConfig.testTime» * 60000L;
		long responseTime = 0L;
		
		while(testTime > 0)
		{
			double choice = Math.random();
			
			«FOR ratio: testConfig.requestRatio BEFORE 'if' SEPARATOR 'else if'»
			  (choice > «currentRatio» && choice <= «currentRatio = currentRatio + Double.parseDouble(ratio.percentage)»)
			{
				«generateIfElse(ratio)»
			}
			«ENDFOR»
			
			statistics.get("All").setMin(responseTime)
								 .setMax(responseTime)
								 .addLastedTime(responseTime)
								 .incrementCount();
			
			testTime -= responseTime;
		}
		
		System.out.println(new «Naming.TEST_REPORT»(statistics));
	}
	
	private String getRandomUrl(String type)
	{
		String result = null;
		switch(type)
		{
			case "GET":
			result = getRandomResourceUrl();
			break;
			case "GET_ATTRIBUTE":
			result = getRandomAttributeUrl();
			break;
			case "GET_QUERY":
			result = getRandomQueryUrl();
			break;
		}
		return result;
	}
	
	private String getRandomResourceUrl()
	{
		int index = (int)(Math.random()*resources.size());
		Object id = resources.get(index).get("iD");
		
		return RESOURCE_BASE_URL + "/" + id.toString();
	}
	
	private String getRandomAttributeUrl()
	{
		Object[] attributes = «Constants.PRIMITIVE_ATTRIBUTE_PARAMS»();
		
		int index = (int)(Math.random()*attributes.length);
		String attribute = (String)((Object[])attributes[index])[0];
		
		index = (int)(Math.random()*resources.size());
		Object id = resources.get(index).get("iD");
		
		return RESOURCE_BASE_URL + "/" + id.toString() + "/" + attribute;
	}
	
	«MethodParams.generatePrimitivesMethod(attributeExtractor)»
	
	@SuppressWarnings("unchecked")
	private String getRandomQueryUrl()
	{
		Object[] queries = «Constants.QUERY_PARAMS»();
		
		int index = (int)(Math.random()*queries.length);
		HashMap<String,Object> query = (HashMap<String,Object>)((Object[])queries[index])[0];
		
		initQueryTests(query, 1, 1);
		
		return getQueryUrl(query, RESOURCE_BASE_URL + "/query/1");
	}
	
	«MethodParams.generatePermutatedQueryParameters(permGen)»
	«queryMethods.generateInitQueryTests()»
	«queryMethods.generateBelongsTo()»
	«queryMethods.generateQueryUrl»
}
			'''
		);
	}
	
	private def generateIfElse(TestRatio ratio)
	{
		var Map<String,String> nameMapping = new HashMap<String,String>();
		nameMapping.put("DELETE", "Delete");
		nameMapping.put("GET", "Get");
		nameMapping.put("GET_ATTRIBUTE", "Get");
		nameMapping.put("GET_QUERY", "Get");
		nameMapping.put("PATCH", "Patch");
		nameMapping.put("POST", "Post");
		nameMapping.put("PUT", "Put");
		
		'''
		responseTime = super.execute«nameMapping.get(ratio.type.literal)»Request(«IF ratio.type.literal.startsWith("G")»getRandomUrl("«ratio.type.literal»")«ENDIF»);
				
		statistics.get("«ratio.type»").setMin(responseTime)
									  .setMax(responseTime)
								      .addLastedTime(responseTime)
									  .incrementCount();
		'''
	}
}