package de.fhws.rdsl.query.transformer.sql.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.BooleanElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class BooleanElementFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof BooleanElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        return ((BooleanElement) element).getValue().toString();
    }

}
