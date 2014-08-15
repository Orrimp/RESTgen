package de.fhws.rdsl.querylang.solr.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.PropertyElement;
import de.fhws.rdsl.querylang.formatter.Formatter;

public class PropertyFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof PropertyElement;
    }

    @Override
    public String format(Element element, TransformerContext context) {
        PropertyElement propertyElement = (PropertyElement) element;
        return Joiner.on('_').join(propertyElement.getProperty().getPath());

    }

}
