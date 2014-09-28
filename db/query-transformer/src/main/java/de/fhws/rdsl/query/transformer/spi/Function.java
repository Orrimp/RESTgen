package de.fhws.rdsl.query.transformer.spi;

import java.util.List;

import de.fhws.rdsl.query.FunctionDescription;
import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public interface Function {

    TargetElement createElement(Property property, List<SourceNode> args, FunctionContext context);

    FunctionDescription getDescription();

}
