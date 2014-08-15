package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.BooleanElement;

public class BooleanElementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof BooleanElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        return ((BooleanElement) element).getValue().toString();
    }

}
