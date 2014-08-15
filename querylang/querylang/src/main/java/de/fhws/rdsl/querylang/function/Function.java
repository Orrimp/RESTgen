package de.fhws.rdsl.querylang.function;

import java.util.List;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.parser.Arg;

public interface Function {

    String getName();

    Element getElement(Property property, List<Arg<?>> args, FunctionContext context);

}
