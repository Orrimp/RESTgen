package de.fhws.rdsl.query.transformer.sql.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.EqualsElement;

public class EqualsFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof EqualsElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        EqualsElement equalsElement = (EqualsElement) element;
        return "(" + context.format(equalsElement.getLeft()) + " = " + context.format(equalsElement.getRight()) + ")";
    }
}
