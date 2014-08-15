package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.sql.elements.OrderElement;

public class OrderFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof OrderElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        OrderElement orderElement = (OrderElement) element;
        return "order by " + context.format(orderElement.getProperty()) + " " + (orderElement.isDesc() ? "desc" : "asc");
    }

}
