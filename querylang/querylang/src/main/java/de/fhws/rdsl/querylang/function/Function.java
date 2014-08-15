package de.fhws.rdsl.querylang.function;

import java.util.List;

import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.parser.Node;

public interface Function {

    Element createElement(Property property, List<Node> args, FunctionContext context);

    FunctionDescription getDescription();

}
