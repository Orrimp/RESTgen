package de.fhws.rdsl.querylang.parser;

import java.util.ArrayList;
import java.util.List;

import com.google.common.collect.Lists;

public class MethodCall extends Node {

    private List<String> path = new ArrayList<String>();
    private String name;
    private List<Arg<?>> args = new ArrayList<Arg<?>>();

    public List<Arg<?>> getArgs() {
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

    @Override
    public String toString() {
        return getClass().getSimpleName() + ": [path: " + this.path + ", name: " + this.name + ", args: " + this.args + "]";
    }

}
