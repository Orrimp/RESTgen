package com.rest.rdsl.unittests

import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.RESTConfiguration

class QueryMethods 
{
	val RESTConfiguration config;
	
	new(RESTConfiguration config)
	{
		this.config = config;
	}
	
	def generateInitQueryTests()
	{
		'''
	private List<«Naming.JSON_RESOURCE»> initQueryTests(HashMap<String,Object> parameters, int pages, int page)
	{
		List<«Naming.JSON_RESOURCE»> localResources = new ArrayList<«Naming.JSON_RESOURCE»>();
		
		for(int i = 0, j = 0; i < (pages*«config.paging.elementsCount»); i++, j++)
		{
			«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
			
			if(j < (pages*«config.paging.elementsCount» - 5))
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
				if(resourceBelongsToRequestedPage(j, pages, page))
				{
					localResources.add(resource);
				}	
				resources.add(resource);
			}
		}
		
		return localResources;
	}
		'''
	}
	
	def generateBelongsTo()
	{
		'''
	private boolean resourceBelongsToRequestedPage(int j, int pages, int page)
	{
		boolean result = false;
		if(page == pages)
		{
			result = (j > ((page - 1)*«config.paging.elementsCount» - 1)) && (j < (page*«config.paging.elementsCount» - 5));
		} else if(page < pages)
		{
			result = (j > ((page - 1)*«config.paging.elementsCount» - 1)) && (j < page*«config.paging.elementsCount»);
		} 
		return result;
	}
		'''
	}
	
	def generateQueryUrl()
	{
		'''
	private String getQueryUrl(HashMap<String,Object> parameters, String targetUrl)
	{
		StringBuffer url = new StringBuffer(targetUrl);
		
		if(!parameters.isEmpty())
		{
			url.append("?");
		
			Iterator<Entry<String,Object>> entrySetIterator = parameters.entrySet().iterator();
			while(entrySetIterator.hasNext())
			{
				Entry<String,Object> entry = entrySetIterator.next();
				url.append(entry.getKey());
				url.append("=");
				try
				{
					url.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8"));
				} catch(Exception e)
				{
					fail("Encoding is not supported.");
				}
				
				if(entrySetIterator.hasNext())
				{
					url.append("&");
				}
			}
		}
		
		return url.toString();
	}
		'''
	}
}