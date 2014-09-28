package de.fhws.rdsl.query.transformer.solr;

import de.fhws.rdsl.query.transformer.solr.formatters.BooleanElementFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.DoubleFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.EqualsFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.IntegerFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.JunctionFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.NullFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.PropertyFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.QueryElementFormatter;
import de.fhws.rdsl.query.transformer.solr.formatters.StringFormatter;
import de.fhws.rdsl.query.transformer.spi.DefaultFormatterProvider;

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
