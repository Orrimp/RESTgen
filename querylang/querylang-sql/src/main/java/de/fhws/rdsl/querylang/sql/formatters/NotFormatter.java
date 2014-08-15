package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.sql.elements.NotElement;

public class NotFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof NotElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        NotElement notElement = (NotElement) element;
        return "not (" + context.format(notElement.getExpression()) + ")";
    }

}
