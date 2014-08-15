package de.fhws.rdsl.querylang.solr;

import de.fhws.rdsl.querylang.formatter.DefaultFormatterProvider;
import de.fhws.rdsl.querylang.solr.formatters.BooleanElementFormatter;
import de.fhws.rdsl.querylang.solr.formatters.DoubleFormatter;
import de.fhws.rdsl.querylang.solr.formatters.EqualsFormatter;
import de.fhws.rdsl.querylang.solr.formatters.IntegerFormatter;
import de.fhws.rdsl.querylang.solr.formatters.JunctionFormatter;
import de.fhws.rdsl.querylang.solr.formatters.NullFormatter;
import de.fhws.rdsl.querylang.solr.formatters.PropertyFormatter;
import de.fhws.rdsl.querylang.solr.formatters.QueryElementFormatter;
import de.fhws.rdsl.querylang.solr.formatters.StringFormatter;

public class SolrFormatterProvider extends DefaultFormatterProvider {

    public SolrFormatterProvider() {
        registerFormatter(new BooleanElementFormatter());
        registerFormatter(new DoubleFormatter());
        registerFormatter(new IntegerFormatter());
        registerFormatter(new NullFormatter());
        registerFormatter(new StringFormatter());
        registerFormatter(new EqualsFormatter());
        registerFormatter(new JunctionFormatter());
        registerFormatter(new PropertyFormatter());
        registerFormatter(new QueryElementFormatter());
    }

}
