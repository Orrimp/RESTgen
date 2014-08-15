package de.fhws.rdsl.querylang.solr.formatters;

import java.net.URLEncoder;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.solr.elements.QueryElement;

public class QueryElementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof QueryElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
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
