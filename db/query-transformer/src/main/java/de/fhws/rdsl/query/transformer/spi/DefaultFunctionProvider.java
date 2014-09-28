package de.fhws.rdsl.query.transformer.spi;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class DefaultFunctionProvider implements FunctionProvider {

    private Map<String, Function> funs = Maps.newHashMap();

    @Override
    public Function getFunction(String name) {
        return this.funs.get(name);
    }

    @Override
    public void registerFunction(Function function) {
        this.funs.put(function.getDescription().getName(), function);

    }

    @Override
    public List<Function> getFunctions() {
        return Lists.newArrayList(this.funs.values());
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
