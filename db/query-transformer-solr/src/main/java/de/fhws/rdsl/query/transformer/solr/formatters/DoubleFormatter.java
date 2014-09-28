package de.fhws.rdsl.query.transformer.solr.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.DoubleElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class DoubleFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof DoubleElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        return ((DoubleElement) element).getValue().toString();
    }

}
