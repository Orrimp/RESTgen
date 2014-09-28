package de.fhws.rdsl.generator.db.mysql.components

import java.util.List
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject

class MySQLTestSuiteClassComponent extends AbstractComponent implements MySQLConfigurationKeys {
	
	@Inject @Named(DB_MYSQL_TEST_PACKAGE) protected String dbMySqlTestPckg

	override protected createJavaClass() {

		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "MySQLTestSuite"
			pckg = dbMySqlTestPckg
			content = '''

			@org.junit.runner.RunWith(MySQLTestSuiteRunner.class)
			@org.junit.runners.Suite.SuiteClasses({ «FOR table : tables SEPARATOR ', '»«type(dbTestPckg, table.name + "Test")».class«ENDFOR» })
			public class «name» {
			
			}

			'''
		]
	}

}
