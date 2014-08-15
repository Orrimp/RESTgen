package de.fhws.rdsl.querylang.sql.functions;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.ExpressionElement;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionArgumentDescription;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.function.FunctionDescription;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.schema.Attribute;
import de.fhws.rdsl.querylang.sql.elements.NotElement;

public class NotFunction implements Function {

    private int[] types = {};
    private FunctionDescription description = new FunctionDescription("not", this.types, Lists.newArrayList(new FunctionArgumentDescription(
            new int[] { Attribute.NESTED }, true)));

    @Override
    public Element createElement(Property property, List<Node> args, FunctionContext context) {
        NotElement notElement = new NotElement();
        notElement.setExpression((ExpressionElement) context.createElement(args.get(0)));
        return notElement;
    }

    @Override
    public FunctionDescription getDescription() {
        return this.description;
    }

}
