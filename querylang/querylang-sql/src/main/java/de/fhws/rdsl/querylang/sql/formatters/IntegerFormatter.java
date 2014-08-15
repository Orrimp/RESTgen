package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.DoubleElement;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class IntegerFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof DoubleElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        return ((DoubleElement) element).getValue().toString();
    }

}