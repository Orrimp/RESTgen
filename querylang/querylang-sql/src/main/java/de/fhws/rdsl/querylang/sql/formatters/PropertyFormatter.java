package de.fhws.rdsl.querylang.sql.formatters;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterContext;
import de.fhws.rdsl.querylang.sql.elements.PropertyElement;

public class PropertyFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(Element element) {
        return element instanceof PropertyElement;
    }

    @Override
    public String format(Element element, FormatterContext context) {
        PropertyElement propertyElement = (PropertyElement) element;
        Property prop = propertyElement.getProperty();
        if (prop.getNamespace() == null) {
            return "`" + prop.getName() + "`";
        } else {
            return "`" + prop.getNamespace() + "`.`" + prop.getName() + "`";
        }
    }

}
