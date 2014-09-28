package de.fhws.rdsl.query.transformer.solr.formatters;

import java.net.URLEncoder;

import de.fhws.rdsl.query.transformer.solr.elements.QueryElement;
import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class QueryElementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof QueryElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        QueryElement queryElement = (QueryElement) element;
        String str = "q=" + URLEncoder.encode(context.format(queryElement.getQuery()));
        if (queryElement.getStart() != null) {
            str += "&start=" + queryElement.getStart();
        }
        if (queryElement.getOffset() != null) {
            str += "&rows=" + queryElement.getOffset();
        }
        return str;
    }

}
