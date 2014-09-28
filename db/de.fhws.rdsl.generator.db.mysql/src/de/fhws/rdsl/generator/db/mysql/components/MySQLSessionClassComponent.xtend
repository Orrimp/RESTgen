package de.fhws.rdsl.generator.db.mysql.components


import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class MySQLSessionClassComponent extends AbstractComponent implements MySQLConfigurationKeys {
	
	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg

	override protected createJavaClass() {
		return new JavaClass => [
			name = "MySQLSession"
			pckg = dbMySqlPckg
			content = '''
				public class MySQLSession extends «type(dbMySqlPckg, "SQLSession")» {
				
					public MySQLSession(«type(dbMySqlPckg, "LazyConnection")» connection) {
						super(connection);
					}
				
					@Override
					protected void handleSQLException(«type("java.sql.SQLException")» t) {
						if (t.getErrorCode() == 1062) {
							throw new «type(commonDbExceptionsPckg, "DuplicateDataException")»(t);
						} else if (t.getErrorCode() == 1451) {
							throw new «type(commonDbExceptionsPckg, "ConstraintException")»(t);
						} else if ("45000".equals(t.getSQLState())) {
							throw new «type(commonDbExceptionsPckg, "ConcurrencyException")»(t);
						} else if ("46000".equals(t.getSQLState())) {
							throw new «type(commonDbExceptionsPckg, "OneToManyConstraintException")»(t);
						} else if ("47000".equals(t.getSQLState())) {
							throw new «type(commonDbExceptionsPckg, "OneToOneConstraintException")»(t);
						}
					}
				
				}
			'''
		]
	}

}
