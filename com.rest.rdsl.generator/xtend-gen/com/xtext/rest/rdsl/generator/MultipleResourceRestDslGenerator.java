package com.xtext.rest.rdsl.generator;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.xtext.rest.rdsl.generator.IMultipleResourceGenerator;
import com.xtext.rest.rdsl.generator.ResourceTypeCollection;
import com.xtext.rest.rdsl.generator.WebFileGenerator;
import com.xtext.rest.rdsl.generator.core.DAOGenerator;
import com.xtext.rest.rdsl.generator.core.FrameworkManager;
import com.xtext.rest.rdsl.generator.core.ObjectGenerator;
import com.xtext.rest.rdsl.generator.core.ObjectParentGenerator;
import com.xtext.rest.rdsl.generator.internals.AnnotationUtils;
import com.xtext.rest.rdsl.generator.internals.AuthenticationClass;
import com.xtext.rest.rdsl.generator.internals.HATEOASGenerator;
import com.xtext.rest.rdsl.generator.internals.IDGenerator;
import com.xtext.rest.rdsl.generator.internals.InterfaceGenerator;
import com.xtext.rest.rdsl.generator.internals.JSONCollectionGenerator;
import com.xtext.rest.rdsl.management.Constants;
import com.xtext.rest.rdsl.management.PackageManager;
import com.xtext.rest.rdsl.restDsl.Configuration;
import com.xtext.rest.rdsl.restDsl.PackageElement;
import com.xtext.rest.rdsl.restDsl.RESTModel;
import com.xtext.rest.rdsl.restDsl.ResourceType;
import com.xtext.rest.rdsl.restDsl.impl.RestDslFactoryImpl;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;

@SuppressWarnings("all")
public class MultipleResourceRestDslGenerator implements IMultipleResourceGenerator {
  private Configuration config = RestDslFactoryImpl.eINSTANCE.createConfiguration();
  
  private ResourceTypeCollection resources;
  
  private ObjectParentGenerator obpgen;
  
  private FrameworkManager frameWorkManager;
  
  /**
   * This method is sometimes use more then once so be careful here and reset all the data.
   * Takes multiple resources (ResourceSet) and containts alle the resources created in child eclipse application.
   */
  public void doGenerate(final ResourceSet input, final IFileSystemAccess fsa) {
    EList<Resource> _resources = input.getResources();
    final Function1<Resource,Iterable<RESTModel>> _function = new Function1<Resource,Iterable<RESTModel>>() {
      public Iterable<RESTModel> apply(final Resource r) {
        TreeIterator<EObject> _allContents = r.getAllContents();
        Iterable<EObject> _iterable = IteratorExtensions.<EObject>toIterable(_allContents);
        return Iterables.<RESTModel>filter(_iterable, RESTModel.class);
      }
    };
    List<Iterable<RESTModel>> _map = ListExtensions.<Resource, Iterable<RESTModel>>map(_resources, _function);
    Iterable<RESTModel> _flatten = Iterables.<RESTModel>concat(_map);
    final List<RESTModel> model = IterableExtensions.<RESTModel>toList(_flatten);
    this.setEnviroment(model);
    FrameworkManager _frameworkManager = new FrameworkManager(fsa, this.config, this.resources);
    this.frameWorkManager = _frameworkManager;
    this.frameWorkManager.generate();
    this.doGenerateMain(fsa);
    this.doGenerateOnes(fsa);
    this.generateDAO(fsa);
  }
  
  /**
   * Generates all the neccessary classes depnding on user input but wihtout touching the resources.
   */
  public void doGenerateOnes(final IFileSystemAccess fsa) {
    this.generateLinking(fsa);
    this.generateIDGen(fsa);
    this.generateInterfaces(fsa);
    this.generateCollectionJSON(fsa);
    this.generateOtherFiles(fsa);
    this.generateMisc(fsa);
  }
  
  /**
   * Generates additinal Fieles for the project. NONE JAVA files.
   */
  public void generateOtherFiles(final IFileSystemAccess fsa) {
    final WebFileGenerator webGen = new WebFileGenerator(fsa, this.config);
    webGen.generatePomXML();
    webGen.generateWebXML();
  }
  
  public void generateCollectionJSON(final IFileSystemAccess fsa) {
    final JSONCollectionGenerator jcolGen = new JSONCollectionGenerator(fsa);
    jcolGen.generate();
    jcolGen.geneateQueryClass();
  }
  
