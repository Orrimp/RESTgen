package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.BooleanElement;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class BooleanElementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof BooleanElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        return ((BooleanElement) element).getValue().toString();
    }

}
