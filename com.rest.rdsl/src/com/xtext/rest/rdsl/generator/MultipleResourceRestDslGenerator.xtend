package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.IMultipleResourceGenerator
import com.xtext.rest.rdsl.generator.core.FrameworkManager
import com.xtext.rest.rdsl.generator.core.ObjectGenerator
import com.xtext.rest.rdsl.generator.core.ObjectParentGenerator
import com.xtext.rest.rdsl.generator.internals.AnnotationUtils
import com.xtext.rest.rdsl.generator.internals.AuthenticationClass
import com.xtext.rest.rdsl.generator.internals.HATEOASGenerator
import com.xtext.rest.rdsl.generator.internals.IDGenerator
import com.xtext.rest.rdsl.generator.internals.InterfaceGenerator
import com.xtext.rest.rdsl.generator.internals.JSONCollectionGenerator
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.restDsl.CollectionResource
import com.xtext.rest.rdsl.restDsl.DispatcherResource
import com.xtext.rest.rdsl.restDsl.GlobalTratis
import com.xtext.rest.rdsl.restDsl.RESTModel
import com.xtext.rest.rdsl.restDsl.SingleResource
import java.util.ArrayList
import java.util.List
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.restDsl.RESTSecurity
import com.xtext.rest.rdsl.restDsl.RESTState
import java.util.Collection
import com.xtext.rest.rdsl.generator.rdsl.utils.ResourceResponseGenerator
import com.xtext.rest.rdsl.generator.rdsl.utils.ResponseGenerator
import com.xtext.rest.rdsl.generator.core.DAOGenerator

class MultipleResourceRestDslGenerator implements IMultipleResourceGenerator {

//For every Object xText generates a factory method
var RESTResourceObjects resources;
var ObjectParentGenerator obpgen;
var FrameworkManager frameWorkManager;

	/**
	 * This method is sometimes use more then once so be careful here and reset all the data. 
	 * Takes multiple resources (ResourceSet) and containts alle the resources created in child eclipse application.
	 */
	override doGenerate(ResourceSet input, IFileSystemAccess fsa) {
		val List<RESTModel> model = input.resources.map(r|r.allContents.toIterable.filter(typeof(RESTModel))).flatten.toList
		setEnviroment(model);
		
		this.frameWorkManager = new FrameworkManager(fsa, resources)
		this.frameWorkManager.generate();
		doGenerateMain(fsa);
		doGenerateOnes(fsa);
		generateDAO(fsa);
	}
	
	/**
	 * Generates all the neccessary classes depnding on user input but wihtout touching the resources.
	 */
	def doGenerateOnes(IFileSystemAccess fsa) {
		generateLinking(fsa)
		generateIDGen(fsa)
		generateInterfaces(fsa);
		generateCollectionJSON(fsa);
		generateOtherFiles(fsa);		
		generateMisc(fsa);
		generateResponses(fsa);
	}
	
	def generateResponses(IFileSystemAccess fsa) {
		val ResponseGenerator responseAbstractGen = new ResponseGenerator(fsa);
		val ResourceResponseGenerator responseGenerator = new ResourceResponseGenerator(fsa, resources);
	}
	
	/**
	 * Generates additinal Fieles for the project. NONE JAVA files. 
	 */
	def generateOtherFiles(IFileSystemAccess fsa) {
		val WebFileGenerator webGen = new WebFileGenerator(fsa);
		webGen.generatePomXML();
		webGen.generateWebXML();
	}
	
	def generateCollectionJSON(IFileSystemAccess fsa) {
		val JSONCollectionGenerator jcolGen = new JSONCollectionGenerator(fsa);
		jcolGen.generate();
		jcolGen.geneateQueryClass();
	}


	def generateDAO(IFileSystemAccess fsa) {
		val DAOGenerator daoGen = new DAOGenerator(fsa, resources)
		daoGen.generateDAOs()
		daoGen.generateInterface();
		daoGen.generateDAOAbstract();
		daoGen.generateSQLite();
		daoGen.generateSQLiteDAO();		
		daoGen.generateDBQuery();
	}	
	 
	def generateInterfaces(IFileSystemAccess fsa) {
		val InterfaceGenerator interfaceGen = new InterfaceGenerator(fsa, this.resources);
		interfaceGen.generateID();
		interfaceGen.generateDecoder();
	}
	
