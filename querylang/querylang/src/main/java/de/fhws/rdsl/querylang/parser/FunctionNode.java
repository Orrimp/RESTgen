package de.fhws.rdsl.querylang.parser;

import java.util.ArrayList;
import java.util.List;

import com.google.common.collect.Lists;

public class FunctionNode extends Node {

    private List<String> path = new ArrayList<String>();
    private String name;
    private List<Node> args = new ArrayList<Node>();

    public List<Node> getArgs() {
        return this.args;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String method) {
        this.name = method;
    }

    public List<String> getPath() {
        return this.path;
    }

    @Override
    public List<Node> getChildren() {
        return Lists.newArrayList(this.args);
    }

}
