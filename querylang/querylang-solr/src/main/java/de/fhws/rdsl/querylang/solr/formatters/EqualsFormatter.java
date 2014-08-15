package de.fhws.rdsl.querylang.solr.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.solr.elements.EqualsElement;

public class EqualsFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof EqualsElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        EqualsElement equalsElement = (EqualsElement) element;
        return context.format(equalsElement.getProperty()) + ":" + context.format(equalsElement.getValue());
    }

}
