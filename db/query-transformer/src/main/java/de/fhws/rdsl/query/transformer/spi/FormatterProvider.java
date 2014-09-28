package de.fhws.rdsl.query.transformer.spi;

import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public interface FormatterProvider {

    Formatter getFormatter(TargetElement element);

    void registerFormatter(Formatter formatter);

}
