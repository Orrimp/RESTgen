package com.rest.rdsl.unittests.utility

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class StatusCode 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.STATUS_CODE.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;
import static org.junit.Assert.assertTrue;
import javax.ws.rs.core.Response.Status;

import org.apache.http.HttpResponse;

public class StatusCode
{
	public static boolean isOK(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.OK.getStatusCode();
	}

	public static boolean isCreated(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.CREATED.getStatusCode();
	}
	
	public static boolean isNoContent(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.NO_CONTENT.getStatusCode();
	}
	
	public static boolean isNotModified(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.NOT_MODIFIED.getStatusCode();
	}
	
	public static boolean isForbidden(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.FORBIDDEN.getStatusCode();
	}
	
	public static boolean isNotFound(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.NOT_FOUND.getStatusCode();
	}
	
	public static boolean isInternalServerError(HttpResponse response)
	{
		return response.getStatusLine().getStatusCode() == Status.INTERNAL_SERVER_ERROR.getStatusCode();
	}
	
	public static void assertOK(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 200 OK, but was " + statusCode, 
				statusCode == Status.OK.getStatusCode());
	}
	
	public static void assertCreated(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 201 Created, but was " + statusCode, 
				statusCode == Status.CREATED.getStatusCode());
	}
	
	public static void assertNoContent(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 204 No Content, but was " + statusCode, 
				statusCode == Status.NO_CONTENT.getStatusCode());
	}
	
	public static void assertNotModified(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 304 OK, but was " + statusCode, 
				statusCode == Status.NOT_MODIFIED.getStatusCode());
	}
	
	public static void assertForbidden(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 403 Forbidden, but was " + statusCode, 
				statusCode == Status.FORBIDDEN.getStatusCode());
	}
	
	public static void assertNotFound(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 404 Not Found, but was " + statusCode, 
				statusCode == Status.NOT_FOUND.getStatusCode());
	}
	
	public static void assertInternalServerError(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 500 Internal Server Error, but was " + statusCode, 
				statusCode == Status.INTERNAL_SERVER_ERROR.getStatusCode());
	}
	
	public static void assertBadRequest(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 400 Bad Request, but was " + statusCode, 
				statusCode == Status.BAD_REQUEST.getStatusCode());
	}
	
	public static void assertUnauthorized(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 401 Unauthorized, but was " + statusCode, 
				statusCode == Status.UNAUTHORIZED.getStatusCode());
	}
	
	public static void assertPreconditionFailed(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 412 Precondition Failed, but was " + statusCode, 
				statusCode == Status.PRECONDITION_FAILED.getStatusCode());
	}
	
	public static void assertPreconditionRequired(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 428 Precondition Required, but was " + statusCode,
				statusCode == 428);
	}
	
	public static void assertMethodNotAllowed(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 405 Method Not Allowed, but was " + statusCode, 
				statusCode == Status.METHOD_NOT_ALLOWED.getStatusCode());
	}
	
	public static void assertUnprocessableEntity(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 422 Unprocessable Entity, but was " + statusCode, 
				statusCode == 422);
	}
	
	public static void assertUnsupportedMediaType(HttpResponse response)
	{
		int statusCode = response.getStatusLine().getStatusCode();
		assertTrue("status code should be 415 Unsupported Media Type, but was " + statusCode, 
				statusCode == Status.UNSUPPORTED_MEDIA_TYPE.getStatusCode());
	}
}
			''')
	}
}