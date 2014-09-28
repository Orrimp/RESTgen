package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class QueryPathClassComponent extends AbstractComponent {
	override createJavaClass() {

		return new JavaClass => [
			name = "QueryPath"
			pckg = commonDbPckg
			content = '''
				public class «name» {
					
					private String from;
					private String property;
				
					public QueryPath(String from, String property) {
						super();
						this.from = from;
						this.property = property;
					}
				
					public String getFrom() {
						return this.from;
					}
				
					public String getProperty() {
						return this.property;
					}
					
				}
			'''
		]
	}
}
