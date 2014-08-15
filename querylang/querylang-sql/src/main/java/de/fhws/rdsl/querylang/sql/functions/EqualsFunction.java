package de.fhws.rdsl.querylang.sql.functions;

import java.util.List;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.parser.Arg;
import de.fhws.rdsl.querylang.sql.elements.EqualsElement;
import de.fhws.rdsl.querylang.sql.elements.ExpressionElement;
import de.fhws.rdsl.querylang.sql.elements.PropertyElement;

public class EqualsFunction implements Function {

    @Override
    public String getName() {
        return "eq";
    }

    @Override
    public Element getElement(Property property, List<Arg<?>> args, FunctionContext context) {
        EqualsElement equalsElement = new EqualsElement();
        equalsElement.setLeft(new PropertyElement(property));
        equalsElement.setRight((ExpressionElement) context.getElement(args.get(0)));
        return equalsElement;
    }

}
