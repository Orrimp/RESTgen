package de.fhws.rdsl.generator.db.components.api


import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class DataClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		new JavaClass => [
			pckg = commonDbDataPckg
			name = "Data"
			content = '''		
				public abstract class Data<R extends Identifier> implements Cloneable, Versioned {
					
					protected String revision;
					protected R identifier;
				
					public R getIdentifier() {
						return this.identifier;
					}
				
					public void setIdentifier(R identifier) {
						this.identifier = identifier;
					}
				
					@Override
					public String getRevision() {
						return this.revision;
					}
				
					public void setRevision(String revision) {
						this.revision = revision;
					}
				
					public abstract String getClassifier();
				
					public <T extends Data> T createClone() {
						try {
							return (T) super.clone();
						} catch (CloneNotSupportedException e) {
							throw new RuntimeException(e);
						}
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
