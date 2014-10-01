package de.fhws.rdsl.query.transformer.spi.target;

public abstract class ValueElement<T> extends ExpressionElement {
    private T value;

    public ValueElement(T value) {
        super();
        this.value = value;
    }

    public T getValue() {
        return this.value;
    }

    public void setValue(T value) {
        this.value = value;
    }

}