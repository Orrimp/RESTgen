package de.fhws.rdsl.querylang.parser;

import java.util.ArrayList;
import java.util.List;

public class Junction extends Node {

    public static final int OR = 0;
    public static final int AND = 1;

    public Junction(int type) {
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

    @Override
    public String toString() {
        return getClass().getSimpleName() + ": [type: " + this.type + ", children: " + this.children + "]";
    }

}
