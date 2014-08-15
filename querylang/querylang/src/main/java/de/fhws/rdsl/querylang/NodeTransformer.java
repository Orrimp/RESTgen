package de.fhws.rdsl.querylang;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.parser.Node;

public interface NodeTransformer {

    Element transform(Node node, TransformerContext context);

}