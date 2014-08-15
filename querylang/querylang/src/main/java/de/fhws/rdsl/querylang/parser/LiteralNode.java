package de.fhws.rdsl.querylang.parser;

import java.util.Collections;
import java.util.List;

public abstract class LiteralNode<T> extends Node {

    private T value;

    public LiteralNode(T value) {
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
    public List<Node> getChildren() {
        return Collections.emptyList();
    }

}
