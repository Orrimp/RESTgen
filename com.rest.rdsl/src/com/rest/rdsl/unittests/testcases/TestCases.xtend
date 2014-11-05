package com.rest.rdsl.unittests.testcases

import com.xtext.rest.rdsl.management.Naming

class TestCases
{
	new()
	{}
	
	def generateGET(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»						  
									  .executeGetRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generateGET(TestCaseSpecification specification, String junitParams, String methodParams)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(«methodParams»)
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»						  
									  .executeGetRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generateGETConditional(TestCaseSpecification specification, String ifNoneMatchHeader)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
			
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
										  «IF specification.authorizationHeader.equals("")»
										  .setNoAuthorizationHeader()
									  	  «ELSE»
										  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
										  .addHeader(new BasicHeader("If-None-Match", «ifNoneMatchHeader»))
										  .executeGetRequest();
			} else
			{
				fail("StatusCode from first request was not 200 OK");
			}
		} catch(Exception e)
		{
			fail("Exception thrown from HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
		'''
	}
	
	def generateGETResourceQuery(TestCaseSpecification specification, String junitParams, int pages, int page)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(HashMap<String,Object> parameters)
	{
		@SuppressWarnings("unused")
		List<«Naming.JSON_RESOURCE»> localResources = initQueryTests(parameters, «pages», «page»);
			
		String url = getQueryUrl(parameters, «specification.targetUrl» + "/query/«page»");
		«IF page > 1»
		String previousUrl = getQueryUrl(parameters, «specification.targetUrl» + "/query/«page - 1»");
		«ELSEIF page < pages»
		String nextUrl = getQueryUrl(parameters, «specification.targetUrl» + "/query/«page + 1»");
		«ENDIF»
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(url)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»						  
									  .executeGetRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generateDELETENonConditional(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeDeleteRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
	
	def generateDELETE(TestCaseSpecification specification, String junitParams, String methodParams)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(«methodParams»)
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
	
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executeDeleteRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generateDELETE(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
	
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executeDeleteRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
	
	def generatePATCHWithoutParams(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				resource.put("iD", resources.get(0).get("iD"));
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCHNonConditional(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = resources.get(0);
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePatchRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCH(TestCaseSpecification specification, String generatorCall)
	{
		'''
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void «specification.methodName»(String jsonResource)
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
				resource.put("iD", resources.get(0).get("iD"));
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCH(TestCaseSpecification specification, String junitParams, String methodParams, String generatorCall)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(«methodParams»)
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
				resource.put("iD", resources.get(0).get("iD"));
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCH(TestCaseSpecification specification)
	{
		'''
	@Test
	@Parameters(method = "permutatedPatchResources")
	public void «specification.methodName»(String jsonResource)
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = new «Naming.JSON_RESOURCE»(jsonResource);
				resource.put("iD", resources.get(0).get("iD"));
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown from HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCHNotFound(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				resource.put("iD", 0);
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePATCHNoId(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		
		try
		{
			response = getHttpClient().setTargetUrl(DEFAULT_SELF_URL)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(MediaType.APPLICATION_JSON)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePatchRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePOST(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePostRequest();
									  
			if(StatusCode.isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePOST(TestCaseSpecification specification, String generatorCall)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePostRequest();
									  
			if(StatusCode.isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePOST(TestCaseSpecification specification, String junitParams, String methodParams, String generatorCall)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(«methodParams»)
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePostRequest();
									  
			if(StatusCode.isCreated(response))
			{
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePOSTAlreadyExists(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePostRequest();
									  
			if(StatusCode.isCreated(response))
			{	
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePUTNonConditional(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
		resource.put("iD", resources.get(0).get("iD"));
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePutRequest();
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
	
	def generatePUT(TestCaseSpecification specification, String generatorCall)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		try
		{
			
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
				resource.put("iD", resources.get(0).get("iD"));
		
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									 	  «IF specification.authorizationHeader.equals("")»
									 	  .setNoAuthorizationHeader()
									  	  «ELSE»
									 	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(«specification.mediaType»)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePutRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
	
	def generatePUT(TestCaseSpecification specification, String junitParams, String methodParams, String generatorCall)
	{
		'''
	@Test
	@Parameters(«junitParams»)
	public void «specification.methodName»(«methodParams»)
	{
		CloseableHttpResponse response = null;
		try
		{
			
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().«generatorCall»;
				resource.put("iD", resources.get(0).get("iD"));
		
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									 	  «IF specification.authorizationHeader.equals("")»
									 	  .setNoAuthorizationHeader()
									  	  «ELSE»
									 	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(«specification.mediaType»)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePutRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
	
	def generatePUT(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		CloseableHttpResponse response = null;
		try
		{
			
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .executeGetRequest();
		
			if(StatusCode.isOK(response))
			{
				Header[] headers = response.getHeaders("Etag");
				«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
				resource.put("iD", resources.get(0).get("iD"));
				
				response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  	  «IF specification.authorizationHeader.equals("")»
									  	  .setNoAuthorizationHeader()
									  	  «ELSE»
									  	  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  	  «ENDIF»
									  	  .setRequestEntity(resource.toString())
									  	  .setMediaType(«specification.mediaType»)
									  	  .addHeader(new BasicHeader("If-Match", «specification.ifMatchHeader»))
									  	  .executePutRequest();
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''
	}
	
	def generatePUTCreated(TestCaseSpecification specification)
	{
		'''
	@Test
	public void «specification.methodName»()
	{
		«Naming.JSON_RESOURCE» resource = getJsonGenerator().getValidJsonResource();
		resource.put("iD", 0);
		
		CloseableHttpResponse response = null;
		try
		{
			response = getHttpClient().setTargetUrl(«specification.targetUrl»)
									  «IF specification.authorizationHeader.equals("")»
									  .setNoAuthorizationHeader()
									  «ELSE»
									  .setAuthorizationHeader(Base64.encodeAsString("«specification.authorizationHeader»"))
									  «ENDIF»
									  .setRequestEntity(resource.toString())
									  .setMediaType(«specification.mediaType»)
									  .executePutRequest();
									  
			if(StatusCode.isCreated(response))
			{	
				resource = getJsonGenerator().combine(resource, response);
				resources.add(resource);
			}
		} catch(Exception e)
		{
			fail("Exception thrown in HttpClient");
		}
		
		«FOR command: specification.preAssert»
		«command»;
		«ENDFOR»
		
		«specification.assertion»;
	}
	 
		'''		
	}
}
