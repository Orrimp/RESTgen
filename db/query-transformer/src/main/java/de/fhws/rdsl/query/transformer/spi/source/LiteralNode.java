package de.fhws.rdsl.query.transformer.spi.source;

import java.util.Collections;
import java.util.List;

public abstract class LiteralNode<T> extends SourceNode {

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
    public List<SourceNode> getChildren() {
        return Collections.emptyList();
    }

}
