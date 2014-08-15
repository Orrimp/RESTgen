package de.fhws.rdsl.querylang.function;

import java.util.List;

public interface FunctionProvider {

    Function getFunction(String name);

    void registerFunction(Function function);

    List<Function> getFunctions();

}
