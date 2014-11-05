package com.rest.rdsl.unittests.utility

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class HttpClientImpl 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.HTTP_CLIENT_IMPL.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.HttpHeaders;

import org.apache.http.Header;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;

public class «Naming.HTTP_CLIENT_IMPL» implements «Naming.HTTP_CLIENT»
{
	CloseableHttpClient httpclient = HttpClients.createDefault();
	HttpRequestBase httpRequest;
	String targetUrl;
	String requestEntity;
	String mediaType;
	Header authorizationHeader;
	List<Header> headers;
	
	public «Naming.HTTP_CLIENT_IMPL»()
	{
		headers = new ArrayList<Header>();
	}
	
	public «Naming.HTTP_CLIENT_IMPL»(String targetUrl)
	{
		headers = new ArrayList<Header>();
		this.targetUrl = targetUrl;
	}
	
	public «Naming.HTTP_CLIENT_IMPL»(String targetUrl, String mediaType)
	{
		headers = new ArrayList<Header>();
		this.targetUrl = targetUrl;
		this.mediaType = mediaType;
	}
	
	public «Naming.HTTP_CLIENT_IMPL»(String targetUrl, String mediaType, Header authorizationHeader)
	{
		headers = new ArrayList<Header>();
		this.targetUrl = targetUrl;
		this.mediaType = mediaType;
		headers.add(authorizationHeader);
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setTargetUrl(String targetUrl)
	{
		this.targetUrl = targetUrl;
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» addUrlPath(String path)
	{
		this.targetUrl = this.targetUrl + path;
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setRequestEntity(String requestEntity)
	{
		this.requestEntity = requestEntity;
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setMediaType(String mediaType)
	{
		this.mediaType = mediaType;
		return this;
	}
	
	
	public «Naming.HTTP_CLIENT_IMPL» setAuthorizationHeader(String encodedAuthorizationData)
	{
		headers.add(new BasicHeader(HttpHeaders.AUTHORIZATION, encodedAuthorizationData));
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setCorrectAuthorizationHeader()
	{
		headers.add(new BasicHeader(HttpHeaders.AUTHORIZATION, "«Constants.VALID_AUTHORIZATION»"));
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setNoAuthorizationHeader()
	{
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» setFalseAuthorizationHeader()
	{
		headers.add(new BasicHeader(HttpHeaders.AUTHORIZATION, "guahigu:agahgoh"));
		return this;
	}
	
	public «Naming.HTTP_CLIENT_IMPL» addHeader(Header header)
	{
		headers.add(header);
		return this;
	}
	
	public CloseableHttpResponse executeGetRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException
	{
		httpRequest = new HttpGet(this.targetUrl);
		for(Header h : headers)
		{
			httpRequest.addHeader(h);
		}
		
		return executeRequest();
	}
	
	
	public CloseableHttpResponse executePostRequest() throws UnsupportedEncodingException,
		ClientProtocolException, IOException
	{	
		httpRequest = new HttpPost(this.targetUrl);
		for(Header h : headers)
		{
			httpRequest.addHeader(h);
		}
		((HttpPost)httpRequest).setEntity(getRequestBody());
		
		return executeRequest();
	}
	
	
	public CloseableHttpResponse executePutRequest() throws UnsupportedEncodingException,
		ClientProtocolException, IOException
	{
		httpRequest = new HttpPut(this.targetUrl);
		for(Header h : headers)
		{
			httpRequest.addHeader(h);
		}
		((HttpPut)httpRequest).setEntity(getRequestBody());
		
		return executeRequest();
	}
	
	
	public CloseableHttpResponse executeDeleteRequest() throws UnsupportedEncodingException,
		ClientProtocolException, IOException
	{
		httpRequest = new HttpDelete(this.targetUrl);
		for(Header h : headers)
		{
			httpRequest.addHeader(h);
		}
		
		return executeRequest();
	}
	
	public CloseableHttpResponse executePatchRequest() throws UnsupportedEncodingException,
		ClientProtocolException, IOException
	{
		httpRequest = new HttpPatch(this.targetUrl);
		for(Header h : headers)
		{
			httpRequest.addHeader(h);
		}
		((HttpPatch)httpRequest).setEntity(getRequestBody());
		
		return executeRequest();
	}
	
	private StringEntity getRequestBody() throws UnsupportedEncodingException
	{
		StringEntity requestBody;
		if(this.requestEntity != null)
		{
			requestBody = new StringEntity(this.requestEntity);
		} else
		{
			requestBody = new StringEntity("{}");
		}
		requestBody.setContentType(this.mediaType);
		
		return requestBody;
	}
	
	private CloseableHttpResponse executeRequest() throws ClientProtocolException, IOException
	{
		CloseableHttpResponse response = httpclient.execute(httpRequest);
		response.close();
		return response;	
	}
}
			''')
	}
}