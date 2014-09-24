package com.rest.rdsl.unittests.performance

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class TestReport 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.TEST_REPORT.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import java.util.Map;
import java.util.Map.Entry;

public class «Naming.TEST_REPORT»
{
	private Map<String, «Naming.PERFORMANCE_STATISTICS»> statistics;
	
	public TestReport(Map<String, «Naming.PERFORMANCE_STATISTICS»> statistics)
	{
		this.statistics = statistics;
	}
	
	@Override
	public String toString()
	{
		StringBuffer result = new StringBuffer();
		
		for(Entry<String, «Naming.PERFORMANCE_STATISTICS»> statistic : statistics.entrySet())
		{
			result.append("Statistic for ")
				  .append(statistic.getKey())
				  .append(":\n")
				  .append(statistic.getValue().toString())
				  .append("\n\n");
		}
		
		return result.toString();
	}
}
			'''
		);
	}
}