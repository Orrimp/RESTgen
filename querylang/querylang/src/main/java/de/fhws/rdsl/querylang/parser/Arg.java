package de.fhws.rdsl.querylang.parser;

import java.util.Collections;
import java.util.List;

public class Arg<T> extends Node {

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
    public List<Node> getChildren() {
        return Collections.emptyList();
    }

}
