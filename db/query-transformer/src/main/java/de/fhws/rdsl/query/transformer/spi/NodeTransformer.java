package de.fhws.rdsl.query.transformer.spi;

import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public interface NodeTransformer {

    TargetElement transform(SourceNode node, TransformerContext context);

}