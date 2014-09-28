package de.fhws.rdsl.query.transformer.sql.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.OrderElement;

public class OrderFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof OrderElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        OrderElement orderElement = (OrderElement) element;
        return "order by " + context.format(orderElement.getProperty()) + " " + (orderElement.isDesc() ? "desc" : "asc");
    }

}
