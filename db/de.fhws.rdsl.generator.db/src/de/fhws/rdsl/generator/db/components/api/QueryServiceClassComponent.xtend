package de.fhws.rdsl.generator.db.components.api


import java.util.List

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.workflow.JavaClass

class QueryServiceClassComponent extends AbstractComponent {

	override createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return new JavaClass => [
			pckg = commonDbPckg
			name = "QueryService"
			content = '''		
				public interface «name» {
					
					«FOR table : tables.filter[it == it.actualTable]»
						QueryResult<«type(commonDbDataPckg, table.name + "Data")»> query«table.name»(«type("de.fhws.rdsl.query.Query")» query);
					«ENDFOR»
					
					QuerySpecification getSpecification();
					
				}
			'''
		]
	}
}
