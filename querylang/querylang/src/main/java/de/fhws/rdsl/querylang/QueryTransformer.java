package de.fhws.rdsl.querylang;

import java.io.IOException;
import java.util.Map;

import de.fhws.rdsl.querylang.schema.Schema;

public interface QueryTransformer {

    Map<String, Object> transform(Query query, String typeName, Schema schema, Map<String, String> parameters) throws IOException;

}
