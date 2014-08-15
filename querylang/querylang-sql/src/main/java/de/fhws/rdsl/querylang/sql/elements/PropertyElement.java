package de.fhws.rdsl.querylang.sql.elements;

import de.fhws.rdsl.querylang.Property;

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