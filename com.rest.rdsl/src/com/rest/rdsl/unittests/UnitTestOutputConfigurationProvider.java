package com.rest.rdsl.unittests;

import java.util.HashSet;
import java.util.Set;

import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.generator.IOutputConfigurationProvider;
import org.eclipse.xtext.generator.OutputConfiguration;

public class UnitTestOutputConfigurationProvider implements IOutputConfigurationProvider
{
	public static final String UNIT_TEST_OUTPUT = "unit-test";
	
	@Override
	public Set<OutputConfiguration> getOutputConfigurations()
	{
		OutputConfiguration defaultOutput = new OutputConfiguration(IFileSystemAccess.DEFAULT_OUTPUT);
	    defaultOutput.setDescription("Output Folder");
	    defaultOutput.setOutputDirectory("./src-gen");
	    defaultOutput.setOverrideExistingResources(true);
	    defaultOutput.setCreateOutputDirectory(true);
	    defaultOutput.setCleanUpDerivedResources(true);
	    defaultOutput.setSetDerivedProperty(true);

	    OutputConfiguration testOutput = new OutputConfiguration(UNIT_TEST_OUTPUT);
	    testOutput.setDescription("Unit Test Output Folder");
	    testOutput.setOutputDirectory("./src-gen-test");
	    testOutput.setOverrideExistingResources(true);
	    testOutput.setCreateOutputDirectory(true);
	    testOutput.setCleanUpDerivedResources(true);
	    testOutput.setSetDerivedProperty(true);
	    
	    HashSet<OutputConfiguration> result = new HashSet<OutputConfiguration>();
	    result.add(defaultOutput);
	    result.add(testOutput);
	    
	    return result; 
	}
}
