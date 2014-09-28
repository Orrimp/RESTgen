package de.fhws.rdsl.query.transformer.sql.formatters;

import com.google.common.base.Joiner;

import de.fhws.rdsl.query.transformer.spi.Formatter;
import de.fhws.rdsl.query.transformer.spi.Property;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class PropertyFormatter implements Formatter {

    @Override
    public boolean isFormatterFor(TargetElement element) {
        return element instanceof PropertyElement;
    }

    @Override
    public String format(TargetElement element, TransformerContext context) {
        PropertyElement propertyElement = (PropertyElement) element;
        Property prop = propertyElement.getProperty();
        return Joiner.on('.').join(prop.getPath().stream().map(name -> "`" + name + "`").iterator());
    }

}
