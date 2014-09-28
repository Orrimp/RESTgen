package de.fhws.rdsl.generator.db.mysql.workflow

import de.fhws.rdsl.generator.db.workflow.DBGenerator
import java.util.List
import de.fhws.rdsl.workflow.Component
import com.google.inject.Binder
import de.fhws.rdsl.generator.db.mysql.components.DefaultLazyConnectionClassComponent
import de.fhws.rdsl.generator.db.mysql.components.LazyConnectionClassComponent
import de.fhws.rdsl.generator.db.mysql.components.MySQLScriptComponent
import de.fhws.rdsl.generator.db.mysql.components.MySQLSessionClassComponent
import de.fhws.rdsl.generator.db.mysql.components.MySQLSessionFactoryClassComponent
import de.fhws.rdsl.generator.db.mysql.components.ResultSetConverterClassComponent
import de.fhws.rdsl.generator.db.mysql.components.ResultSetConverterClassesComponent
import de.fhws.rdsl.generator.db.mysql.components.SQLQueryServiceClassComponent
import de.fhws.rdsl.generator.db.mysql.components.SQLSessionClassComponent
import de.fhws.rdsl.generator.db.mysql.components.MySQLTestSuiteClassComponent
import de.fhws.rdsl.generator.db.mysql.components.MySQLTestSuiteRunnerClassComponent
import de.fhws.rdsl.rdsl.Configuration
import de.fhws.rdsl.rdsl.MySQLConfiguration
import de.fhws.rdsl.generator.db.mysql.components.MySQLQueryTransformerProviderClassComponent

class MySQLDBGenerator extends DBGenerator implements MySQLConfigurationKeys {
	
	
	override isGeneratorFor(Configuration configuration) {
		return configuration.databaseConfiguration instanceof MySQLConfiguration
	}

	override protected getMoreComponents() {
		var List<Class<? extends Component>> components = newArrayList

		components += DefaultLazyConnectionClassComponent
		components += LazyConnectionClassComponent
		components += MySQLScriptComponent
		components += MySQLSessionClassComponent
		components += MySQLSessionFactoryClassComponent
		components += ResultSetConverterClassComponent
		components += ResultSetConverterClassesComponent
		components += SQLQueryServiceClassComponent
		components += SQLSessionClassComponent
		components += MySQLQueryTransformerProviderClassComponent

		// Test
		components += MySQLTestSuiteClassComponent
		components += MySQLTestSuiteRunnerClassComponent

		return components
	}

	override protected bindMore(Binder binder, String basePackage) {
		bindString(binder, DB_MYSQL_PACKAGE, basePackage + ".db.impl.mysql")
		bindString(binder, DB_MYSQL_CONVERTERS_PACKAGE, basePackage + ".db.impl.mysql.converters")
		bindString(binder, DB_MYSQL_TEST_PACKAGE, basePackage + ".db.test.impl.mysql")
		bindString(binder, DB_MYSQL_RESOURCE_PACKAGE, basePackage + ".db.res.impl.mysql")
	}

}
