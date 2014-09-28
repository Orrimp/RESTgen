package de.fhws.rdsl.query.transformer.solr;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import com.google.common.base.CaseFormat;
import com.google.common.collect.Lists;

import de.fhws.rdsl.query.transformer.api.schema.Containment;
import de.fhws.rdsl.query.transformer.api.schema.ReferenceType;
import de.fhws.rdsl.query.transformer.api.schema.Type;
import de.fhws.rdsl.query.transformer.api.schema.Utils;
import de.fhws.rdsl.query.transformer.solr.elements.EqualsElement;
import de.fhws.rdsl.query.transformer.solr.elements.QueryElement;
import de.fhws.rdsl.query.transformer.spi.Function;
import de.fhws.rdsl.query.transformer.spi.FunctionContext;
import de.fhws.rdsl.query.transformer.spi.NodeTransformer;
import de.fhws.rdsl.query.transformer.spi.Property;
import de.fhws.rdsl.query.transformer.spi.TransformerContext;
import de.fhws.rdsl.query.transformer.spi.source.BooleanLiteralNode;
import de.fhws.rdsl.query.transformer.spi.source.FloatLiteralNode;
import de.fhws.rdsl.query.transformer.spi.source.FunctionNode;
import de.fhws.rdsl.query.transformer.spi.source.IntegerLiteralNode;
import de.fhws.rdsl.query.transformer.spi.source.JunctionNode;
import de.fhws.rdsl.query.transformer.spi.source.LiteralNode;
import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.source.NullLiteralNode;
import de.fhws.rdsl.query.transformer.spi.source.StringLiteralNode;
import de.fhws.rdsl.query.transformer.spi.target.BooleanElement;
import de.fhws.rdsl.query.transformer.spi.target.DoubleElement;
import de.fhws.rdsl.query.transformer.spi.target.IntegerElement;
import de.fhws.rdsl.query.transformer.spi.target.JunctionElement;
import de.fhws.rdsl.query.transformer.spi.target.NullElement;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.StringElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class SolrNodeTransformer implements NodeTransformer, FunctionContext {

	private TransformerContext context;
	private Type type;

	@Override
	public TargetElement transform(SourceNode node, TransformerContext context) {
		this.context = context;
		this.type = context.getQueryTransformerParameters().getSchema().findType(context.getQueryTransformerParameters().getTypeName());
		JunctionElement andJunctionElement = new JunctionElement(JunctionElement.AND);
		List<Object> identifiers = context.getQueryTransformerParameters().getQuery().getIdentifiers();
		if (!identifiers.isEmpty()) {
			andJunctionElement.getChildren().add(createIdentifiersElement(identifiers));
		}
		if (node instanceof BooleanLiteralNode) {
			BooleanLiteralNode booleanLiteralNode = (BooleanLiteralNode) node;
			// Handle "true" or "false" with dummy field
			if (identifiers.isEmpty()) {
				EqualsElement element = new EqualsElement();
				element.setProperty(new PropertyElement(new Property("_dummy")));
				element.setValue(booleanLiteralNode.getValue() ? new IntegerElement(1) : new IntegerElement(0));
				andJunctionElement.getChildren().add(element);
			}
		} else {
			andJunctionElement.getChildren().add(transform(node));
		}

		QueryElement queryElement = new QueryElement();
		queryElement.setOffset(context.getQueryTransformerParameters().getQuery().getSize());
		queryElement.setStart(context.getQueryTransformerParameters().getQuery().getStart());
		queryElement.setQuery(andJunctionElement);
		return queryElement;
	}

	private TargetElement createIdentifiersElement(List<Object> identifiers) {
		JunctionElement keysJunction = new JunctionElement(JunctionElement.AND);
		List<String> keyValues = identifiers.stream().map(String::valueOf).collect(Collectors.toList());
		List<Property> keys = getKeys(this.type, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
		for (int i = 0; i < keyValues.size(); i++) {
			EqualsElement equalsElement = new EqualsElement();
			equalsElement.setProperty(new PropertyElement(keys.get(i)));
			equalsElement.setValue(new StringElement(keyValues.get(i)));
			keysJunction.getChildren().add(equalsElement);
		}
		return keysJunction;
	}

	private TargetElement transform(SourceNode node) {
		if (node instanceof JunctionNode) {
			return transform((JunctionNode) node);
		} else if (node instanceof LiteralNode) {
			return transform((LiteralNode<?>) node);
		} else if (node instanceof FunctionNode) {
			return transform((FunctionNode) node);
		} else {
			throw new RuntimeException();
		}
	}

	private TargetElement transform(FunctionNode call) {
		String name = call.getName();
		Function function = this.context.getFunctionProvider().getFunction(name);
		return function.createElement(new Property(call.getPath()), call.getArgs(), this);
	}

	private TargetElement transform(LiteralNode<?> literal) {
		if (literal instanceof NullLiteralNode) {
			return new NullElement();
		} else if (literal instanceof FloatLiteralNode) {
			FloatLiteralNode doubleArg = (FloatLiteralNode) literal;
			return new DoubleElement(doubleArg.getValue());
		} else if (literal instanceof IntegerLiteralNode) {
			IntegerLiteralNode integerArg = (IntegerLiteralNode) literal;
			return new IntegerElement(integerArg.getValue());
		} else if (literal instanceof BooleanLiteralNode) {
			BooleanLiteralNode booleanArg = (BooleanLiteralNode) literal;
			return new BooleanElement(booleanArg.getValue());
		} else if (literal instanceof StringLiteralNode) {
			StringLiteralNode stringArg = (StringLiteralNode) literal;
			return new StringElement(stringArg.getValue());
		} else {
			throw new RuntimeException();
		}
	}

	private TargetElement transform(JunctionNode junction) {
		JunctionElement junctionElement = new JunctionElement(junction.getType() == JunctionNode.AND ? JunctionElement.AND : JunctionElement.OR);
		junctionElement.getChildren().addAll(junction.getChildren().stream().map(child -> transform(child)).collect(Collectors.toList()));
		return junctionElement;
	}

	private static List<Property> getKeys(Type type, List<Type> allTypes) {
		LinkedList<String> keys = Lists.newLinkedList();
		if (type instanceof ReferenceType) {
			throw new RuntimeException();
		} else {
			Type currentType = type;
			while (true) {
				Containment containment = Utils.findContainment(currentType, allTypes);
				if (containment == null) { // root
					keys.addLast("_" + CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, currentType.getName()) + "Id");
					break;
				} else {
					currentType = Utils.findContainer(currentType, allTypes);
					if (!containment.isList()) { // 1:1
					} else { // 1:n
						keys.addFirst("_" + CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, currentType.getName()) + "Id");
					}
				}
			}
		}
		return keys.stream().map(Property::new).collect(Collectors.toList());
	}

	@Override
	public TransformerContext getTransformerContext() {
		return this.context;
	}

	@Override
	public TargetElement createElement(SourceNode node) {
		return transform(node);
	}

}