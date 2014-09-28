package de.fhws.rdsl.query.transformer.sql.elements;

import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class OrderElement extends TargetElement {

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
