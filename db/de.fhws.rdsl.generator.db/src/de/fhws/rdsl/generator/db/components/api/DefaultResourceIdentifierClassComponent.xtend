package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class DefaultResourceIdentifierClassComponent extends AbstractComponent {
	override createJavaClass() {
		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "DefaultResourceIdentifier"
			content = '''		
				public class «name» implements ResourceIdentifier {
					
					private «type("java.util.List")»<String> path;

					public DefaultResourceIdentifier(String... path) {
						super();
						«type("com.google.common.base.Preconditions")».checkNotNull(path);
						«type("com.google.common.base.Preconditions")».checkArgument(path.length > 0);
						this.path = «type("java.util.Arrays")».asList(path);
					}

					public DefaultResourceIdentifier(«type("java.util.List")»<String> path) {
						super();
						«type("com.google.common.base.Preconditions")».checkNotNull(path);
						«type("com.google.common.base.Preconditions")».checkArgument(path.size() > 0);
						this.path = «type("com.google.common.collect.Lists")».newArrayList(path);
					}

					@Override
					public «type("java.util.List")»<String> getPath() {
						return «type("java.util.Collections")».unmodifiableList(this.path);
					}

					@Override
					public String getLastSegment() {
						return this.path.get(this.path.size() - 1);
					}

					@Override
					public String getSegment(int idx) {
						return this.path.get(idx);
					}

					@Override
					public boolean equals(Object obj) {
						if (this == obj) {
							return true;
						}
						if (obj == null) {
							return false;
						}
						if (!(obj instanceof ResourceIdentifier)) {
							return false;
						}

						ResourceIdentifier other = (ResourceIdentifier) obj;

						if (getPath().size() != other.getPath().size()) {
							return false;
						}

						for (int i = 0; i < getPath().size(); i++) {
							if (!getPath().get(i).equals(other.getPath().get(i))) {
								return false;
							}
						}

						return true;
					}

					@Override
					public String toString() {
						return «type("org.apache.commons.lang3.builder.ToStringBuilder")».reflectionToString(this);
					}
				}
			'''
		]
	}
}