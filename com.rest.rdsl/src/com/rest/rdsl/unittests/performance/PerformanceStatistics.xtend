package com.rest.rdsl.unittests.performance

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class PerformanceStatistics 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.PERFORMANCE_STATISTICS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

public class «Naming.PERFORMANCE_STATISTICS»
{
	private long min = Long.MAX_VALUE;
	private long max;
	private long lastedTime;
	private long count;
	
	public long getMin()
	{
		return min;
	}

	public «Naming.PERFORMANCE_STATISTICS» setMin(long min)
	{
		if(this.min > min)
		{
			this.min = min;
		}
		
		return this;
	}
	
	public long getMax()
	{
		return max;
	}
	
	public «Naming.PERFORMANCE_STATISTICS» setMax(long max)
	{
		if(this.max < max)
		{
			this.max = max;
		}
		
		return this;
	}
	
	public long getLastedTime()
	{
		return lastedTime;
	}
	
	public «Naming.PERFORMANCE_STATISTICS» addLastedTime(long lastedTime)
	{
		this.lastedTime += lastedTime;
		
		return this;
	}
	
	public long getCount()
	{
		return count;
	}
	
	public «Naming.PERFORMANCE_STATISTICS» incrementCount()
	{
		count++;
		
		return this;
	}

	public long getAverage()
	{
		long result = 0L;
		
		if(count != 0L)
		{
			result = lastedTime/count;
		}
		
		return result;
	}
	
	@Override
	public String toString()
	{
		StringBuffer result = new StringBuffer();
		
		result.append("Min Request Time: ")
			  .append(min)
			  .append("ms\nMax Request Time: ")
			  .append(max)
			  .append("ms\nAverage Request Time: ")
			  .append(getAverage())
			  .append("ms\n")
			  .append(count)
			  .append(" requests in ")
			  .append(lastedTime/1000)
			  .append(" seconds");
		
		return result.toString();
	}
}
			'''
		);
	}
}