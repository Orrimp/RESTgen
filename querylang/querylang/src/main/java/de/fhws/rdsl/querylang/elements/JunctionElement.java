package de.fhws.rdsl.querylang.elements;

import java.util.Collections;
import java.util.List;

import com.google.common.collect.Lists;

public class JunctionElement extends ExpressionElement {

    public static final int OR = 0;
    public static final int AND = 1;

    private int type;
    private List<Element> elements = Lists.newArrayList();

    public JunctionElement(int type, Element... elements) {
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

    public List<Element> getChildren() {
        return this.elements;
    }

}
