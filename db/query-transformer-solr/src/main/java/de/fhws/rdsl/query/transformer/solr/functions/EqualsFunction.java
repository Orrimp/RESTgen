package de.fhws.rdsl.query.transformer.solr.functions;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.query.FunctionArgumentDescription;
import de.fhws.rdsl.query.FunctionDescription;
import de.fhws.rdsl.query.transformer.api.schema.Attribute;
import de.fhws.rdsl.query.transformer.solr.elements.EqualsElement;
import de.fhws.rdsl.query.transformer.spi.Function;
import de.fhws.rdsl.query.transformer.spi.FunctionContext;
import de.fhws.rdsl.query.transformer.spi.Property;
import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class EqualsFunction implements Function {

    private int[] types = { Attribute.INTEGER, Attribute.STRING, Attribute.FLOAT, Attribute.DATE };
    private FunctionDescription description = new FunctionDescription("eq", this.types, Lists.newArrayList(new FunctionArgumentDescription(this.types, true)));

    @Override
    public TargetElement createElement(Property property, List<SourceNode> args, FunctionContext context) {
        EqualsElement equalsElement = new EqualsElement();
        equalsElement.setProperty(new PropertyElement(property));
        equalsElement.setValue((ExpressionElement) context.createElement(args.get(0)));
        return equalsElement;
    }

    @Override
    public FunctionDescription getDescription() {
        return this.description;
    }

}
