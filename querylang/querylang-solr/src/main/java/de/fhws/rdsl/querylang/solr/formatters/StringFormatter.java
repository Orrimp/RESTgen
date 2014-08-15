package de.fhws.rdsl.querylang.solr.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.StringElement;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class StringFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof StringElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        return "\"" + ((StringElement) element).getValue().toString() + "\"";
    }

}
