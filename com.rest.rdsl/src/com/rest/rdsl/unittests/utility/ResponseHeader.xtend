package com.rest.rdsl.unittests.utility

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class ResponseHeader 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESPONSE_HEADER.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import static org.junit.Assert.assertTrue;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.ws.rs.core.EntityTag;

import org.apache.http.Header;
import org.apache.http.HeaderElement;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

public class ResponseHeader
{
	public static void assertAllow(HttpResponse response, String allowHeader)
	{
		Header[] headers = response.getHeaders("Allow");
		boolean onlyOneHeader = (headers.length) == 1;
		
		String allowed = "";
		if(onlyOneHeader)
		{
			HeaderElement[] elements = headers[0].getElements();
			
			if(elements.length >= 1)
			{
				allowed += elements[0].getName();
			
				for(int i = 1; i < elements.length; i++)
				{
					allowed += ",";
					allowed += elements[i].getName();
				}
			}
		}
		boolean correctAllowHeader = allowed.equals(allowHeader);
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected allow header = \"" + allowHeader +
				"\", but was: \"" + allowed + "\"", (onlyOneHeader && correctAllowHeader));
	}
	
	public static void assertContentType(HttpResponse response, String contentType)
	{
		Header[] headers = response.getHeaders("Content-Type");
		boolean onlyOneHeader = (headers.length) == 1;
		
		boolean correctContentType = false;
		String givenContentType = "there was no content type";
		if(onlyOneHeader)
		{
			givenContentType = headers[0].getValue();
			correctContentType = givenContentType.equals(contentType);
		}
	
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected contentType \"" + contentType
				+ "\", but was: \"" + givenContentType + "\"", (onlyOneHeader && correctContentType));
	}
	
	public static void assertContentLanguage(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Content-Language");
		boolean onlyOneHeader = (headers.length) == 1;
		
		boolean correctContentLanguage = false;
		String givenContentLanguage = "there was no content language";
		if(onlyOneHeader)
		{
			givenContentLanguage = headers[0].getValue();
			correctContentLanguage = givenContentLanguage.equals("en");
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected content language \"en\"" +
				", but was: \""	+ givenContentLanguage + "\"", (onlyOneHeader && correctContentLanguage));
	}
	
	public static void assertContentLength(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Content-Length");
		boolean onlyOneHeader = (headers.length == 1);
		
		boolean correctLength = false;
		int bodyLength = 0;
		String responseBody = "";
		if(onlyOneHeader)
		{
			try
			{
				responseBody = EntityUtils.toString(response.getEntity());
				bodyLength = Integer.parseInt(headers[0].getValue());
				correctLength = responseBody.length() == bodyLength;
			} catch(Exception e)
			{
				correctLength = false;
			}
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected content length = " +
				bodyLength + ", but was: " + responseBody.length(), (onlyOneHeader && correctLength));
	}
	
	public static void assertDate(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Date");
		boolean onlyOneHeader = (headers.length) == 1;

		boolean correctDate = false;
		Date now = new Date();
		Date responseDate = null; 
		if(onlyOneHeader)
		{
			SimpleDateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz");
			try
			{
				responseDate = sdf.parse(headers[0].getValue());
				correctDate = responseDate.before(now);
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected date shorty before " +
				now + ", but was: " + responseDate, (onlyOneHeader && correctDate));
	}
	
	public static void assertEtag(HttpResponse response, Long id)
	{
		Header[] headers = response.getHeaders("Etag");
		boolean onlyOneHeader = (headers.length) == 1;
		
		String eTagValue = id + "Users" + new Date();
		EntityTag eTag = new EntityTag(eTagValue);
		eTagValue = "" + eTag.hashCode();
		
		boolean correctEtag = false;
		String givenEtag = "there was no etag";
		if(onlyOneHeader)
		{
			givenEtag = headers[0].getValue();
			correctEtag = givenEtag.equals("\"" + eTagValue + "\"");
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected etag = \"" +
				eTagValue + "\", but was: " + givenEtag, (onlyOneHeader && correctEtag));
	}
	
	public static void assertServer(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Server");
		boolean onlyOneHeader = (headers.length) == 1;
		
		boolean correctServer = false;
		String givenServer = "there was no server";
		if(onlyOneHeader)
		{
			givenServer = headers[0].getValue();
			correctServer = givenServer.equals("Apache-Coyote/1.1");
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected server = \"Apache-Coyote/1.1\""
				+ ", but was: \"" + givenServer + "\"", (onlyOneHeader && correctServer));
	}
	
	public static void assertConnection(HttpResponse response)
	{
		Header[] headers = response.getHeaders("Connection");
		boolean onlyOneHeader = (headers.length) == 1;
		
		boolean correctConnection = false;
		String givenConnection = "there was no connection";
		if(onlyOneHeader)
		{
			givenConnection = headers[0].getValue();
			correctConnection = givenConnection.equals("close");
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected connection = \"close\"" +
				", but was: \"" + givenConnection + "\"", (onlyOneHeader && correctConnection));
	}
	
	public static void assertResourceLink(HttpResponse response, String selfURI)
	{
		Header[] headers = response.getHeaders("Link");
		boolean onlyOneHeader = (headers.length == 1);
		
		boolean correctLink = false, correctLinkRel = false;
		String givenLink = "there was no link";
		String givenLinkRel = "there was no link rel";
		if(onlyOneHeader)
		{
			HeaderElement[] elements = headers[0].getElements();
			if(elements.length == 1)
			{
				givenLink = elements[0].getName();
				correctLink = givenLink.equals("<" + selfURI + ">");
				givenLinkRel = elements[0].getParameterByName("rel").getValue();
				correctLinkRel = givenLinkRel.equals("self");
			}
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected link = \""
				+ selfURI + "\", but was: \"" + givenLink + "\";\n also expected link rel = self, but was: " + givenLinkRel,
				(onlyOneHeader && correctLink && correctLinkRel));
	}
	
	public static void assertPageLinks(HttpResponse response, HashMap<String,String> pageLinks)
	{
		Header[] headers = response.getHeaders("Link");
		boolean threeHeaders = (headers.length == 3);
		
		boolean correctPrevious = false, correctPreviousRel = false, correctNext = false, 
				correctNextRel = false, correctLink = false, correctLinkRel = false;
		
		String givenPrevious = "there was no previous link";
		String givenPreviousRel = "there was no previous rel";
		String givenCurrent = "there was no current link";
		String givenCurrentRel = "there was no current rel";
		String givenNext = "there was no next link";
		String givenNextRel = "there was no next rel";
		if(threeHeaders)
		{
			HeaderElement[] elements = headers[0].getElements();
			if(elements.length == 1)
			{
				givenPrevious = elements[0].getName();
				correctPrevious = givenPrevious.equals(pageLinks.get("previous"));
				givenPreviousRel = elements[0].getParameterByName("rel").getValue();
				correctPreviousRel = givenPreviousRel.equals("previous");
			}
			
			elements = headers[1].getElements();
			if(elements.length == 1)
			{
				givenCurrent = elements[0].getName();
				correctLink = givenCurrent.equals(pageLinks.get("current"));
				givenCurrentRel = elements[0].getParameterByName("rel").getValue();
				correctLinkRel = givenCurrentRel.equals("current");
			}	
			
			elements = headers[2].getElements();
			if(elements.length == 1)
			{
				givenNext = elements[0].getName();
				correctNext = givenNext.equals(pageLinks.get("next"));
				givenNextRel = elements[0].getParameterByName("rel").getValue();
				correctNextRel = givenNextRel.equals("next");
			}
		}
		
		assertTrue("expected three headers, but was: " + headers.length + ";\n also expected previous = \""
				+ pageLinks.get("previous") + "\", but was: \"" + givenPrevious + "\";\n also expected previous rel = previous"
				+ ", but was: " + givenPreviousRel + ";\n also expected current = \"" + pageLinks.get("current") + 
				"\", but was: \"" + givenCurrent + "\";\n also expected current rel = current, but was: " 
				+ givenCurrentRel + ";\n also expected next = \"" + pageLinks.get("next") + "\", but was: \"" 
				+ givenNext + "\";\n also expected next rel = next, but was: " + givenNextRel,
				(threeHeaders && correctLink && correctLinkRel && correctNext 
						&& correctNextRel && correctPrevious && correctPreviousRel));
	}
	
	public static void assertLocation(HttpResponse response, String selfURI)
	{
		Header[] headers = response.getHeaders("Location");
		boolean onlyOneHeader = (headers.length == 1);
		
		boolean correctLocation = false;
		String givenLocation = "there was no location";
		if(onlyOneHeader)
		{
			givenLocation = headers[0].getValue();
			correctLocation = givenLocation.equals(selfURI);
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected location = \""
				+ selfURI + "\", but was: \"" + givenLocation + "\"", (onlyOneHeader && correctLocation));
	}
	
	public static void assertXCollectionLength(HttpResponse response, int length)
	{
		Header[] headers = response.getHeaders("x-Collection-Length");
		boolean onlyOneHeader = (headers.length == 1);
		
		boolean correctCollectionLength = false;
		String givenLength = "there was no collection length";
		if(onlyOneHeader)
		{
			givenLength = headers[0].getValue();
			correctCollectionLength = (Integer.parseInt(givenLength) == length);
		}
		
		assertTrue("expected only one header, but was: " + headers.length + ";\n also expected collection length = " + length
				+ ", but was: " + givenLength, (onlyOneHeader && correctCollectionLength));
	}
}
			''')
	}
}