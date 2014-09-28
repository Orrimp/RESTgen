package de.fhws.rdsl.workflow;

import javax.inject.Inject;

public class Workflow implements Component {

	private ComponentsProvider components;

	@Inject
	public void setComponents(ComponentsProvider components) {
		this.components = components;
	}

	public ComponentsProvider getComponents() {
		return this.components;
	}

	@Override
	public void run() {
		this.components.get().forEach(Component::run);
	}

}
