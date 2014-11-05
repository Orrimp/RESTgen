package com.rest.rdsl.unittests.utility

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

class ResponseBody 
{
	private IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa)
	{
		this.fsa = fsa;
	}
	
	def generate(String packageName)
	{
		fsa.generateFile(Naming.RESPONSE_BODY.generationLocation + Constants.JAVA, "unit-test",
			'''
package «packageName»;

import static org.junit.Assert.assertTrue;
import datagenerator.JsonResource;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import com.owlike.genson.Genson;

public class ResponseBody
{
	private final static String INTERNAL_SERVER_ERROR_MESSAGE = "Status 500 - Internal Server Error";
	private final static String RESOURCE_NOT_FOUND_MESSAGE = "Status 404 - Not Found";
	private final static String METHOD_NOT_ALLOWED_MESSAGE = "Status 405 - Method Not Allowed";
	private final static String BAD_REQUEST_MESSAGE = "Status 400 - Bad Request";
	private final static String UNAUTHORIZED_MESSAGE = "Status 401 - Unauthorized";
	private final static String PRECONDITION_FAILED_MESSAGE = "Status 412 - Precondition Failed";
	private final static String PRECONDITION_REQUIRED_MESSAGE = "Status 428";
	private final static String UNPROCESSABLE_ENTITY_MESSAGE = "Status 422";
	private final static String UNSUPPORTED_MEDIA_TYPE_MESSAGE = "Status 415 - Unsupported Media Type";
	
	private static final String ISO8601_DATETIME_FORMAT = "yyyy-MM-dd' 'HH:mm:ss";
	private static final DateFormat format = new SimpleDateFormat(ISO8601_DATETIME_FORMAT);
	
	public static void assertIsEmpty(HttpResponse response)
	{
		boolean result = false;

		String body = "there was no body";
		try
		{
			HttpEntity entity = response.getEntity();
			if(entity != null)
			{
				body = EntityUtils.toString(entity);
				result = body.equals("");
			} else
			{
				result = true;
			}
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected body to be empty, but was: \"" + body + "\"", result); 
	}
	
	public static void assertResourceNotFoundMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(RESOURCE_NOT_FOUND_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected resource not found message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertBadRequestMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(BAD_REQUEST_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected bad request message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertUnauthorizedMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(UNAUTHORIZED_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected unauthorized message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertPreconditionFailedMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(PRECONDITION_FAILED_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected precondition failed message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertPreconditionRequiredMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(PRECONDITION_REQUIRED_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected precondition required message, but was: \"" + message + "\"", result); 
	}

	public static void assertNotFoundMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(RESOURCE_NOT_FOUND_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected not found message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertMethodNotAllowedMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(METHOD_NOT_ALLOWED_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected method not allowed message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertUnprocessableEntityMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(UNPROCESSABLE_ENTITY_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected unprocessable entity message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertUnsupportedMediaTypeMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(UNSUPPORTED_MEDIA_TYPE_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected unsupported media type message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertInternalServerErrorMessage(HttpResponse response)
	{
		boolean result = false;
		String message = "there was no message";
		try
		{
			message = EntityUtils.toString(response.getEntity());
			result = message.contains(INTERNAL_SERVER_ERROR_MESSAGE);
		} catch(Exception e)
		{
			result = false;
		}
		assertTrue("expected internal server error message, but was: \"" + message + "\"", result); 
	}
	
	public static void assertResource(HttpResponse response, JsonResource jsonResource)
	{
		boolean result = false;
		JsonResource responseBody = null;
		
		try
		{
			responseBody = new JsonResource(EntityUtils.toString(response.getEntity()));
			result = jsonResource.equals(responseBody);
		} catch(Exception e)
		{
			result = false;
		}
		assertTrue("expected resource = \"" + jsonResource + "\",\n but was: \"" + responseBody + "\"", result); 
	}
	
	public static void assertResourceAttribute(HttpResponse response, Object attribute)
	{
		boolean result = false;
		String responseBody = null;
		
		try
		{
			responseBody = EntityUtils.toString(response.getEntity());
			Object bodyObject = convertTo(responseBody, attribute.getClass());
			result = attribute.equals(bodyObject);
		} catch(Exception e)
		{
			result = false;
		}
		
		assertTrue("expected attribute = \"" + attribute + "\", but was: \"" + responseBody + "\"", result); 
	}
	
	private static Object convertTo(String responseBody, Class<?> type) throws Exception
	{
		Object result;
		
		switch(type.getSimpleName())
		{
		case "String":
			result = responseBody;
			break;
		case "Long":
			result = Long.parseLong(responseBody);
			break;
		case "Double":
			result = Double.parseDouble(responseBody);
			break;
		case "Boolean":
			result = Boolean.parseBoolean(responseBody);
			break;
		case "Date":
			result = format.parse(responseBody);
			break;
		default:
			result = null;	
		}
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public static void assertQueryPage(HttpResponse response, List<JsonResource> resources)
	{
		boolean result = false;
		
		String responseBody = null;
		
		try
		{
			responseBody = EntityUtils.toString(response.getEntity());
			
			Genson genson = new Genson();
			ArrayList<HashMap<String,Object>> bodyList = genson.deserialize(responseBody, ArrayList.class);
			
			for(HashMap<String,Object> resource : bodyList)
			{
				ArrayList<HashMap<String,String>> links = new ArrayList<>();
				
				for(Object linkMap : (Object[])resource.get("links"))
				{
					links.add((HashMap<String,String>)linkMap);
				}
				
				resource.remove("links");
				resource.put("links", links);
			}
			
			result = resources.equals(bodyList);
		} catch (Exception e)
		{ 
			result = false;
		}
		
		assertTrue("expected page = \"" + resources + "\",\n but was: \"" + responseBody + "\"", result);
	}
}
			''')
	}	
}