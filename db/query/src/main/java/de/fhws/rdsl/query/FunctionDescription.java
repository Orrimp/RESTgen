package de.fhws.rdsl.query;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.google.common.collect.Lists;

public class FunctionDescription {

    private int[] types;
    private String name;
    private List<FunctionArgumentDescription> args = Lists.newArrayList();

    public FunctionDescription(String name, int[] types, List<FunctionArgumentDescription> args) {
        super();
        this.types = types;
        this.name = name;
        this.args.addAll(args);
    }

    public String getName() {
        return this.name;
    }

    public int[] getTypes() {
        return this.types;
    }

    public List<FunctionArgumentDescription> getArgs() {
        return this.args;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
