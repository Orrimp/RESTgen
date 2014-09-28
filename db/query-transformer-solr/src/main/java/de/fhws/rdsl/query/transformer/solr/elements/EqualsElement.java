package de.fhws.rdsl.query.transformer.solr.elements;

import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;

public class EqualsElement extends ExpressionElement {

    private PropertyElement property;
    private ExpressionElement value;

    public PropertyElement getProperty() {
        return this.property;
    }

    public ExpressionElement getValue() {
        return this.value;
    }

    public void setProperty(PropertyElement property) {
        this.property = property;
    }

    public void setValue(ExpressionElement value) {
        this.value = value;
    }

}
