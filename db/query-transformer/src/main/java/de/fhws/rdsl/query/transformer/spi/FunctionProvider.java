package de.fhws.rdsl.query.transformer.spi;

import java.util.List;

public interface FunctionProvider {

    Function getFunction(String name);

    void registerFunction(Function function);

    List<Function> getFunctions();

}
