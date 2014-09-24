package com.rest.rdsl.unittests

import com.rest.rdsl.unittests.datagenerator.FieldSpecifications
import com.rest.rdsl.unittests.datagenerator.JsonResource
import com.rest.rdsl.unittests.datagenerator.JsonResourceGenerator
import com.rest.rdsl.unittests.datagenerator.RandomJsonResourceGenerator
import com.rest.rdsl.unittests.datagenerator.TestDataGenerator
import com.rest.rdsl.unittests.datagenerator.datedata.DateGenerator
import com.rest.rdsl.unittests.datagenerator.doubledata.DoubleGenerator
import com.rest.rdsl.unittests.datagenerator.longdata.LongGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.RandomEmailGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.RandomStringGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.RandomUrlGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.StringContextGenerator
import com.rest.rdsl.unittests.datagenerator.stringdata.StringGenerator
import com.rest.rdsl.unittests.utility.HttpClient
import com.rest.rdsl.unittests.utility.HttpClientImpl
import com.rest.rdsl.unittests.utility.ResponseBody
import com.rest.rdsl.unittests.utility.ResponseHeader
import com.rest.rdsl.unittests.utility.ResponseLinks
import com.rest.rdsl.unittests.utility.StatusCode
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess

class StaticUnitTestGenerator 
{
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	
	new(IFileSystemAccess fsa, RESTConfiguration config)
	{
		this.fsa = fsa;
		this.config = config;
	}	
	
	def doGeneratePlatform()
	{
		generateUnitTestPlatform(PackageManager.unitTestPackage);
		generateDataGeneratorPlatform(PackageManager.dataGeneratorPackage);
		generateUtilityPlatform(PackageManager.utilityPackage);	
	}
		
	def generateUnitTestPlatform(String packageName) 
	{
		new ResourceTests(fsa).generate(packageName);
//		new ResourceStatusCodeTests(fsa).generate(packageName);
//		new ResourceHeaderTests(fsa).generate(packageName);
//		new ResourceBodyTests(fsa).generate(packageName);
		
		new ResourceGetIdTests(fsa).generate();
		new ResourceDeleteIdTests(fsa).generate();
		new ResourcePutIdTests(fsa).generate();
		new ResourcePostTests(fsa).generate();
		new ResourcePatchTests(fsa).generate();
		new ResourceGetQueryTests(fsa, config).generate();
		new ResourceGetIdAttributeTests(fsa).generate();
		new ResourceMethodNotAllowedTests(fsa).generate();
		new ResourceInternalServerErrorTests(fsa).generate();
	}
	
	def generateDataGeneratorPlatform(String packageName) 
	{
		new JsonResource(fsa).generate(packageName);
		new JsonResourceGenerator(fsa).generate(packageName);
		new RandomJsonResourceGenerator(fsa).generate(packageName);
		
		new FieldSpecifications(fsa).generate(packageName);
		new TestDataGenerator(fsa).generate(packageName);
		new DateGenerator(fsa).generate(PackageManager.dateDataPackage);
		new DoubleGenerator(fsa).generate(PackageManager.doubleDataPackage);
		new LongGenerator(fsa).generate(PackageManager.longDataPackage);
		new StringGenerator(fsa).generate(PackageManager.stringDataPackage);
		new StringContextGenerator(fsa).generate(PackageManager.stringDataPackage);
		new RandomStringGenerator(fsa).generate(PackageManager.stringDataPackage);
		new RandomEmailGenerator(fsa).generate(PackageManager.stringDataPackage);
		new RandomUrlGenerator(fsa).generate(PackageManager.stringDataPackage);
	}
	
	def generateUtilityPlatform(String packageName) 
	{
		new HttpClient(fsa).generate(packageName);
		new HttpClientImpl(fsa).generate(packageName);
		new ResponseBody(fsa).generate(packageName);
		new ResponseHeader(fsa).generate(packageName);
		new StatusCode(fsa).generate(packageName);
		new ResponseLinks(fsa).generate(packageName);
	}
}