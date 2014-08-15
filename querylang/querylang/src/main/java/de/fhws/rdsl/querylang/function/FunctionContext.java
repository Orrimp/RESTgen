package de.fhws.rdsl.querylang.function;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.parser.Node;

public interface FunctionContext {

    TransformerContext getTransformerContext();

    Element createElement(Node node);

}
