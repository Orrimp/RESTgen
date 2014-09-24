package com.rest.rdsl.unittests.performance

import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import org.eclipse.xtext.generator.IFileSystemAccess

class PerformanceTestManager 
{
	val RESTConfiguration config;
	val IFileSystemAccess fsa;
	val RESTResourceCollection resourceCollection;
	
	new(IFileSystemAccess fsa, RESTConfiguration config, RESTResourceCollection resourceCollection)
	{
		this.config = config;
		this.fsa = fsa;
		this.resourceCollection = resourceCollection;
	}	
	
	def generate()
	{
		if(!config.testConfig.requestRatio.nullOrEmpty)
		{
			new ResourcePerformanceTests(fsa).generate(PackageManager.performancePackage);
			new PerformanceStatistics(fsa).generate(PackageManager.performancePackage);
			new TestReport(fsa).generate(PackageManager.performancePackage);
		
			for(r: resourceCollection.getResources())
			{
				new PerformanceTests(fsa, config, r).generate();
			}
		}
	}
}