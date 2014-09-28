package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class DefaultReferenceIdentifierClassComponent extends AbstractComponent {
	override createJavaClass() {
		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "DefaultReferenceIdentifier"
			content = '''		
				public class «name» implements ReferenceIdentifier {
					
					private ResourceIdentifier id1;
					private ResourceIdentifier id2;
					
					public DefaultReferenceIdentifier(ResourceIdentifier id1, ResourceIdentifier id2) {
						super();
						this.id1 = id1;
						this.id2 = id2;
					}
				
					@Override
					public ResourceIdentifier getId1() {
						return this.id1;
					}
				
					@Override
					public ResourceIdentifier getId2() {
						return this.id2;
					}
				
					@Override
					public boolean equals(Object obj) {
						if (this == obj) {
							return true;
						}
						if (obj == null) {
							return false;
						}
						if (!(obj instanceof ReferenceIdentifier)) {
							return false;
						}
				
						ReferenceIdentifier other = (ReferenceIdentifier) obj;
				
						if (this.id1 == null) {
							if (other.getId1() != null) {
								return false;
							}
						} else if (!this.id1.equals(other.getId1())) {
							return false;
						}
				
						if (this.id2 == null) {
							if (other.getId2() != null) {
								return false;
							}
						} else if (!this.id2.equals(other.getId2())) {
							return false;
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
