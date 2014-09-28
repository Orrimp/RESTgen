package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class QuerySpecificationClassComponent extends AbstractComponent {
	
	override createJavaClass() {
		
		return new JavaClass => [
			name = "QuerySpecification"
			pckg = commonDbPckg
			content =
			'''
			public class «name» {
				
				private «type("java.util.List")»<QueryPath> paths;
				private «type("java.util.List")»<«type("de.fhws.rdsl.query.FunctionDescription")»> functions;
				
				public «name»(«type("java.util.List")»<QueryPath> paths, «type("java.util.List")»<FunctionDescription> functions) {
					super();
					this.paths = paths;
					this.functions = functions;
				}

				public «type("java.util.List")»<«type("de.fhws.rdsl.query.FunctionDescription")»> getFunctions() {
					return this.functions;
				}

				public «type("java.util.List")»<QueryPath> getPaths() {
					return this.paths;
				}
				
			}
			'''
		]
	}
	

	
}