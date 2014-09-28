package de.fhws.rdsl.generator.db.workflow

import com.google.inject.AbstractModule
import com.google.inject.Binder
import com.google.inject.Guice
import com.google.inject.name.Names
import de.fhws.rdsl.generator.db.components.FilesComponent
import de.fhws.rdsl.generator.db.components.TablesComponent
import de.fhws.rdsl.generator.db.components.api.DataClassComponent
import de.fhws.rdsl.generator.db.components.api.DataClassesComponent
import de.fhws.rdsl.generator.db.components.api.DatabaseExceptionClassesComponent
import de.fhws.rdsl.generator.db.components.api.DefaultReferenceIdentifierClassComponent
import de.fhws.rdsl.generator.db.components.api.DefaultResourceIdentifierClassComponent
import de.fhws.rdsl.generator.db.components.api.IdentifierClassComponent
import de.fhws.rdsl.generator.db.components.api.IdentifierGeneratorClassComponent
import de.fhws.rdsl.generator.db.components.api.LocksClassComponent
import de.fhws.rdsl.generator.db.components.api.QueryPathClassComponent
import de.fhws.rdsl.generator.db.components.api.QueryResultClassComponent
import de.fhws.rdsl.generator.db.components.api.QueryServiceClassComponent
import de.fhws.rdsl.generator.db.components.api.QuerySpecificationClassComponent
import de.fhws.rdsl.generator.db.components.api.ReferenceDataClassComponent
import de.fhws.rdsl.generator.db.components.api.ReferenceIdentifierClassComponent
import de.fhws.rdsl.generator.db.components.api.ResourceDataClassComponent
import de.fhws.rdsl.generator.db.components.api.ResourceIdentifierClassComponent
import de.fhws.rdsl.generator.db.components.api.RevisionGeneratorClassComponent
import de.fhws.rdsl.generator.db.components.api.SessionClassComponent
import de.fhws.rdsl.generator.db.components.api.SessionFactoryClassComponent
import de.fhws.rdsl.generator.db.components.api.VersionedClassComponent
import de.fhws.rdsl.generator.db.components.impl.ConverterClassComponent
import de.fhws.rdsl.generator.db.components.impl.DefaultSchemaClassComponent
import de.fhws.rdsl.generator.db.components.impl.ThrowingConsumerClassComponent
import de.fhws.rdsl.generator.db.components.impl.ThrowingFunctionClassComponent
import de.fhws.rdsl.generator.db.components.spi.CacheClassComponent
import de.fhws.rdsl.generator.db.components.spi.DistributedLockClassComponent
import de.fhws.rdsl.generator.db.components.spi.QueryTransformerProviderClassComponent
import de.fhws.rdsl.generator.db.components.test.AbstractSessionTestClassComponent
import de.fhws.rdsl.generator.db.components.test.GuiceRunnerBuilderClassComponent
import de.fhws.rdsl.generator.db.components.test.TestClassesComponent
import de.fhws.rdsl.rdsl.Configuration
import de.fhws.rdsl.rdsl.DatabaseConfiguration
import de.fhws.rdsl.rdsl.Package
import de.fhws.rdsl.workflow.Component
import de.fhws.rdsl.workflow.ComponentsProvider
import de.fhws.rdsl.workflow.Context
import de.fhws.rdsl.workflow.FileSystemAccess
import de.fhws.rdsl.workflow.JavaClassHelper
import de.fhws.rdsl.workflow.Workflow
import java.util.Collections
import java.util.List
import javax.inject.Singleton

import static de.fhws.rdsl.generator.db.workflow.ConfigurationKeys.*

class DBGenerator implements ComponentsProvider, Component {

	@Property Package pckg
	@Property Configuration configuration
	@Property FileSystemAccess fileSystemAccess

	val List<Component> components = newArrayList
	
	def boolean isGeneratorFor(Configuration configuration) {
		return false
	}

	def override run() {

		val types = newArrayList()
		types += getComponents(configuration.databaseConfiguration)

		val injector = Guice.createInjector(getModule())

		types.forEach [ type |
			components += injector.getInstance(type)
		]

		injector.getInstance(Workflow).run

	}

	def getModule() {
		return new AbstractModule() {
			override protected configure() {

				val basePackage = configuration.package

				// Packages
				bindString(binder, COMMON_DB_PACKAGE, basePackage + ".db.api")
				bindString(binder, COMMON_DB_DATA_PACKAGE, basePackage + ".db.api.data")
				bindString(binder, COMMON_DB_EXCEPTIONS_PACKAGE, basePackage + ".db.api.exceptions")
				bindString(binder, DB_PACKAGE, basePackage + ".db.impl")
				bindString(binder, DB_TEST_PACKAGE, basePackage + ".db.test")
				bindString(binder, DB_SPI_PACKAGE, basePackage + ".db.spi")
				
				bindMore(binder, basePackage)

				// Configuration
				
				bind(Boolean).annotatedWith(Names.named(USE_SEQUENCES)).toInstance(Boolean.FALSE)
				bindString(binder, TEST_CONNECTION_FILE, configuration.databaseConfiguration.testConnectionFile)

				// Services
				bind(Context).in(Singleton)
				bind(FileSystemAccess).toInstance(fileSystemAccess)
				bind(JavaClassHelper)
				bind(Package).toInstance(pckg)
				bind(Configuration).toInstance(configuration)
				bind(ComponentsProvider).toInstance(DBGenerator.this)

			}
		}
	}

	def protected void bindMore(Binder binder, String basePackage) {
		// Nothing
	}

	def protected void bindString(Binder binder, String key, String name) {
		binder.bind(String).annotatedWith(Names.named(key)).toInstance(name)
	}

	def protected List<Class<? extends Component>> getMoreComponents() {
		return Collections.emptyList
	}

	def private List<Class<? extends Component>> getComponents(DatabaseConfiguration configuration) {
		var List<Class<? extends Component>> components = newArrayList

		// First
		components += TablesComponent

		components += DatabaseExceptionClassesComponent
		components += DataClassComponent
		components += DataClassesComponent
		components += DefaultReferenceIdentifierClassComponent
		components += DefaultResourceIdentifierClassComponent
		components += IdentifierClassComponent
		components += IdentifierGeneratorClassComponent
		components += LocksClassComponent
		components += QueryPathClassComponent
		components += QueryResultClassComponent
		components += QueryServiceClassComponent
		components += QuerySpecificationClassComponent
		components += ReferenceDataClassComponent
		components += ResourceIdentifierClassComponent
		components += ReferenceIdentifierClassComponent
		components += ResourceDataClassComponent
		components += RevisionGeneratorClassComponent
		components += SessionClassComponent
		components += SessionFactoryClassComponent
		components += VersionedClassComponent
		components += ConverterClassComponent
		components += DefaultSchemaClassComponent
		components += ThrowingConsumerClassComponent
		components += ThrowingFunctionClassComponent

		// SPI
		components += CacheClassComponent
		components += DistributedLockClassComponent
		components += QueryTransformerProviderClassComponent

		// Test
		components += AbstractSessionTestClassComponent
		components += GuiceRunnerBuilderClassComponent
		components += TestClassesComponent

		components += moreComponents

		// Last
		components += FilesComponent

		return components
	}

	override get() {
		components
	}

}
