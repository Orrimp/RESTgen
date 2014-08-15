package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.IntegerElement;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class DoubleFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof IntegerElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        return ((IntegerElement) element).getValue().toString();
    }

}
