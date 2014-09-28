package de.fhws.rdsl.workflow;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import com.google.common.base.Joiner;
import com.google.common.collect.Lists;

public abstract class JavaClassComponent implements Component {

	@Inject
	protected JavaClassHelper helper;

	@Inject
	protected Context ctx;

	@Override
	public void run() {
		List<JavaClass> clazzes = Lists.newArrayList(createJavaClass());
		clazzes.forEach(this.helper::organizeImports);
		clazzes.forEach(this.ctx::addFile);
	}

	public String type(Object... parts) {
		return this.helper.register(Joiner.on('.').join(parts));
	}

	protected Iterable<JavaClass> createJavaClass() {
		return Collections.emptyList();
	}

}
