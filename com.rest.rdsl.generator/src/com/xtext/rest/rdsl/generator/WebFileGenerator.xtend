package com.xtext.rest.rdsl.generator

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.RESTConfiguration

class WebFileGenerator {
	
	private val IFileSystemAccess fsa;
	private val RESTConfiguration config;
	
	new(IFileSystemAccess fsa, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
	}
	
	def generatePomXML() {
		fsa.generateFile(Naming.FILE_POM.generationLocation, 
		'''
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>«config.package»</groupId>
  <artifactId>«config.package»-v«config.apiVersion»</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>war</packaging>
  <build>
    <sourceDirectory>src</sourceDirectory>
    <plugins>
      <plugin>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.1</version>
        <configuration>
          <source>1.7</source>
          <target>1.7</target>
        </configuration>
      </plugin>
      <plugin>
        <artifactId>maven-war-plugin</artifactId>
        <version>2.3</version>
        <configuration>
          <warSourceDirectory>WebContent</warSourceDirectory>
          <failOnMissingWebXml>false</failOnMissingWebXml>
        </configuration>
      </plugin>
    </plugins>
  </build>
  	<dependencies>
	  	<dependency>
			<groupId>org.apache.cxf</groupId>
			<artifactId>cxf-bundle-jaxrs</artifactId>
			<version>2.7.7</version>
		</dependency>
  		<dependency>
			<groupId>javax.ws.rs</groupId>
			<artifactId>javax.ws.rs-api</artifactId>
			<version>2.0-m10</version>
		</dependency>    
		<dependency>
		    <groupId>com.sun.jersey</groupId>
		    <artifactId>jersey-server</artifactId>
		    <version>1.17.1</version>
		</dependency>
		<dependency>
		    <groupId>com.sun.jersey</groupId>
		    <artifactId>jersey-core</artifactId>
		    <version>1.17.1</version>
		</dependency>
		<dependency>
		    <groupId>com.sun.jersey</groupId>
		    <artifactId>jersey-servlet</artifactId>
		    <version>1.17.1</version>
		</dependency>
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.17</version>
		</dependency>
		<dependency>
			<groupId>org.xerial</groupId>
			<artifactId>sqlite-jdbc</artifactId>
			<version>3.7.2</version>
		</dependency>
		<dependency>
			<groupId>com.owlike</groupId>
			<artifactId>genson</artifactId>
			<version>0.98</version>
		</dependency>
	</dependencies>
		<repositories>
		<repository>
			<id>maven2-repository.java.net</id>
			<name>Java.net Repository for Maven</name>
			<url>http://download.java.net/maven/2/</url>
			<layout>default</layout>
		</repository>
	</repositories>
</project>
		'''
		);
	}
	
	def generateWebXML() {
		fsa.generateFile(Naming.FILE_WEB.generationLocation, 
		'''
<?xml version="1.0" encoding="UTF-8"?>
  <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
  <display-name>v«config.apiVersion»</display-name>
  <servlet>
		<servlet-name>Jersey-Servlet</servlet-name>
		<servlet-class>
              com.sun.jersey.spi.container.servlet.ServletContainer
        </servlet-class>
		<init-param>
		     <param-name>com.sun.jersey.config.property.packages</param-name>
		     <param-value>«PackageManager.getResourcePackage»</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
 
	<servlet-mapping>
		<servlet-name>Jersey-Servlet</servlet-name>
		<url-pattern>/*</url-pattern>
	</servlet-mapping>
</web-app>
		''');
	}
	
}