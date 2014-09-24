package com.xtext.rest.rdsl.management;

import java.util.ArrayList;
import java.util.List;

import com.xtext.rest.rdsl.management.ClassPackageInfo.CLASSTYPE;

public final class Naming {
	
	private static List<String> JAXBAnnoImports = new ArrayList<String>();
    private static List<String> jerseyImports = new ArrayList<String>();
    private static List<String> springImports = new ArrayList<String>();
    private static List<String> sqliteImports = new ArrayList<String>();
    private static List<String> annoImports = new ArrayList<String>();
    
    private static List<String> junitImports = new ArrayList<String>();
    private static List<String> staticJunitImports = new ArrayList<String>();
    private static List<String> junitparamsImports = new ArrayList<String>();
    private static List<String> apacheHttpImports = new ArrayList<String>();
    private static List<String> utilityImports = new ArrayList<String>();
    
	static{
		JAXBAnnoImports.add("javax.xml.bind.annotation.XmlAccessType");
		JAXBAnnoImports.add("javax.xml.bind.annotation.XmlAccessorType");
	    JAXBAnnoImports.add("javax.xml.bind.annotation.XmlElement");
	    JAXBAnnoImports.add("javax.xml.bind.annotation.XmlRootElement");
	    
		jerseyImports.add("javax.ws.rs.GET");
		jerseyImports.add("javax.ws.rs.POST");
		jerseyImports.add("javax.ws.rs.PUT");
		jerseyImports.add("javax.ws.rs.DELETE");
		jerseyImports.add("javax.ws.rs.Path");
		jerseyImports.add("javax.ws.rs.Produces");
		jerseyImports.add("javax.ws.rs.Consumes");
		jerseyImports.add("javax.ws.rs.core.MediaType");
		jerseyImports.add("javax.ws.rs.core.CacheControl");
		jerseyImports.add("javax.ws.rs.core.Response");
		jerseyImports.add("javax.ws.rs.PathParam");
		
		sqliteImports.add("java.sql.Connection");
		sqliteImports.add("java.sql.DriverManager");
		sqliteImports.add("java.sql.ResultSet");
		sqliteImports.add("java.sql.SQLException");
		sqliteImports.add("java.sql.Statement"); 
		
		annoImports.add("java.lang.annotation.ElementType");
		annoImports.add("java.lang.annotation.Retention");
		annoImports.add("java.lang.annotation.RetentionPolicy");
		annoImports.add("java.lang.annotation.Target");
		annoImports.add("javax.ws.rs.NameBinding");
		
		junitImports.add("org.junit.After");
		junitImports.add("org.junit.Before");
		junitImports.add("org.junit.Test");
		junitImports.add("org.junit.runner.RunWith");
		
		staticJunitImports.add("static org.junit.Assert.*");
		
		junitparamsImports.add("junitparams.JUnitParamsRunner");
		junitparamsImports.add("junitparams.Parameters");
		
		apacheHttpImports.add("org.apache.http.client.methods.CloseableHttpResponse");
		
		utilityImports.add("utility.HttpTestClient");
		utilityImports.add("utility.StatusCode");
		utilityImports.add("utility.ResponseHeader");
		utilityImports.add("utility.ResponseBody");
		utilityImports.add("utility.ResponseLinks");
	};	


