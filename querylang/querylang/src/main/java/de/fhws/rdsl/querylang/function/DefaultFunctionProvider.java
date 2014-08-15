package de.fhws.rdsl.querylang.function;

import java.util.Map;

import com.google.common.collect.Maps;

public class DefaultFunctionProvider implements FunctionProvider {

    private Map<String, Function> funs = Maps.newHashMap();

    @Override
    public Function getFunction(String name) {
        return this.funs.get(name);
    }

    @Override
    public void registerFunction(Function function) {
        this.funs.put(function.getName(), function);

    }

}
