package de.fhws.rdsl.querylang.sql.functions;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.ExpressionElement;
import de.fhws.rdsl.querylang.elements.PropertyElement;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionArgumentDescription;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.function.FunctionDescription;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.schema.Attribute;
import de.fhws.rdsl.querylang.sql.elements.EqualsElement;

public class EqualsFunction implements Function {

    private int[] types = { Attribute.INTEGER, Attribute.STRING, Attribute.FLOAT, Attribute.DATE };
    private FunctionDescription description = new FunctionDescription("eq", this.types, Lists.newArrayList(new FunctionArgumentDescription(this.types, true)));

    @Override
    public Element createElement(Property property, List<Node> args, FunctionContext context) {
        EqualsElement equalsElement = new EqualsElement();
        equalsElement.setLeft(new PropertyElement(property));
        equalsElement.setRight((ExpressionElement) context.createElement(args.get(0)));
        return equalsElement;
    }

    @Override
    public FunctionDescription getDescription() {
        return this.description;
    }

}
