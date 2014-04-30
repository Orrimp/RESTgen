package com.xtext.rest.rdsl.generator

import com.xtext.rest.rdsl.generator.core.DAOGenerator
import com.xtext.rest.rdsl.generator.core.FrameworkManager
import com.xtext.rest.rdsl.generator.core.ObjectGenerator
import com.xtext.rest.rdsl.generator.core.ObjectParentGenerator
import com.xtext.rest.rdsl.generator.internals.AuthenticationClass
import com.xtext.rest.rdsl.generator.internals.HATEOASGenerator
import com.xtext.rest.rdsl.generator.internals.IDGenerator
import com.xtext.rest.rdsl.generator.internals.InterfaceGenerator
import com.xtext.rest.rdsl.generator.internals.JSONCollectionGenerator
import com.xtext.rest.rdsl.restDsl.Configuration
import com.xtext.rest.rdsl.restDsl.RESTModel
import com.xtext.rest.rdsl.restDsl.ResourceType
import com.xtext.rest.rdsl.restDsl.impl.RestDslFactoryImpl
import java.util.ArrayList
import java.util.List
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.internals.AnnotationUtils
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants

class MultipleResourceRestDslGenerator implements IMultipleResourceGenerator {

//For every Object xText generates a factory method
var Configuration config = RestDslFactoryImpl.eINSTANCE.createConfiguration;
var ResourceTypeCollection resources;
var ObjectParentGenerator obpgen;
var FrameworkManager frameWorkManager;

	/**
	 * This method is sometimes use more then once so be careful here and reset all the data. 
	 * Takes multiple resources (ResourceSet) and containts alle the resources created in child eclipse application.
	 */
	override doGenerate(ResourceSet input, IFileSystemAccess fsa) {
		val List<RESTModel> model = input.resources.map(r|r.allContents.toIterable.filter(typeof(RESTModel))).flatten.toList
		setEnviroment(model);
		
		this.frameWorkManager = new FrameworkManager(fsa, config, resources)
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
	}
	
	/**
	 * Generates additinal Fieles for the project. NONE JAVA files. 
	 */
	def generateOtherFiles(IFileSystemAccess fsa) {
		val WebFileGenerator webGen = new WebFileGenerator(fsa, config);
		webGen.generatePomXML();
		webGen.generateWebXML();
	}
	
	def generateCollectionJSON(IFileSystemAccess fsa) {
		val JSONCollectionGenerator jcolGen = new JSONCollectionGenerator(fsa);
		jcolGen.generate();
		jcolGen.geneateQueryClass();
	}


	def generateDAO(IFileSystemAccess fsa) {
		val DAOGenerator daoGen = new DAOGenerator(fsa, resources, config)
		daoGen.generateDAOs()
		daoGen.generateInterface();
		daoGen.generateDAOAbstract();
		daoGen.generateSQLite();
		daoGen.generateSQLiteDAO();		
		daoGen.generateDBQuery();
	}	
	 
	def generateInterfaces(IFileSystemAccess fsa) {
		val InterfaceGenerator interfaceGen = new InterfaceGenerator(fsa, config);
		interfaceGen.generateID();
		interfaceGen.generateDecoder();
	}
	
	def generateIDGen(IFileSystemAccess fsa) {
		val IDGenerator idGen = new IDGenerator(fsa, config);
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
		obpgen = new ObjectParentGenerator(fsa, config);
		obpgen.generate(PackageManager.clientPackage);
		obpgen.generate(PackageManager.objectPackage);
		
		for(r: resources.resources){
			fsa.generateFile(Constants.mainPackage + Constants.OBJECTPACKAGE+ "/" + r.name + Constants.JAVA, compileObjects(obpgen, r, config))
			fsa.generateFile(Constants.mainPackage + Constants.CLIENTPACKAGE + "/" + r.name + Constants.JAVA, generateClient(obpgen, r, config))
		}
	}
	
	def compileObjects(ObjectParentGenerator obgen, ResourceType resource, Configuration configuration) {
		val AnnotationUtils anno = new AnnotationUtils();
// 		JAXB Annotations
//		anno.setClassAnno("@XmlRootElement(name = \"" +resource.name + "\") \r\n@XmlAccessorType(XmlAccessType.FIELD)");
//		anno.setFieldAnno("@XmlElement(nillable = true) ");
//		anno.setAnnoImports(ImportManager.JAXBAnnoImports);
		val ObjectGenerator objGen = new ObjectGenerator(resource, config, anno, obgen)
		objGen.generate(PackageManager.objectPackage);
	}
	
	
	
	def generateClient(ObjectParentGenerator obgen, ResourceType resource, Configuration config){
		val AnnotationUtils anno = new AnnotationUtils();

		val ObjectGenerator objGen = new ObjectGenerator(resource, config, anno, obgen)
		objGen.generate(PackageManager.clientPackage);

	}
	
		
	def generateMisc(IFileSystemAccess fsa) {	
		val AuthenticationClass authClass = new AuthenticationClass(config, fsa);
		authClass.generate();
	}
		
	/**
	 * Set all the variables the environment is working with. 
	 * Most of this stuff is from the configuration dsl 
	 * @param resources contains all the configuration and resource files
	 */	
	def private setEnviroment(Iterable<RESTModel> model) {
		extractResourcesAndConfiguration(model);
		Constants.setMainPackage((config.package.replaceAll("\\.", "/") + "/"));
		
		PackageManager.setMainPackage(config.package);
		PackageManager.setExceptionPackage(config.package + "." + Constants.EXCEPTIONPACKAGE);
		PackageManager.setResourcePackage(config.package + "." + Constants.RESOURCEPACKAGE);
		PackageManager.setClientPackage(config.package + "." + Constants.CLIENTPACKAGE);
		PackageManager.setObjectPackage(config.package + "." + Constants.OBJECTPACKAGE);
		PackageManager.setInterfacePackage(config.package + "." + Constants.INTERFACEPACKAGE);
		PackageManager.setAuthPackage(config.package + "." + Constants.AUTHPACKAGE);
		PackageManager.setDatabasePackage(config.package + "." + Constants.DAOPACKAGE);
		PackageManager.setFrameworkPackage(config.package + "." + Constants.FRAMEWORKPACKAGE);
		PackageManager.setWebPackage(config.package + "." + Constants.WEBPACKAGE);		
	}
	
	/**
	 * Search the configuraiton dsl and resources
	 * If not found it will throw a NullpointerException
	 */
	def extractResourcesAndConfiguration(Iterable<RESTModel> models) {
		val List<ResourceType> resources = new ArrayList<ResourceType>();
		var ResourceType userResource;
		for(model : models){
			if(model.package!=null){							//Config file??		
				for(resource: model.package.elements.filter(ResourceType)){
					resources.add(resource);
				}
				if(model.package.userResource != null)
					resources.add(model.package.userResource);
					userResource = model.package.userResource;
			}else if(model.configuration != null){
				this.config = model.configuration;
			}
		}
		this.resources = new ResourceTypeCollection(resources);
		this.resources.userResource = userResource;
		
		if(config == null)
			throw new NullPointerException("No configurationFile found!")
	}
	
	override doGenerate(Resource input, IFileSystemAccess fsa) {
		//Not used but comes with the interface
	}
	
}