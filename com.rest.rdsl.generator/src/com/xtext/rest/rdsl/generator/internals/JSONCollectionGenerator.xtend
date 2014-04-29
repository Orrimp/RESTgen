package com.xtext.rest.rdsl.generator.internals

import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.management.Constants

/**
 * Class for JSON Collection generation
 */
class JSONCollectionGenerator {
	var IFileSystemAccess fsa;
	
	new(IFileSystemAccess fsa) {
		this.fsa = fsa;	
	}
	
	/**
	 * Generates a class for similar to the structure of application/vnc.collection+json MediaType.
	 */
	def generate() {
		fsa.generateFile(Naming.CLASS_JSONCOLLECTION.generationLocation + Constants.JAVA, 
		'''
			package «PackageManager.resourcePackage»;
			import java.util.List;
			import java.util.ArrayList;
			import java.net.URI;
			import «Naming.CLASS_LINK.classImport»;
			import «Naming.CLASS_OBJPARENT.classImport»;
			
			public class «Naming.CLASS_JSONCOLLECTION»{
			
				private List<«Naming.CLASS_OBJPARENT»> items = new ArrayList<«Naming.CLASS_OBJPARENT»>();
				private List<«Naming.CLASS_LINK»> links = new ArrayList<«Naming.CLASS_LINK»>();
				private String version = "0.1";
				private String href;
				private List<«Naming.CLASS_JSONCOL_QUERY»> query = new ArrayList<«Naming.CLASS_JSONCOL_QUERY»>();
				

				public «Naming.CLASS_JSONCOLLECTION»(String href){
					this.href = href;
				}
				
				public «Naming.CLASS_JSONCOLLECTION»(URI uri){
					this.href = uri.toString();
				}
				
				public «Naming.CLASS_JSONCOLLECTION»(String href, List<«Naming.CLASS_OBJPARENT»> items){
					this(href);
					this.items = items;
				}
				
				public List<«Naming.CLASS_OBJPARENT»> getItems(){
					if(this.items != null){
						return this.items;
					}
					return new ArrayList<«Naming.CLASS_OBJPARENT»>();
				}
				
				public void setItems(List<«Naming.CLASS_OBJPARENT»> items){
					if(items != null){
						this.items = items;
					}
				}
				
				public String getHref() {
					return href;
				}
				 
				public void setHref(String href) {
					this.href = href;
				}
				
				public String getVersion() {
					return version;
				}
				
				public void setVersion(String version) {
					this.version = version;
				}
				
				public List<SimpleLink> getLinks() {
					return links;
				}
				
				public void setLinks(List<SimpleLink> links) {
					this.links = links;
				}
				public List<«Naming.CLASS_JSONCOL_QUERY»> getQuery() {
					return query;
				}
				
				public void addQuery(«Naming.CLASS_JSONCOL_QUERY» query) {
					this.query.add(query);
				}
			}
		''');
		}
		
	/*
	 * Generates a class for query support inside the JSON Collection media type
	 */
	def geneateQueryClass(){
		fsa.generateFile(Constants.mainPackage + Constants.RESOURCEPACKAGE + "/"  + Naming.CLASS_JSONCOL_QUERY + Constants.JAVA,
			'''
			package «PackageManager.resourcePackage»;
			
			public class «Naming.CLASS_JSONCOL_QUERY»{
			
				private String href;
				private String rel;
				private String prompt;
				private String name;
				private String value;
				
				public «Naming.CLASS_JSONCOL_QUERY»(){}
				
				public String getHref() {
					return href;
				}
						
				public void setHref(String href) {
					this.href = href;
				}
						
				public String getRel() {
					return rel;
				}
						
				public void setRel(String rel) {
					this.rel = rel;
				}
						
				public String getPrompt() {
					return prompt;
				}
						
				public void setPrompt(String prompt) {
					this.prompt = prompt;
				}
						
				public String getName() {
					return name;
				}
						
				public void setName(String name) {
					this.name = name;
				}
						
				public String getValue() {
					return value;
				}
						
				public void setValue(String value) {
					this.value = value;
				}
			}
		''');
	}
}