package de.fhws.rdsl.querylang;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.function.FunctionProvider;
import de.fhws.rdsl.querylang.schema.Type;

public class NodeToElementTransformerContext {

    private Type type = null;
    private List<Type> allTypes = Lists.newArrayList();
    private FunctionProvider functionProvider;
    private List<Object> keys;

    public NodeToElementTransformerContext(Type type, List<Type> allTypes, List<Object> keys, FunctionProvider functionProvider) {
        super();
        this.type = type;
        this.allTypes = allTypes;
        this.functionProvider = functionProvider;
        this.keys = keys;
    }

    public FunctionProvider getFunctionProvider() {
        return this.functionProvider;
    }

    public Type getType() {
        return this.type;
    }

    public List<Type> getAllTypes() {
        return this.allTypes;
    }

    public List<Object> getKeys() {
        return this.keys;
    }

}
