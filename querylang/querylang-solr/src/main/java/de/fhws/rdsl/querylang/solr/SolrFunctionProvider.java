package de.fhws.rdsl.querylang.solr;

import de.fhws.rdsl.querylang.function.DefaultFunctionProvider;
import de.fhws.rdsl.querylang.solr.functions.EqualsFunction;

public class SolrFunctionProvider extends DefaultFunctionProvider {

    public SolrFunctionProvider() {
        registerFunction(new EqualsFunction());
    }

}
