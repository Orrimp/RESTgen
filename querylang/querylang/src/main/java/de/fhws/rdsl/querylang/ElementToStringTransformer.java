package de.fhws.rdsl.querylang;


public interface ElementToStringTransformer {

    String getString(Element element, ElementToStringTransformerContext context);

}
