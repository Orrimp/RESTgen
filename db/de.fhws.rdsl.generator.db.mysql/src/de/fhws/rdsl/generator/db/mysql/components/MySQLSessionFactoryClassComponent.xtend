package de.fhws.rdsl.generator.db.mysql.components

import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class MySQLSessionFactoryClassComponent extends AbstractComponent implements MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg
	
	override protected createJavaClass() {
		return new JavaClass => [
			name = "MySQLSessionFactory"
			pckg = dbMySqlPckg
			content = '''
				public class «name» implements «type(commonDbPckg, "SessionFactory")» {
				
					private DataSource dataSource;
				
					@«type("javax.inject.Inject")»
					public «name»(«type("javax.sql.DataSource")» dataSource) {
						super();
						this.dataSource = dataSource;
					}
				
					@Override
					public «type(commonDbPckg, "Session")» createSession() {
						return new «type(dbMySqlPckg, "MySQLSession")»(new «type(dbMySqlPckg, "DefaultLazyConnection")»(this.dataSource));
					}
				
					@Override
					public void close() throws Exception {
						// Nothing
					}
				}
			'''
		]
	}

}
