package de.fhws.rdsl.query.transformer.spi.target;

import java.util.Collections;
import java.util.List;

import com.google.common.collect.Lists;

public class JunctionElement extends ExpressionElement {

    public static final int OR = 0;
    public static final int AND = 1;

    private int type;
    private List<TargetElement> elements = Lists.newArrayList();

    public JunctionElement(int type, TargetElement... elements) {
        super();
        this.type = type;
        Collections.addAll(this.elements, elements);
    }

    public int getType() {
        return this.type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public List<TargetElement> getChildren() {
        return this.elements;
    }

}
