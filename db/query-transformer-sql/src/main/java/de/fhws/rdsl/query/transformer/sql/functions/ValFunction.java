package de.fhws.rdsl.query.transformer.sql.functions;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.query.FunctionArgumentDescription;
import de.fhws.rdsl.query.FunctionDescription;
import de.fhws.rdsl.query.transformer.api.schema.Attribute;
import de.fhws.rdsl.query.transformer.spi.Function;
import de.fhws.rdsl.query.transformer.spi.FunctionContext;
import de.fhws.rdsl.query.transformer.spi.Property;
import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class ValFunction implements Function {

    private int[] types = { Attribute.INTEGER, Attribute.STRING, Attribute.FLOAT, Attribute.DATE };
    private FunctionDescription description = new FunctionDescription("val", this.types,
            Lists.newArrayList(new FunctionArgumentDescription(new int[] {}, true)));

    @Override
    public TargetElement createElement(Property property, List<SourceNode> args, FunctionContext context) {
        return new PropertyElement(property);
    }

    @Override
    public FunctionDescription getDescription() {
        return this.description;
    }
}
