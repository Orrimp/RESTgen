package de.fhws.rdsl.query.transformer.solr;

import de.fhws.rdsl.query.transformer.solr.functions.EqualsFunction;
import de.fhws.rdsl.query.transformer.spi.DefaultFunctionProvider;

public class SolrFunctionProvider extends DefaultFunctionProvider {

    public SolrFunctionProvider() {
        registerFunction(new EqualsFunction());
    }

}
