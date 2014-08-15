package de.fhws.rdsl.querylang.solr.elements;

import de.fhws.rdsl.querylang.elements.ExpressionElement;
import de.fhws.rdsl.querylang.elements.PropertyElement;

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
