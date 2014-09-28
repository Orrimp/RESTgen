package de.fhws.rdsl.query.transformer.spi.target;

import de.fhws.rdsl.query.transformer.spi.Property;
import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;

public class PropertyElement extends ExpressionElement {
    private Property property;

    public PropertyElement(Property property) {
        super();
        this.property = property;
    }

    public Property getProperty() {
        return this.property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }
}