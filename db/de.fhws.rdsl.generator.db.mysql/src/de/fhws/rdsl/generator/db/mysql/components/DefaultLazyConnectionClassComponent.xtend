package de.fhws.rdsl.generator.db.mysql.components

import javax.inject.Inject
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class DefaultLazyConnectionClassComponent extends AbstractComponent implements MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg

	override protected createJavaClass() {
		return new JavaClass => [
			name = "DefaultLazyConnection"
			pckg = dbMySqlPckg
			content = '''
				public class «name» implements LazyConnection {
					private «type("javax.sql.DataSource")» dataSource;
					private «type("java.sql.Connection")» connection;
				
					public DefaultLazyConnection(«type("javax.sql.DataSource")» dataSource) {
					super();
						this.dataSource = dataSource;
					}
				
					@Override
					public «type("java.sql.Connection")» get() {
						if (this.connection == null) {
							try {
								this.connection = this.dataSource.getConnection();
							} catch («type("java.sql.SQLException")» e) {
								throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
							}
						}
						return this.connection;
					}
				}
			'''
		]
	}

}
