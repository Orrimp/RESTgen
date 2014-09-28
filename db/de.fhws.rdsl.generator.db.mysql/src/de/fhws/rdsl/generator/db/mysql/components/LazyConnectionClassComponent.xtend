package de.fhws.rdsl.generator.db.mysql.components

import javax.inject.Inject
import javax.inject.Named
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class LazyConnectionClassComponent extends AbstractComponent implements MySQLConfigurationKeys {
	
	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg

	override protected createJavaClass() {
		return new JavaClass => [
			name = "LazyConnection"
			pckg = dbMySqlPckg
			content =
			'''
			public interface «name» extends «type("javax.inject.Provider")»<«type("java.sql.Connection")»> {
				
			}
			'''
		]
	}

}
