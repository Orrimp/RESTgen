package de.fhws.rdsl.querylang.function;

public interface FunctionProvider {

    Function getFunction(String name);

    void registerFunction(Function function);

}
