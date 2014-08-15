package de.fhws.rdsl.querylang.sql.elements;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.PropertyElement;

public class OrderElement extends Element {

    private boolean desc;
    private PropertyElement property;

    public PropertyElement getProperty() {
        return this.property;
    }

    public void setProperty(PropertyElement property) {
        this.property = property;
    }

    public boolean isDesc() {
        return this.desc;
    }

    public void setDesc(boolean desc) {
        this.desc = desc;
    }

}
