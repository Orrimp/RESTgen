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
import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.NotElement;

public class NotFunction implements Function {

	private int[] types = {};
	private FunctionDescription description = new FunctionDescription("not", this.types, Lists.newArrayList(new FunctionArgumentDescription(
	        new int[] { Attribute.NESTED }, true)));

	@Override
	public TargetElement createElement(Property property, List<SourceNode> args, FunctionContext context) {
		NotElement notElement = new NotElement();
		notElement.setExpression((ExpressionElement) context.createElement(args.get(0)));
		return notElement;
	}

	@Override
	public FunctionDescription getDescription() {
		return this.description;
	}

}
