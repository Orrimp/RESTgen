package de.fhws.rdsl.querylang.parser;

import java.util.ArrayList;
import java.util.List;

public class JunctionNode extends Node {

    public static final int OR = 0;
    public static final int AND = 1;

    public JunctionNode(int type) {
        super();
        this.type = type;
    }

    private int type;
    private List<Node> children = new ArrayList<Node>();

    public int getType() {
        return this.type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Override
    public List<Node> getChildren() {
        return this.children;
    }

}
