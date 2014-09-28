package de.fhws.rdsl.query.transformer.solr.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.IntegerElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class IntegerFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof IntegerElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        return ((IntegerElement) element).getValue().toString();
    }

}
