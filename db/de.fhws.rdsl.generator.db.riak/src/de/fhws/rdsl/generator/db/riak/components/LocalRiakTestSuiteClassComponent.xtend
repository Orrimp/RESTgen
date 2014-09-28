package de.fhws.rdsl.generator.db.riak.components

import java.util.List
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.Table
import javax.inject.Inject
import javax.inject.Named
import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys

class LocalRiakTestSuiteClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_TEST_PACKAGE) protected String dbRiakTestPckg

	override protected createJavaClass() {

		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "LocalRiakTestSuite"
			pckg = dbRiakTestPckg
			content = '''
				
				@org.junit.runner.RunWith(LocalRiakTestSuiteRunner.class)
				@org.junit.runners.Suite.SuiteClasses({ «FOR table : tables SEPARATOR ', '»«type(dbTestPckg, table.name + "Test")».class«ENDFOR» })
				public class «name» {
				
				}
				
			'''
		]
	}

}
