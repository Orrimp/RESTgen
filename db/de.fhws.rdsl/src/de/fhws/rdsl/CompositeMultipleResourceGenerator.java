package de.fhws.rdsl;

import java.util.List;

import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtext.generator.IFileSystemAccess;

import com.google.common.collect.Lists;

import de.fhws.rdsl.generator.IMultipleResourceGenerator;

public class CompositeMultipleResourceGenerator implements IMultipleResourceGenerator {

	private List<IMultipleResourceGenerator> generators;

	public CompositeMultipleResourceGenerator(List<IMultipleResourceGenerator> generators) {
		super();
		this.generators = Lists.newArrayList(generators);
	}

	@Override
	public void doGenerate(Resource input, IFileSystemAccess fsa) {
		this.generators.stream().forEach(generator -> generator.doGenerate(input, fsa));
	}

	@Override
	public void doGenerate(ResourceSet input, IFileSystemAccess fsa) {
		this.generators.stream().forEach(generator -> generator.doGenerate(input, fsa));
	}

}
