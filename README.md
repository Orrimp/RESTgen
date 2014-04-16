RESTgen
=======

This projekts allows to generate RESTful Jersey source code defined by a model. It uses Xtend and Xtend features to generate the source code. 


## Using RESTgen

1. Clone or download a copy of the Rajawali source code.
2. Install Xtext and Xtend Plugins in Eclipse.
2. Import the RESTgen project into Eclipse.
3. You need all four projects
4. The main project is "com.rest.rdsl" which contains the "RestDsl.xtext" 
5. Right click on the file and select Run as "Generating Xtext Artifacts" to genearte files for the Generators
6. Wait!
7. Run as Eclipse Appliation.
8. Create a Java project in the new Eclipse instance
9. Add a file with the extension ".rdsl" and confirm the xtext nature. 
10. Define the REST model, save the file and wait for the stuff to be generated.

A file can be either a resource or a configuration. The framework uses the first config file its find. The user can specify multiple resource files which all be used. 

## Example Resource File Entry

File: resource.rdsl

Idea: The user defines a resource with a name "Users" and multiple attributes. Every "Attribute" can specify a HTTP Method: GET, NONE; a Java Type: String, Date..; and a attribute name. "username". Other HTTP Methods are generated where they are needed. 

Content:  
```java 
Resource Users 

{ 

	Attributes 
	
	GET Java java.lang.String username 
	
	GET Java java.lang.String password 
	
	GET Java java.lang.String firstName 
	
	GET Java java.lang.String secondName 
	
	GET Java java.util.Date birthday 
	
    GET Java java.lang.String alias 
	
	GET Resource Messages tweets  
	
} 
```
## Example Configuration File 

File: config.rdsl 

Idea:  

The URI is used with the HATEOAS constraint.  
Package helps to create order in the project.  
The Framework supports currently only JSON MIME and Jersey as REST-Framework. The ID is used to access the resources. 
The persitency layer is using SQLite DB as seen in the last lines. 

Content:  
```java
Config{ 

	Base URI http://localhost:8080/v1  
	
	Base Package com.rest.rdsl 
	
	MIME json 
	
	Framework Jersey 
	
	ID-Generation long  
	
	API-Version v=1 
	
	Caching ETag 
	
	Paging size 10 
	
	JDBC-Driver org.sqlite.JDBC 
	
	JDBC-File jdbc:sqlite:mydatabase.db 
	
} 
```