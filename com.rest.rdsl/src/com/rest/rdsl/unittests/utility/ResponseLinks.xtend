package com.rest.rdsl.unittests.utility

import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import org.eclipse.xtext.generator.IFileSystemAccess

class ResponseLinks 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESPONSE_LINKS.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import datagenerator.*;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import com.owlike.genson.Genson;

public class ResponseLinks
{
	public static void assertLinkHeader(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Link");
		boolean linksReachable = true;
		int index = 0;
		String targetUrl = "";
		
		while((index < headers.length) && linksReachable)
		{
			targetUrl = extractUrl(headers[index]);
			if(!targetUrl.equals(""))
			{
				HttpResponse getResponse = executeGet(targetUrl);
			
				if(!StatusCode.isOK(getResponse))
				{
					linksReachable = false;
				}
			}
			
			if(targetUrl.equals("") && headers.length == 1)
			{
				linksReachable = false;
			}
			index++;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	public static void assertLocationHeader(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Location");
		boolean linksReachable = true;
		int index = 0;
		String targetUrl = "";
		
		while((index < headers.length) && linksReachable)
		{
			targetUrl = headers[index].getValue();
			HttpResponse getResponse = executeGet(targetUrl);
			
			if(!StatusCode.isOK(getResponse))
			{
				linksReachable = false;
			}
			index++;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	public static void assertBodyLinks(HttpResponse response)
	{
		boolean linksReachable = true;
		«Naming.JSON_RESOURCE» responseBody = null;
		
		try
		{
			responseBody = new «Naming.JSON_RESOURCE»(EntityUtils.toString(response.getEntity()));
		} catch(Exception e)
		{
			fail("could not construct JsonResource from response body");
		}
		
		@SuppressWarnings("unchecked")
		List<Object> links = (ArrayList<Object>)responseBody.get("links");
		int index = 0;
		String targetUrl = "";
		
		while((index < links.size()) && linksReachable)
		{
			targetUrl = ((HashMap<String,String>)links.get(0)).get("uRI");
			
			HttpResponse getResponse = executeGet(targetUrl);
			
			if(!StatusCode.isOK(getResponse))
			{
				linksReachable = false;
			}
			index++;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	public static void assertBodySelfUri(HttpResponse response)
	{
		boolean linksReachable = true;
		«Naming.JSON_RESOURCE» responseBody = null;
		
		try
		{
			responseBody = new «Naming.JSON_RESOURCE»(EntityUtils.toString(response.getEntity()));
		} catch(Exception e)
		{
			fail("could not construct JsonResource from response body");
		}
		
		String targetUrl = (String)responseBody.get("selfURI");
		
		HttpResponse getResponse = executeGet(targetUrl);
		
		if(!StatusCode.isOK(getResponse))
		{
			linksReachable = false;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	public static void assertCreatedBodyLink(HttpResponse response)
	{
		boolean linkReachable = true;
		String targetUrl = "";
		
		try
		{
			targetUrl = EntityUtils.toString(response.getEntity());
		} catch(Exception e)
		{
			fail("EntityUtils couldn't get response body");
		}
		
		HttpResponse getResponse = executeGet(targetUrl);
		
		if(!StatusCode.isOK(getResponse))
		{
			linkReachable = false;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linkReachable);
	}
	
	public static void assertQueryBodySelfUris(HttpResponse response)
	{
		boolean linksReachable = true;
		String targetUrl = "";
		
		String responseBody = "";
		ArrayList<HashMap<String,Object>> bodyList = null;
		
		try
		{
			responseBody = EntityUtils.toString(response.getEntity());
			
			Genson genson = new Genson();
			bodyList = genson.deserialize(responseBody, ArrayList.class);
		} catch(Exception e)
		{
			fail("could not get Page from response body");
		}
		
		int index = 0;
		while((index < bodyList.size()) && linksReachable)
		{
			targetUrl = (String)bodyList.get(index).get("selfURI");
			
			HttpResponse getResponse = executeGet(targetUrl);
		
			if(!StatusCode.isOK(getResponse))
			{
				linksReachable = false;
			}
			index++;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	public static void assertQueryBodyLinks(HttpResponse response)
	{
		boolean linksReachable = true;
		String targetUrl = "";
		
		String responseBody = "";
		ArrayList<HashMap<String,Object>> bodyList = null;
		
		try
		{
			responseBody = EntityUtils.toString(response.getEntity());
			
			Genson genson = new Genson();
			bodyList = genson.deserialize(responseBody, ArrayList.class);
		} catch(Exception e)
		{
			fail("could not get Page from response body");
		}
		
		int index = 0;
		while((index < bodyList.size()) && linksReachable)
		{
			Object linksObject = bodyList.get(index).get("links");
			Object[] links = (Object[])linksObject;
			
			for(Object linkMap : links)
			{
				targetUrl = ((HashMap<String,String>)linkMap).get("uRI");
			
				HttpResponse getResponse = executeGet(targetUrl);
		
				if(!StatusCode.isOK(getResponse))
				{
					linksReachable = false;
					break;
				}
			}
			
			index++;
		}
		
		assertTrue("The url " + targetUrl + " was not 200 OK", linksReachable);
	}
	
	private static String extractUrl(Header header)
	{
		HeaderElement[] elements = header.getElements();
		return elements[0].getName().substring(1, elements[0].getName().length() - 1);
	}
	
	private static HttpResponse executeGet(String targetUrl)
	{
		HttpResponse response = null;
		try
		{
			response = new «Naming.HTTP_CLIENT_IMPL»().setTargetUrl(targetUrl)
								 		   .setCorrectAuthorizationHeader()
								   	   	   .executeGetRequest();
		} catch(Exception e)
		{
			fail("Exception in HttpClient");
		}
		
		return response;
	}
}
			'''
		);
	}
}