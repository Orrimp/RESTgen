package com.xtext.rest.rdsl.generator;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import com.xtext.rest.rdsl.generator.IMultipleResourceGenerator;
import com.xtext.rest.rdsl.generator.RESTResourceCollection;
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
import com.xtext.rest.rdsl.restDsl.RESTConfiguration;
import com.xtext.rest.rdsl.restDsl.RESTModel;
import com.xtext.rest.rdsl.restDsl.RESTResource;
import com.xtext.rest.rdsl.restDsl.RESTResources;
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
  private RESTConfiguration config = RestDslFactoryImpl.eINSTANCE.createRESTConfiguration();
  
  private RESTResourceCollection resources;
  
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
    List<RESTResource> _resources = this.resources.getResources();
    for (final RESTResource r : _resources) {
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
  
  public CharSequence compileObjects(final ObjectParentGenerator obgen, final RESTResource resource, final RESTConfiguration configuration) {
    CharSequence _xblockexpression = null;
    {
      final AnnotationUtils anno = new AnnotationUtils();
      final ObjectGenerator objGen = new ObjectGenerator(resource, this.config, anno, obgen);
      String _objectPackage = PackageManager.getObjectPackage();
      _xblockexpression = objGen.generate(_objectPackage);
    }
    return _xblockexpression;
  }
  
  public CharSequence generateClient(final ObjectParentGenerator obgen, final RESTResource resource, final RESTConfiguration config) {
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
  public void extractResourcesAndConfiguration(final Iterable<RESTModel> model) {
    final List<RESTResource> resources = new ArrayList<RESTResource>();
    RESTResource userResource = null;
    for (final RESTModel r : model) {
      RESTResources _res = r.getRes();
      boolean _notEquals = (!Objects.equal(_res, null));
      if (_notEquals) {
        RESTResources _res_1 = r.getRes();
        EList<RESTResource> _resources = _res_1.getResources();
        for (final RESTResource resource : _resources) {
          resources.add(resource);
        }
        RESTResources _res_2 = r.getRes();
        RESTResource _userRes = _res_2.getUserRes();
        boolean _notEquals_1 = (!Objects.equal(_userRes, null));
        if (_notEquals_1) {
          RESTResources _res_3 = r.getRes();
          RESTResource _userRes_1 = _res_3.getUserRes();
          resources.add(_userRes_1);
        }
        RESTResources _res_4 = r.getRes();
        RESTResource _userRes_2 = _res_4.getUserRes();
        userResource = _userRes_2;
      } else {
        RESTConfiguration _con = r.getCon();
        boolean _notEquals_2 = (!Objects.equal(_con, null));
        if (_notEquals_2) {
          RESTConfiguration _con_1 = r.getCon();
          this.config = _con_1;
        }
      }
    }
    RESTResourceCollection _rESTResourceCollection = new RESTResourceCollection(resources);
    this.resources = _rESTResourceCollection;
    this.resources.setUserResource(userResource);
    boolean _equals = Objects.equal(this.config, null);
    if (_equals) {
      throw new NullPointerException("No configurationFile found!");
    }
  }
  
  public void doGenerate(final Resource input, final IFileSystemAccess fsa) {
  }
}
