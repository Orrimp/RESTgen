package de.fhws.rdsl.querylang.solr.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.NullElement;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class NullFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof NullElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        return "null";
    }

}
