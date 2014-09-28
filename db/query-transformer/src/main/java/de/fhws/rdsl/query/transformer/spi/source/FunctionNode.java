package de.fhws.rdsl.query.transformer.spi.source;

import java.util.ArrayList;
import java.util.List;

import com.google.common.collect.Lists;

public class FunctionNode extends SourceNode {

    private List<String> path = new ArrayList<String>();
    private String name;
    private List<SourceNode> args = new ArrayList<SourceNode>();

    public List<SourceNode> getArgs() {
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
    public List<SourceNode> getChildren() {
        return Lists.newArrayList(this.args);
    }

}
