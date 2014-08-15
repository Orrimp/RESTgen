package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.StringElement;

public class StringFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof StringElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        return "\"" + ((StringElement) element).getValue().toString() + "\"";
    }

}
