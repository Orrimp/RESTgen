package de.fhws.rdsl.query.transformer.spi;

import java.util.Map;

import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public interface ElementTransformer {

    Map<String, Object> transform(TargetElement element, TransformerContext context);

}
