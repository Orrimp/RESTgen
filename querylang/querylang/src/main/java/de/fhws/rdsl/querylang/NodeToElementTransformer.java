package de.fhws.rdsl.querylang;

import de.fhws.rdsl.querylang.parser.Node;

public interface NodeToElementTransformer {

    Element getElement(Node node, NodeToElementTransformerContext context);

}