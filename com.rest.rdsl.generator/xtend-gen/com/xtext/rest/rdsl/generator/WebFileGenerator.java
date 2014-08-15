package com.xtext.rest.rdsl.generator;

import com.xtext.rest.rdsl.management.Naming;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.Configuration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.generator.IFileSystemAccess;

@SuppressWarnings("all")
public class WebFileGenerator {
  private final IFileSystemAccess fsa;
  
  private final Configuration config;
  
  public WebFileGenerator(final IFileSystemAccess fsa, final Configuration config) {
    this.fsa = fsa;
    this.config = config;
  }
  
  public void generatePomXML() {
    String _generationLocation = Naming.FILE_POM.getGenerationLocation();
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<modelVersion>4.0.0</modelVersion>");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<groupId>");
    String _package = this.config.getPackage();
    _builder.append(_package, "  ");
    _builder.append("</groupId>");
    _builder.newLineIfNotEmpty();
    _builder.append("  ");
    _builder.append("<artifactId>");
    String _package_1 = this.config.getPackage();
    _builder.append(_package_1, "  ");
    _builder.append("-v");
    String _apiVersion = this.config.getApiVersion();
    _builder.append(_apiVersion, "  ");
    _builder.append("</artifactId>");
    _builder.newLineIfNotEmpty();
    _builder.append("  ");
    _builder.append("<version>0.0.1-SNAPSHOT</version>");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<packaging>war</packaging>");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<build>");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("<sourceDirectory>src</sourceDirectory>");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("<plugins>");
    _builder.newLine();
    _builder.append("      ");
    _builder.append("<plugin>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<artifactId>maven-compiler-plugin</artifactId>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<version>3.1</version>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<configuration>");
    _builder.newLine();
    _builder.append("          ");
    _builder.append("<source>1.7</source>");
    _builder.newLine();
    _builder.append("          ");
    _builder.append("<target>1.7</target>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("</configuration>");
    _builder.newLine();
    _builder.append("      ");
    _builder.append("</plugin>");
    _builder.newLine();
    _builder.append("      ");
    _builder.append("<plugin>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<artifactId>maven-war-plugin</artifactId>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<version>2.3</version>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("<configuration>");
    _builder.newLine();
    _builder.append("          ");
    _builder.append("<warSourceDirectory>WebContent</warSourceDirectory>");
    _builder.newLine();
    _builder.append("          ");
    _builder.append("<failOnMissingWebXml>false</failOnMissingWebXml>");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("</configuration>");
    _builder.newLine();
    _builder.append("      ");
    _builder.append("</plugin>");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("</plugins>");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("</build>");
    _builder.newLine();
    _builder.append("  \t");
    _builder.append("<dependencies>");
    _builder.newLine();
    _builder.append("\t  \t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<groupId>org.apache.cxf</groupId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<artifactId>cxf-bundle-jaxrs</artifactId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<version>2.7.7</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("  \t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<groupId>javax.ws.rs</groupId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<artifactId>javax.ws.rs-api</artifactId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<version>2.0-m10</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>    ");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<groupId>com.sun.jersey</groupId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<artifactId>jersey-server</artifactId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<version>1.17.1</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<groupId>com.sun.jersey</groupId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<artifactId>jersey-core</artifactId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<version>1.17.1</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<groupId>com.sun.jersey</groupId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<artifactId>jersey-servlet</artifactId>");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("<version>1.17.1</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<groupId>log4j</groupId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<artifactId>log4j</artifactId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<version>1.2.17</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<groupId>org.xerial</groupId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<artifactId>sqlite-jdbc</artifactId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<version>3.7.2</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<dependency>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<groupId>com.owlike</groupId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<artifactId>genson</artifactId>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<version>0.98</version>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</dependency>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</dependencies>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<repositories>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<repository>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<id>maven2-repository.java.net</id>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<name>Java.net Repository for Maven</name>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<url>http://download.java.net/maven/2/</url>");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("<layout>default</layout>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("</repository>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</repositories>");
    _builder.newLine();
    _builder.append("</project>");
    _builder.newLine();
    this.fsa.generateFile(_generationLocation, _builder);
  }
  
  public void generateWebXML() {
    String _generationLocation = Naming.FILE_WEB.getGenerationLocation();
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<web-app xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://java.sun.com/xml/ns/javaee\" xsi:schemaLocation=\"http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd\" id=\"WebApp_ID\" version=\"3.0\">");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("<display-name>v");
    String _apiVersion = this.config.getApiVersion();
    _builder.append(_apiVersion, "  ");
    _builder.append("</display-name>");
    _builder.newLineIfNotEmpty();
    _builder.append("  ");
    _builder.append("<servlet>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<servlet-name>Jersey-Servlet</servlet-name>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<servlet-class>");
    _builder.newLine();
    _builder.append("              ");
    _builder.append("com.sun.jersey.spi.container.servlet.ServletContainer");
    _builder.newLine();
    _builder.append("        ");
    _builder.append("</servlet-class>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<init-param>");
    _builder.newLine();
    _builder.append("\t\t     ");
    _builder.append("<param-name>com.sun.jersey.config.property.packages</param-name>");
    _builder.newLine();
    _builder.append("\t\t     ");
    _builder.append("<param-value>");
    String _resourcePackage = PackageManager.getResourcePackage();
    _builder.append(_resourcePackage, "\t\t     ");
    _builder.append("</param-value>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("</init-param>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<load-on-startup>1</load-on-startup>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</servlet>");
    _builder.newLine();
    _builder.append(" ");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<servlet-mapping>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<servlet-name>Jersey-Servlet</servlet-name>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<url-pattern>/*</url-pattern>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</servlet-mapping>");
    _builder.newLine();
    _builder.append("</web-app>");
    _builder.newLine();
    this.fsa.generateFile(_generationLocation, _builder);
  }
}