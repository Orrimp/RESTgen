package de.fhws.rdsl.querylang.formatter;

import de.fhws.rdsl.querylang.Element;

public interface Formatter {

    boolean isFormatterFor(Element element);

    String format(Element element, FormatterContext context);

}
