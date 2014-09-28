package de.fhws.rdsl.generator.db.mysql.components

import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ResultSetConverterClassComponent extends AbstractComponent implements MySQLConfigurationKeys  {
	
	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg

	override protected createJavaClass() {
		return new JavaClass => [
			name = "ResultSetConverter"
			pckg = dbMySqlPckg
			content = '''
				public interface «name»<T> extends «type(dbPckg, "Converter")»<T, «type("java.sql.ResultSet")»> {
					
				}
			'''
		]
	}

}