	def generateIDGen(IFileSystemAccess fsa) {
		val IDGenerator idGen = new IDGenerator(fsa, this.resources);
		idGen.generateID();
	}
	
	def generateLinking(IFileSystemAccess fsa) {
		val HATEOASGenerator hgen = new HATEOASGenerator(fsa);
		hgen.generate(Constants.OBJECTPACKAGE);
		hgen.generate(Constants.CLIENTPACKAGE);
	}

	/**
	 * Generates classes from resource files 
	 * @param recources Contains the configuration file and the resource files created with the xtext file extension
	 * @param fsa Access to the FileSystem through Eclipse. 
	 */
	def doGenerateMain(IFileSystemAccess fsa){	
		obpgen = new ObjectParentGenerator(fsa);
		obpgen.generate(PackageManager.clientPackage);
		obpgen.generate(PackageManager.objectPackage);
		val String path = Constants.mainPackage + Constants.OBJECTPACKAGE;
		for(r: resources.singleResources){
			fsa.generateFile(path + "/" + r.name + Constants.JAVA, compileObjects(obpgen, r))
		}
		
		for(r: resources.collectionResources){
			fsa.generateFile(path + "/" + r.name + Constants.JAVA, compileCollectionObjects(obpgen, r))
		}
	}
	
	def compileObjects(ObjectParentGenerator obgen, SingleResource resource) {
		val AnnotationUtils anno = new AnnotationUtils();
		val ObjectGenerator objGen = new ObjectGenerator(resources, anno, obgen)
		objGen.generate(PackageManager.objectPackage, resource);
	}
	
	def compileCollectionObjects(ObjectParentGenerator obgen, CollectionResource colRes){
		val ObjectGenerator objGen = new ObjectGenerator(resources, null, obgen);
		objGen.generateCollectionsObjects(colRes);
	}
		
	def generateMisc(IFileSystemAccess fsa) {	
		val AuthenticationClass authClass = new AuthenticationClass(fsa, this.resources);
		authClass.generate();
	}
		
	/**
	 * Set all the variables the environment is working with. 
	 * Most of this stuff is from the configuration dsl 
	 * @param resources contains all the configuration and resource files
	 */	
	def private setEnviroment(Iterable<RESTModel> model) {
		extractResourcesAndConfiguration(model);
		setPackages();		
	}
	
	private def setPackages() {
		
		var String mainPackage = Constants.getMainPackage.replaceAll("/", "\\.");
		
		PackageManager.setExceptionPackage(mainPackage + Constants.EXCEPTIONPACKAGE);
		PackageManager.setResourcePackage(mainPackage  + Constants.RESOURCEPACKAGE);
		PackageManager.setClientPackage(mainPackage  + Constants.CLIENTPACKAGE);
		PackageManager.setObjectPackage(mainPackage  + Constants.OBJECTPACKAGE);
		PackageManager.setInterfacePackage(mainPackage  + Constants.INTERFACEPACKAGE);
		PackageManager.setAuthPackage(mainPackage  + Constants.AUTHPACKAGE);
		PackageManager.setDatabasePackage(mainPackage  + Constants.DAOPACKAGE);
		PackageManager.setFrameworkPackage(mainPackage  + Constants.FRAMEWORKPACKAGE);
		PackageManager.setWebPackage(mainPackage  + Constants.WEBPACKAGE)
		PackageManager.setResponsePackage(mainPackage + Constants.RESPONSE);
	}
	
	/**
	 * Search the configuraiton dsl and resources
	 * If not found it will throw a NullpointerException
	 */
	def extractResourcesAndConfiguration(Iterable<RESTModel> model) {
		val List<SingleResource> resources = new ArrayList<SingleResource>();
		val List<CollectionResource> colresources = new ArrayList<CollectionResource>();
		val DispatcherResource dispatcher = model.get(0).dispatcher;
		val GlobalTratis gloablTraits = model.get(0).globalTratis;
		val RESTSecurity security = model.get(0).security;
		
		for(RESTState state: model.get(0).states){
			if(state instanceof SingleResource){
				resources.add(state as SingleResource);
			}else if(state instanceof CollectionResource){
				colresources.add(state as CollectionResource);
			}
		}
		
		this.resources = new RESTResourceObjects(resources, colresources, dispatcher, gloablTraits,security);
	}
	
	override doGenerate(Resource input, IFileSystemAccess fsa) {
		//Not used but comes with the interface
	}
	
}