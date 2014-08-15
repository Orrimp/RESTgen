package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.DoubleElement;

public class IntegerFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof DoubleElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        return ((DoubleElement) element).getValue().toString();
    }

}
