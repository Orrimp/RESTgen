package de.fhws.rdsl.query.transformer.api;

import java.util.Map;

import de.fhws.rdsl.query.Query;
import de.fhws.rdsl.query.transformer.api.schema.Schema;

public class QueryTransformerParameters {
	public Query query;
	public String typeName;
	public Schema schema;
	public Map<String, String> parameters;

	public QueryTransformerParameters(Query query, String typeName, Schema schema, Map<String, String> parameters) {
		this.query = query;
		this.typeName = typeName;
		this.schema = schema;
		this.parameters = parameters;
	}

	public Query getQuery() {
		return this.query;
	}

	public Schema getSchema() {
		return this.schema;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public Map<String, String> getParameters() {
		return this.parameters;
	}
}