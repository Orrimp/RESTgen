package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class QueryResultClassComponent extends AbstractComponent {

	override createJavaClass() {

		return new JavaClass => [
			name = "QueryResult"
			pckg = commonDbPckg
			content = '''
				public class «name»<T extends «type(commonDbDataPckg, "Data")»<?>> {
					
					private «type("java.util.List")»<T> result = new «type("java.util.ArrayList")»<T>();
					private Long totalCount = null;
					
					public List<T> getResult() {
						return this.result;
					}
					
					public Long getTotalCount() {
						return this.totalCount;
					}
					
					public void setTotalCount(Long totalCount) {
						this.totalCount = totalCount;
					}
					
				}
			'''
		]
	}

}
