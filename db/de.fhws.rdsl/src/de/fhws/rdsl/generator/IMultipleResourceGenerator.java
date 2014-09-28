package de.fhws.rdsl.generator;

import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.eclipse.xtext.generator.IGenerator;


/**
 * @author Vitaliy
 * Class for managing multiple input files with same dsl. 
 */
public interface IMultipleResourceGenerator extends IGenerator {
	 /**
     * @param input -Is a Set of all the input files (resources) in the started eclipse application
     * @param fsa - file system access to be used to generate files with eclipse
     */
    public void doGenerate(ResourceSet input, IFileSystemAccess fsa);
}
