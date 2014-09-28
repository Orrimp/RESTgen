package de.fhws.rdsl.query.transformer.sql.formatters;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.NotElement;

public class NotFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof NotElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        NotElement notElement = (NotElement) element;
        return "not (" + context.format(notElement.getExpression()) + ")";
    }

}
