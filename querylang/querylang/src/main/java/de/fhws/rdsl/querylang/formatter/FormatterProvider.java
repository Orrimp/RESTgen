package de.fhws.rdsl.querylang.formatter;

import de.fhws.rdsl.querylang.elements.Element;

public interface FormatterProvider {

    Formatter getFormatter(Element element);

    void registerFormatter(Formatter formatter);

}