  public void generateDAO(final IFileSystemAccess fsa) {
    final DAOGenerator daoGen = new DAOGenerator(fsa, this.resources, this.config);
    daoGen.generateDAOs();
    daoGen.generateInterface();
    daoGen.generateDAOAbstract();
    daoGen.generateSQLite();
    daoGen.generateSQLiteDAO();
    daoGen.generateDBQuery();
  }
  
  public void generateInterfaces(final IFileSystemAccess fsa) {
    final InterfaceGenerator interfaceGen = new InterfaceGenerator(fsa, this.config);
    interfaceGen.generateID();
    interfaceGen.generateDecoder();
  }
  
  public void generateIDGen(final IFileSystemAccess fsa) {
    final IDGenerator idGen = new IDGenerator(fsa, this.config);
    idGen.generateID();
  }
  
  public void generateLinking(final IFileSystemAccess fsa) {
    final HATEOASGenerator hgen = new HATEOASGenerator(fsa);
    hgen.generate(Constants.OBJECTPACKAGE);
    hgen.generate(Constants.CLIENTPACKAGE);
  }
  
  /**
   * Generates classes from resource files
   * @param recources Contains the configuration file and the resource files created with the xtext file extension
   * @param fsa Access to the FileSystem through Eclipse.
   */
  public void doGenerateMain(final IFileSystemAccess fsa) {
    ObjectParentGenerator _objectParentGenerator = new ObjectParentGenerator(fsa, this.config);
    this.obpgen = _objectParentGenerator;
    String _clientPackage = PackageManager.getClientPackage();
    this.obpgen.generate(_clientPackage);
    String _objectPackage = PackageManager.getObjectPackage();
    this.obpgen.generate(_objectPackage);
    List<ResourceType> _resources = this.resources.getResources();
    for (final ResourceType r : _resources) {
      {
        String _mainPackage = Constants.getMainPackage();
        String _plus = (_mainPackage + Constants.OBJECTPACKAGE);
        String _plus_1 = (_plus + "/");
        String _name = r.getName();
        String _plus_2 = (_plus_1 + _name);
        String _plus_3 = (_plus_2 + Constants.JAVA);
        CharSequence _compileObjects = this.compileObjects(this.obpgen, r, this.config);
        fsa.generateFile(_plus_3, _compileObjects);
        String _mainPackage_1 = Constants.getMainPackage();
        String _plus_4 = (_mainPackage_1 + Constants.CLIENTPACKAGE);
        String _plus_5 = (_plus_4 + "/");
        String _name_1 = r.getName();
        String _plus_6 = (_plus_5 + _name_1);
        String _plus_7 = (_plus_6 + Constants.JAVA);
        CharSequence _generateClient = this.generateClient(this.obpgen, r, this.config);
        fsa.generateFile(_plus_7, _generateClient);
      }
    }
  }
  
  public CharSequence compileObjects(final ObjectParentGenerator obgen, final ResourceType resource, final Configuration configuration) {
    CharSequence _xblockexpression = null;
    {
      final AnnotationUtils anno = new AnnotationUtils();
      final ObjectGenerator objGen = new ObjectGenerator(resource, this.config, anno, obgen);
      String _objectPackage = PackageManager.getObjectPackage();
      _xblockexpression = objGen.generate(_objectPackage);
    }
    return _xblockexpression;
  }
  
  public CharSequence generateClient(final ObjectParentGenerator obgen, final ResourceType resource, final Configuration config) {
    CharSequence _xblockexpression = null;
    {
      final AnnotationUtils anno = new AnnotationUtils();
      final ObjectGenerator objGen = new ObjectGenerator(resource, config, anno, obgen);
      String _clientPackage = PackageManager.getClientPackage();
      _xblockexpression = objGen.generate(_clientPackage);
    }
    return _xblockexpression;
  }
  
  public void generateMisc(final IFileSystemAccess fsa) {
    final AuthenticationClass authClass = new AuthenticationClass(this.config, fsa);
    authClass.generate();
  }
  
