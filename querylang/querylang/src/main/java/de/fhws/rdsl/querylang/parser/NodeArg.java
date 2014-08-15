package de.fhws.rdsl.querylang.parser;

import java.util.Collections;
import java.util.List;

public class NodeArg extends Arg<Node> {

    public NodeArg(Node value) {
        super(value);
    }

    @Override
    public List<Node> getChildren() {
        return Collections.singletonList(getValue());
    }

}
