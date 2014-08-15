package de.fhws.rdsl.querylang.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Element;

public class JunctionElement extends Element {

    public static final int OR = 0;
    public static final int AND = 1;

    private int type;

    private List<Element> children = Lists.newArrayList();

    public List<Element> getChildren() {
        return this.children;
    }

    public int getType() {
        return this.type;
    }

    public void setType(int type) {
        this.type = type;
    }

}