  /**
   * Set all the variables the environment is working with.
   * Most of this stuff is from the configuration dsl
   * @param resources contains all the configuration and resource files
   */
  private void setEnviroment(final Iterable<RESTModel> model) {
    this.extractResourcesAndConfiguration(model);
    String _package = this.config.getPackage();
    String _replaceAll = _package.replaceAll("\\.", "/");
    String _plus = (_replaceAll + "/");
    Constants.setMainPackage(_plus);
    String _package_1 = this.config.getPackage();
    PackageManager.setMainPackage(_package_1);
    String _package_2 = this.config.getPackage();
    String _plus_1 = (_package_2 + ".");
    String _plus_2 = (_plus_1 + Constants.EXCEPTIONPACKAGE);
    PackageManager.setExceptionPackage(_plus_2);
    String _package_3 = this.config.getPackage();
    String _plus_3 = (_package_3 + ".");
    String _plus_4 = (_plus_3 + Constants.RESOURCEPACKAGE);
    PackageManager.setResourcePackage(_plus_4);
    String _package_4 = this.config.getPackage();
    String _plus_5 = (_package_4 + ".");
    String _plus_6 = (_plus_5 + Constants.CLIENTPACKAGE);
    PackageManager.setClientPackage(_plus_6);
    String _package_5 = this.config.getPackage();
    String _plus_7 = (_package_5 + ".");
    String _plus_8 = (_plus_7 + Constants.OBJECTPACKAGE);
    PackageManager.setObjectPackage(_plus_8);
    String _package_6 = this.config.getPackage();
    String _plus_9 = (_package_6 + ".");
    String _plus_10 = (_plus_9 + Constants.INTERFACEPACKAGE);
    PackageManager.setInterfacePackage(_plus_10);
    String _package_7 = this.config.getPackage();
    String _plus_11 = (_package_7 + ".");
    String _plus_12 = (_plus_11 + Constants.AUTHPACKAGE);
    PackageManager.setAuthPackage(_plus_12);
    String _package_8 = this.config.getPackage();
    String _plus_13 = (_package_8 + ".");
    String _plus_14 = (_plus_13 + Constants.DAOPACKAGE);
    PackageManager.setDatabasePackage(_plus_14);
    String _package_9 = this.config.getPackage();
    String _plus_15 = (_package_9 + ".");
    String _plus_16 = (_plus_15 + Constants.FRAMEWORKPACKAGE);
    PackageManager.setFrameworkPackage(_plus_16);
    String _package_10 = this.config.getPackage();
    String _plus_17 = (_package_10 + ".");
    String _plus_18 = (_plus_17 + Constants.WEBPACKAGE);
    PackageManager.setWebPackage(_plus_18);
  }
  
  /**
   * Search the configuraiton dsl and resources
   * If not found it will throw a NullpointerException
   */
  public void extractResourcesAndConfiguration(final Iterable<RESTModel> models) {
    final List<ResourceType> resources = new ArrayList<ResourceType>();
    ResourceType userResource = null;
    for (final RESTModel model : models) {
      com.xtext.rest.rdsl.restDsl.Package _package = model.getPackage();
      boolean _notEquals = (!Objects.equal(_package, null));
      if (_notEquals) {
        com.xtext.rest.rdsl.restDsl.Package _package_1 = model.getPackage();
        EList<PackageElement> _elements = _package_1.getElements();
        Iterable<ResourceType> _filter = Iterables.<ResourceType>filter(_elements, ResourceType.class);
        for (final ResourceType resource : _filter) {
          resources.add(resource);
        }
        com.xtext.rest.rdsl.restDsl.Package _package_2 = model.getPackage();
        ResourceType _userResource = _package_2.getUserResource();
        boolean _notEquals_1 = (!Objects.equal(_userResource, null));
        if (_notEquals_1) {
          com.xtext.rest.rdsl.restDsl.Package _package_3 = model.getPackage();
          ResourceType _userResource_1 = _package_3.getUserResource();
          resources.add(_userResource_1);
        }
        com.xtext.rest.rdsl.restDsl.Package _package_4 = model.getPackage();
        ResourceType _userResource_2 = _package_4.getUserResource();
        userResource = _userResource_2;
      } else {
        Configuration _configuration = model.getConfiguration();
        boolean _notEquals_2 = (!Objects.equal(_configuration, null));
        if (_notEquals_2) {
          Configuration _configuration_1 = model.getConfiguration();
          this.config = _configuration_1;
        }
      }
    }
    ResourceTypeCollection _resourceTypeCollection = new ResourceTypeCollection(resources);
    this.resources = _resourceTypeCollection;
    this.resources.setUserResource(userResource);
    boolean _equals = Objects.equal(this.config, null);
    if (_equals) {
      throw new NullPointerException("No configurationFile found!");
    }
  }
  
  public void doGenerate(final Resource input, final IFileSystemAccess fsa) {
  }
}
