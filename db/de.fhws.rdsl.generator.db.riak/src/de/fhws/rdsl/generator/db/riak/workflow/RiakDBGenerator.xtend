package de.fhws.rdsl.generator.db.riak.workflow

import de.fhws.rdsl.generator.db.workflow.DBGenerator
import java.util.List
import de.fhws.rdsl.workflow.Component
import com.google.inject.Binder
import com.google.inject.name.Names
import de.fhws.rdsl.generator.db.riak.components.LocalRiakTestSuiteRunnerClassComponent
import de.fhws.rdsl.generator.db.riak.components.LocalRiakTestSuiteClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakSchemaFilesComponent
import de.fhws.rdsl.generator.db.riak.components.ToJSONObjectConverterClassesComponent
import de.fhws.rdsl.generator.db.riak.components.ToJSONObjectConverterClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakSessionClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakQueryServiceClassComponent
import de.fhws.rdsl.generator.db.riak.components.FromJSONObjectConverterClassesComponent
import de.fhws.rdsl.generator.db.riak.components.FromJSONObjectConverterClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakSessionFactoryClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakTestSuiteRunnerClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakTestSuiteClassComponent
import de.fhws.rdsl.generator.db.riak.components.RiakQueryTransformerProviderClassComponent
import de.fhws.rdsl.rdsl.Configuration
import de.fhws.rdsl.rdsl.RiakConfiguration
import de.fhws.rdsl.generator.db.riak.components.RiakScriptFileComponent

class RiakDBGenerator extends DBGenerator implements RiakConfigurationKeys {
	
	override isGeneratorFor(Configuration configuration) {
		return configuration.databaseConfiguration instanceof RiakConfiguration
	}

	override protected getMoreComponents() {
		var List<Class<? extends Component>> components = newArrayList

		components += FromJSONObjectConverterClassComponent
		components += FromJSONObjectConverterClassesComponent
		components += RiakQueryServiceClassComponent
		components += RiakSessionClassComponent
		components += RiakSessionFactoryClassComponent
		components += ToJSONObjectConverterClassComponent
		components += ToJSONObjectConverterClassesComponent
		components += RiakSchemaFilesComponent
		components += RiakScriptFileComponent
		components += RiakQueryTransformerProviderClassComponent

		// Test
		components += LocalRiakTestSuiteClassComponent
		components += LocalRiakTestSuiteRunnerClassComponent
		components += RiakTestSuiteRunnerClassComponent
		components += RiakTestSuiteClassComponent

		return components
	}

	override protected bindMore(Binder binder, String basePackage) {
		bindString(binder, DB_RIAK_PACKAGE, basePackage + ".db.impl.riak")
		bindString(binder, DB_RIAK_RESOURCES_PACKAGE, basePackage + ".db.res.impl.riak")
		bindString(binder, DB_RIAK_CONVERTERS_PACKAGE, basePackage + ".db.impl.riak.converters")
		bindString(binder, DB_RIAK_TEST_PACKAGE, basePackage + ".db.test.impl.riak")
		binder.bind(Boolean).annotatedWith(Names.named(RIAK_USE_WHITESPACE_ANALYZER)).toInstance(Boolean.TRUE)
	}

}
