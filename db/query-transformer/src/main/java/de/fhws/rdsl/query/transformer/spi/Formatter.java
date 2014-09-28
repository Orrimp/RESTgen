package de.fhws.rdsl.query.transformer.spi;

import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public interface Formatter {

    boolean isFormatterFor(TargetElement element);

    String format(TargetElement element, TransformerContext context);

}
