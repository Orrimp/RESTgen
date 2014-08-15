package de.fhws.rdsl.querylang.function;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.parser.Node;

public interface FunctionContext {

    Element getElement(Node node);

}
