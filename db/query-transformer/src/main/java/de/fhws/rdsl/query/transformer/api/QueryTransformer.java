package de.fhws.rdsl.query.transformer.api;

import java.io.IOException;
import java.util.Map;

public interface QueryTransformer {

    Map<String, Object> transform(QueryTransformerParameters parameterObject) throws IOException;

}
