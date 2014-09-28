package de.fhws.rdsl.workflow;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import com.google.common.collect.Lists;

public class JavaClass extends File implements Iterable<JavaClass> {

	private List<Import> imports = Lists.newArrayList();

	public List<Import> getImports() {
		return this.imports;
	}

	@Override
	public Iterator<JavaClass> iterator() {
		return Collections.singleton(this).iterator();
	}
}
