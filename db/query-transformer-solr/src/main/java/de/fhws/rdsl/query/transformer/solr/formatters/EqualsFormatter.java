package de.fhws.rdsl.query.transformer.solr.formatters;

import de.fhws.rdsl.query.transformer.solr.elements.EqualsElement;
import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class EqualsFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof EqualsElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        EqualsElement equalsElement = (EqualsElement) element;
        return context.format(equalsElement.getProperty()) + ":" + context.format(equalsElement.getValue());
    }

}
