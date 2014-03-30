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
	};	


	public static final ClassPackageInfo ANNO_USER_AUTH 			= new ClassPackageInfo("UserAuthorization", PackageManager.getAuthPackage(), CLASSTYPE.INTERFACE, annoImports);
	public static final ClassPackageInfo ANNO_PATCH					= new ClassPackageInfo("PATCH", PackageManager.getFrameworkPackage(), CLASSTYPE.INTERFACE, annoImports);
	public static final ClassPackageInfo INTERFACE_ID  				= new ClassPackageInfo("IIDGenerator", PackageManager.getInterfacePackage(),CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo INTERFACE_AUTH_DECODER 	= new ClassPackageInfo("IAuthHeaderDecoder", PackageManager.getInterfacePackage(), CLASSTYPE.INTERFACE);
	public static final ClassPackageInfo ABSTRACT_CLASS_DAO 		= new ClassPackageInfo("DataAccessObjectFactory", PackageManager.getDatabasePackage(), CLASSTYPE.ABSTRACT_CLASS);
	public static final ClassPackageInfo CLASS_DAO 					= new ClassPackageInfo("DataAccessObject" , PackageManager.getDatabasePackage());
	public static final ClassPackageInfo CLASS_DB_QUERY				= new ClassPackageInfo("DBQuery", PackageManager.getDatabasePackage());
	public static final ClassPackageInfo CLASS_ID 					= new ClassPackageInfo("IDGenerator", PackageManager.getResourcePackage(), CLASSTYPE.CLASS);
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
	
}
