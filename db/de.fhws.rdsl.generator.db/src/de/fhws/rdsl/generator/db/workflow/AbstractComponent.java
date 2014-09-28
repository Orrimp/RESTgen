package de.fhws.rdsl.generator.db.workflow;

import javax.inject.Inject;
import javax.inject.Named;

import de.fhws.rdsl.workflow.Context;
import de.fhws.rdsl.workflow.JavaClassComponent;

public abstract class AbstractComponent extends JavaClassComponent implements ContextKeys, ConfigurationKeys {

	@Inject
	protected Context ctx;

	@Inject
	@Named(COMMON_DB_DATA_PACKAGE)
	protected String commonDbDataPckg;

	@Inject
	@Named(COMMON_DB_PACKAGE)
	protected String commonDbPckg;

	@Inject
	@Named(COMMON_DB_EXCEPTIONS_PACKAGE)
	protected String commonDbExceptionsPckg;

	@Inject
	@Named(DB_SPI_PACKAGE)
	protected String dbSpiPckg;

	@Inject
	@Named(DB_PACKAGE)
	protected String dbPckg;

	@Inject
	@Named(DB_TEST_PACKAGE)
	protected String dbTestPckg;

}
