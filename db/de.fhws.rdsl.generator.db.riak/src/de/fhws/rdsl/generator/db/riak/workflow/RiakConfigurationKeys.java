package de.fhws.rdsl.generator.db.riak.workflow;

import de.fhws.rdsl.generator.db.workflow.ConfigurationKeys;

public interface RiakConfigurationKeys extends ConfigurationKeys {

	public static final String DB_RIAK_CONVERTERS_PACKAGE = "dbRiakConvertersPackage";
	public static final String DB_RIAK_PACKAGE = "dbRiakPackage";
	public static final String DB_RIAK_RESOURCES_PACKAGE = "dbRiakResourcesPackage";
	public static final String DB_RIAK_TEST_PACKAGE = "dbRiakTestPackage";

	// Riak Configuration
	public static final String RIAK_USE_WHITESPACE_ANALYZER = "riakUseWhitespaceAnalyzer";

}
