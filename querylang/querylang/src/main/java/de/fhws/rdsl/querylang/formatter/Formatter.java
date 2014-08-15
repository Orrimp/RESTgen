package de.fhws.rdsl.querylang.formatter;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;

public interface Formatter {

    boolean isFormatterFor(Element element);

    String format(Element element, TransformerContext context);

}