	public static final ClassPackageInfo ANNO_USER_AUTH 			= new ClassPackageInfo("UserAuthorization", PackageManager.getAuthPackage(), CLASSTYPE.INTERFACE, annoImports);
	public static final ClassPackageInfo ANNO_PATCH					= new ClassPackageInfo("PATCH", PackageManager.getFrameworkPackage(), CLASSTYPE.INTERFACE, annoImports);
	public static final ClassPackageInfo INTERFACE_ID  				= new ClassPackageInfo("IIDGenerator", PackageManager.getInterfacePackage(),CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo INTERFACE_AUTH_DECODER 	= new ClassPackageInfo("IAuthHeaderDecoder", PackageManager.getInterfacePackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo ABSTRACT_CLASS_DAO 		= new ClassPackageInfo("DataAccessObjectFactory", PackageManager.getDatabasePackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo CLASS_DAO 					= new ClassPackageInfo("DataAccessObject" , PackageManager.getDatabasePackage());
	public static final ClassPackageInfo CLASS_DB_QUERY				= new ClassPackageInfo("DBQuery", PackageManager.getDatabasePackage());
	public static final ClassPackageInfo CLASS_ID 					= new ClassPackageInfo("IDGenerator", PackageManager.getFrameworkPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo CLASS_ABSTRACT_RESOURCE	= new ClassPackageInfo("AbstractResource", PackageManager.getResourcePackage());
	public static final ClassPackageInfo CLASS_SQLITEDAO			= new ClassPackageInfo("SQLiteDataAccessObjectFactory", PackageManager.getDatabasePackage());
	public static final ClassPackageInfo CLASS_SQLITE				= new ClassPackageInfo("SQLitePersistence", PackageManager.getDatabasePackage(), CLASSTYPE.CLASS, sqliteImports);
	public static final ClassPackageInfo CLASS_JSONCOLLECTION		= new ClassPackageInfo("JSONCollection", PackageManager.getResourcePackage());
	public static final ClassPackageInfo CLASS_JSONCOL_QUERY 		= new ClassPackageInfo("Query", PackageManager.getResourcePackage());
	public static final ClassPackageInfo CLASS_USER_AUTH_DATA		= new ClassPackageInfo("UserAuthorizationData", PackageManager.getAuthPackage());
	public static final ClassPackageInfo CLASS_USER_AUTH_FILTER		= new ClassPackageInfo("UserAuthorizationFilter", PackageManager.getAuthPackage());
	public static final ClassPackageInfo CLASS_LINK					= new ClassPackageInfo("SimpleLink", PackageManager.getObjectPackage());
	public static final ClassPackageInfo FILE_POM					= new ClassPackageInfo("pom.xml.backup", PackageManager.getWebPackage());
	public static final ClassPackageInfo FILE_WEB					= new ClassPackageInfo("web.xml.backup", PackageManager.getWebPackage());
	public static final ClassPackageInfo JAXB_RESOLVER				= new ClassPackageInfo("JAXBContextProvider", PackageManager.getFrameworkPackage(), CLASSTYPE.CLASS, JAXBAnnoImports);

	public static final ClassPackageInfo GENSON_RESOLVER 			= new ClassPackageInfo("GensonContextProvider", PackageManager.getFrameworkPackage());
	public static final ClassPackageInfo CLASS_OBJPARENT			= new ClassPackageInfo("ObjectParent", PackageManager.getObjectPackage());
	public static final ClassPackageInfo FRAMEWORK_JERSEY 			= new ClassPackageInfo("Jersey", "", CLASSTYPE.OTHER, jerseyImports);
	public static final ClassPackageInfo FRAMEWORK_SPRING			= new ClassPackageInfo("SPRING", "", CLASSTYPE.OTHER, springImports);
	
	public static final String COLLECTION_JSON_MIME 	= "application/vnd.collection+json";
	public static final String METHOD_NAME_ID_GET		= "getID";
	public static final String METHOD_NAME_ID_SET		= "setID";

	public static final ClassPackageInfo RESOURCE_TESTS = 
			new ClassPackageInfo("ResourceTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_STATUS_CODE_TESTS = 
			new ClassPackageInfo("ResourceStatusCodeTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_HEADER_TESTS = 
			new ClassPackageInfo("ResourceHeaderTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_BODY_TESTS = 
			new ClassPackageInfo("ResourceBodyTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_METHOD_NOT_ALLOWED_TESTS = 
			new ClassPackageInfo("ResourceMethodNotAllowedTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_INTERNAL_SERVER_ERROR_TESTS =
			new ClassPackageInfo("ResourceInternalServerErrorTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_GET_ID_TESTS = 
			new ClassPackageInfo("ResourceGetIdTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_DELETE_ID_TESTS = 
			new ClassPackageInfo("ResourceDeleteIdTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_PUT_ID_TESTS = 
			new ClassPackageInfo("ResourcePutIdTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_POST_TESTS = 
			new ClassPackageInfo("ResourcePostTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_PATCH_TESTS = 
			new ClassPackageInfo("ResourcePatchTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_GET_ID_ATTRIBUTE_TESTS = 
			new ClassPackageInfo("ResourceGetIdAttributeTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo RESOURCE_GET_QUERY_TESTS = 
			new ClassPackageInfo("ResourceGetQueryTests", PackageManager.getUnitTestPackage(), CLASSTYPE.ABSTRACT_CLASS);
	
	public static final ClassPackageInfo JSON_RESOURCE = 
			new ClassPackageInfo("JsonResource", PackageManager.getDataGeneratorPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo JSON_RESOURCE_GENERATOR = 
			new ClassPackageInfo("JsonResourceGenerator", PackageManager.getDataGeneratorPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo RANDOM_JSON_RESOURCE_GENERATOR = 
			new ClassPackageInfo("RandomJsonResourceGenerator", PackageManager.getDataGeneratorPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo TEST_DATA_GENERATOR = 
			new ClassPackageInfo("TestDataGenerator", PackageManager.getDataGeneratorPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo DATE_GENERATOR	= 
			new ClassPackageInfo("DateGenerator", PackageManager.getDateDataPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo DOUBLE_GENERATOR = 
			new ClassPackageInfo("DoubleGenerator", PackageManager.getDoubleDataPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo LONG_GENERATOR	= 
			new ClassPackageInfo("LongGenerator", PackageManager.getLongDataPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo STRING_GENERATOR = 
			new ClassPackageInfo("StringGenerator", PackageManager.getStringDataPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo STRING_CONTEXT_GENERATOR =
			new ClassPackageInfo("StringContextGenerator", PackageManager.getStringDataPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo RANDOM_EMAIL_GENERATOR =
			new ClassPackageInfo("RandomEmailGenerator", PackageManager.getStringDataPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo RANDOM_URL_GENERATOR =
			new ClassPackageInfo("RandomUrlGenerator", PackageManager.getStringDataPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo RANDOM_STRING_GENERATOR =
			new ClassPackageInfo("RandomStringGenerator", PackageManager.getStringDataPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo FIELD_SPECIFICATIONS = 
			new ClassPackageInfo("FieldSpecifications", PackageManager.getDataGeneratorPackage(), CLASSTYPE.CLASS);
	
	public static final ClassPackageInfo TEST_REPORT = 
			new ClassPackageInfo("TestReport", PackageManager.getPerformancePackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo PERFORMANCE_STATISTICS = 
			new ClassPackageInfo("PerformanceStatistics", PackageManager.getPerformancePackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo PERFORMANCE_TESTS = 
			new ClassPackageInfo("PerformanceTests", PackageManager.getPerformancePackage(), CLASSTYPE.ABSTRACT_CLASS);
	
	public static final ClassPackageInfo HTTP_CLIENT = 
			new ClassPackageInfo("HttpTestClient", PackageManager.getUtilityPackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo HTTP_CLIENT_IMPL = 
			new ClassPackageInfo("HttpTestClientImpl", PackageManager.getUtilityPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo STATUS_CODE = 
			new ClassPackageInfo("StatusCode", PackageManager.getUtilityPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo RESPONSE_BODY = 
			new ClassPackageInfo("ResponseBody", PackageManager.getUtilityPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo RESPONSE_HEADER = 
			new ClassPackageInfo("ResponseHeader", PackageManager.getUtilityPackage(), CLASSTYPE.CLASS);
	public static final ClassPackageInfo RESPONSE_LINKS =
			new ClassPackageInfo("ResponseLinks", PackageManager.getUtilityPackage(), CLASSTYPE.CLASS);

	public static final ClassPackageInfo JUNIT = 
			new ClassPackageInfo("JUNIT", "", CLASSTYPE.OTHER, junitImports);
	public static final ClassPackageInfo STATIC_JUNIT = 
			new ClassPackageInfo("STATIC_JUNIT", "", CLASSTYPE.OTHER, staticJunitImports);
	public static final ClassPackageInfo JUNIT_PARAMS = 
			new ClassPackageInfo("JUNIT_PARAMS", "", CLASSTYPE.OTHER, junitparamsImports);
	public static final ClassPackageInfo APACHE_HTTP = 
			new ClassPackageInfo("APACHE_HTTP", "", CLASSTYPE.OTHER, apacheHttpImports);
	public static final ClassPackageInfo UTILITY = 
			new ClassPackageInfo("UTILTIY", "", CLASSTYPE.OTHER, utilityImports);
}
