package de.fhws.rdsl.querylang;

import java.util.Map;

import de.fhws.rdsl.querylang.elements.Element;

public interface ElementTransformer {

    Map<String, Object> transform(Element element, TransformerContext context);

}
