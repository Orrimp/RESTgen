package com.rest.rdsl.unittests.utility

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class HttpClient 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.HTTP_CLIENT.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.http.Header;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;

public interface «Naming.HTTP_CLIENT»
{
	public «Naming.HTTP_CLIENT» setTargetUrl(String targetUrl);
	public «Naming.HTTP_CLIENT» addUrlPath(String path);
	public «Naming.HTTP_CLIENT» setRequestEntity(String requestEntity);
	public «Naming.HTTP_CLIENT» setMediaType(String mediatype);
	public «Naming.HTTP_CLIENT» setAuthorizationHeader(String encodedAuthorizationData);
	public «Naming.HTTP_CLIENT» setCorrectAuthorizationHeader();
	public «Naming.HTTP_CLIENT» setNoAuthorizationHeader();
	public «Naming.HTTP_CLIENT» setFalseAuthorizationHeader();
	public «Naming.HTTP_CLIENT» addHeader(Header header);
	
	public CloseableHttpResponse executeGetRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException;
	public CloseableHttpResponse executePostRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException;
	public CloseableHttpResponse executePutRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException;
	public CloseableHttpResponse executeDeleteRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException;
	public CloseableHttpResponse executePatchRequest() throws UnsupportedEncodingException, 
		ClientProtocolException, IOException;
}
			''');
	}
}