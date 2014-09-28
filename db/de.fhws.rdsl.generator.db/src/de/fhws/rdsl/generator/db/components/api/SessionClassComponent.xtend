package de.fhws.rdsl.generator.db.components.api

import java.util.List
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.ReferenceTable

class SessionClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return new JavaClass => [
			pckg = commonDbPckg
			name = "Session"
			content = '''		
				public interface «name» extends AutoCloseable {
					
					boolean isTransactionSupported();
					
					void beginTransaction();
					
					void commit();
					
					void rollback();
					
					«FOR table : tables»
						
						«IF table instanceof ReferenceTable»
							«type(commonDbDataPckg, table.name.toFirstUpper + "Data")» load«table.name.toFirstUpper»(«type(
					commonDbDataPckg, "ReferenceIdentifier")» identifier, int lock);
						«ELSE»
							«type(commonDbDataPckg, table.name.toFirstUpper + "Data")» load«table.name.toFirstUpper»(«type(
					commonDbDataPckg, "ResourceIdentifier")» identifier, int lock);
						«ENDIF»
						
						void update«table.name.toFirstUpper»(String oldRevision, «table.name.toFirstUpper»Data data);
						
						«IF table instanceof ReferenceTable»
							void delete«table.name.toFirstUpper»(String oldRevision, «type(commonDbDataPckg, "ReferenceIdentifier")» identifier);
						«ELSE»
							void delete«table.name.toFirstUpper»(String oldRevision, «type(commonDbDataPckg, "ResourceIdentifier")» identifier);
						«ENDIF»
						
					«ENDFOR»
					
				}
			'''
		]
	}

}
