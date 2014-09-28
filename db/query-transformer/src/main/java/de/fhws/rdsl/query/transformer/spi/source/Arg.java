package de.fhws.rdsl.query.transformer.spi.source;

import java.util.Collections;
import java.util.List;

public class Arg<T> extends SourceNode {

    private T value;

    public Arg(T value) {
        super();
        this.value = value;
    }

    public T getValue() {
        return this.value;
    }

    public void setValue(T value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return getClass().getSimpleName() + ": [value: " + this.value + "]";
    }

    @Override
    public List<SourceNode> getChildren() {
        return Collections.emptyList();
    }

}
