package de.fhws.rdsl.query.transformer.spi.source;

import java.util.ArrayList;
import java.util.List;

public class JunctionNode extends SourceNode {

    public static final int OR = 0;
    public static final int AND = 1;

    public JunctionNode(int type) {
        super();
        this.type = type;
    }

    private int type;
    private List<SourceNode> children = new ArrayList<SourceNode>();

    public int getType() {
        return this.type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Override
    public List<SourceNode> getChildren() {
        return this.children;
    }

}
