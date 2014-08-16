package de.fhws.rdsl.querylang.sql.functions;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.PropertyElement;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionArgumentDescription;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.function.FunctionDescription;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.schema.Attribute;

public class ValFunction implements Function {

    private int[] types = { Attribute.INTEGER, Attribute.STRING, Attribute.FLOAT, Attribute.DATE };
    private FunctionDescription description = new FunctionDescription("val", this.types,
            Lists.newArrayList(new FunctionArgumentDescription(new int[] {}, true)));

    @Override
    public Element createElement(Property property, List<Node> args, FunctionContext context) {
        return new PropertyElement(property);
    }

    @Override
    public FunctionDescription getDescription() {
        return this.description;
    }
}
