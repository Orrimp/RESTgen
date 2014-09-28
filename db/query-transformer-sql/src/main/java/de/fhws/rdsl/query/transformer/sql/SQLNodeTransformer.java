package de.fhws.rdsl.query.transformer.sql;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import de.fhws.rdsl.query.Query;
import de.fhws.rdsl.query.transformer.api.schema.Attribute;
import de.fhws.rdsl.query.transformer.api.schema.Containment;
import de.fhws.rdsl.query.transformer.api.schema.Member;
import de.fhws.rdsl.query.transformer.api.schema.Reference;
import de.fhws.rdsl.query.transformer.api.schema.ReferenceType;
import de.fhws.rdsl.query.transformer.api.schema.Type;
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
import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;
import de.fhws.rdsl.query.transformer.spi.target.IntegerElement;
import de.fhws.rdsl.query.transformer.spi.target.JunctionElement;
import de.fhws.rdsl.query.transformer.spi.target.NullElement;
import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.StringElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;
import de.fhws.rdsl.query.transformer.sql.elements.EqualsElement;
import de.fhws.rdsl.query.transformer.sql.elements.JoinElement;
import de.fhws.rdsl.query.transformer.sql.elements.OrderElement;
import de.fhws.rdsl.query.transformer.sql.elements.QueriesElement;
import de.fhws.rdsl.query.transformer.sql.elements.SelectElement;
import de.fhws.rdsl.query.transformer.sql.elements.StatementElement;

public class SQLNodeTransformer implements NodeTransformer, FunctionContext {

	private List<Join> joins;
	private Map<String, String> aliases;
	private TransformerContext context;
	private SourceNode node;
	private int aliasCounter;
	private Type type;
	private Query query;

	@Override
	public TransformerContext getTransformerContext() {
		return this.context;
	}

	@Override
	public TargetElement createElement(SourceNode node) {
		return transform(node);
	}

	@Override
	public TargetElement transform(SourceNode node, TransformerContext context) {
		this.aliasCounter = 1;
		this.joins = Lists.newArrayList();
		this.aliases = Maps.newHashMap();
		this.context = context;
		this.node = node;
		this.type = context.getQueryTransformerParameters().getSchema().findType(context.getQueryTransformerParameters().getTypeName());
		this.query = context.getQueryTransformerParameters().getQuery();
		joinTables();
		QueriesElement queriesElement = new QueriesElement();
		queriesElement.setCountQuery(createCountStatement());
		queriesElement.setQuery(createQueryStatement());
		return queriesElement;
	}

	private StatementElement createQueryStatement() {
		StatementElement queryStatement = new StatementElement();
		queryStatement.setSelect(createSelectElement(false));
		queryStatement.getJoins().addAll(buildJoins());
		queryStatement.setFilter(buildWhere());
		queryStatement.setStart(this.query.getStart());
		queryStatement.setSize(this.query.getSize());
		if (this.query.getOrder() != null) {
			queryStatement.setOrder(createOrderElement());
		}
		return queryStatement;
	}

	private StatementElement createCountStatement() {
		StatementElement countStatement = new StatementElement();
		countStatement.setSelect(createSelectElement(true));
		countStatement.getJoins().addAll(buildJoins());
		countStatement.setFilter(buildWhere());
		return countStatement;
	}

	private OrderElement createOrderElement() {
		List<String> path = Lists.newArrayList(this.query.getOrder().split("\\."));
		OrderElement orderElement = new OrderElement();
		orderElement.setDesc(this.query.isOrderDesc());
		orderElement.setProperty(new PropertyElement(getAliasProperty(path)));
		return orderElement;
	}

	private SelectElement createSelectElement(boolean count) {
		SelectElement selectElement = new SelectElement();
		selectElement.setDistinct(true);
		selectElement.setCount(count);
		selectElement.setFromTable(Names.getTableName(this.type, this.context.getQueryTransformerParameters().getSchema().getAllTypes()));
		selectElement.setFromTableAlias(this.aliases.get(""));
		List<Property> properties = Lists.newArrayList(getKeys().stream().collect(Collectors.toList()));
		if (!count) {
			properties.addAll(getTableAttributes().stream().filter(prop -> !properties.contains(prop)).collect(Collectors.toList()));
			properties.addAll(getTableReferences().stream().filter(prop -> !properties.contains(prop)).collect(Collectors.toList()));
		}
		selectElement.getProperties().addAll(properties.stream().map(PropertyElement::new).collect(Collectors.toList()));
		return selectElement;
	}

	private List<Property> getKeys() {
		String alias = this.aliases.get("");
		return Names.getKeys(alias, this.type, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
	}

	private List<Property> getTableAttributes() {
		return this.type.getMembers().stream().filter(Attribute.class::isInstance).filter(member -> !member.isList())
		        .map(member -> getAliasProperty(Lists.newArrayList(member.getName()))).collect(Collectors.toList());
	}

	private List<Property> getTableReferences() {
		return this.type.getMembers().stream().filter(Reference.class::isInstance).filter(member -> !member.isList() && !member.getName().startsWith("_"))
		        .map(member -> prop("tab0", member.getName())).collect(Collectors.toList());
	}

	private JunctionElement buildWhere() {
		List<Property> keys = getKeys();
		JunctionElement junction = new JunctionElement(JunctionElement.AND);
		junction.getChildren().add(transform(this.node));
		List<EqualsElement> keyExpressions = Lists.newArrayList();
		JunctionElement filter = new JunctionElement(JunctionElement.AND);
		if (!this.context.getQueryTransformerParameters().getQuery().getIdentifiers().isEmpty()) {
			for (int i = 0; i < keys.size() - 1; i++) {
				Object key = this.context.getQueryTransformerParameters().getQuery().getIdentifiers().get(i);
				ExpressionElement expressionElement;
				if (key instanceof String) {
					expressionElement = new StringElement((String) key);
				} else {
					expressionElement = new IntegerElement((Integer) key);
				}
				EqualsElement equalsElement = new EqualsElement();
				equalsElement.setLeft(new PropertyElement((keys.get(i))));
				equalsElement.setRight(expressionElement);
				keyExpressions.add(equalsElement);
			}
		}
		if (!(this.type instanceof ReferenceType) && keyExpressions.size() >= 1) {
			filter.getChildren().addAll(keyExpressions);
		}
		if (!filter.getChildren().isEmpty()) {
			junction.getChildren().add(filter);
		}
		return junction;
	}

	private TargetElement transform(SourceNode node) {
		if (node instanceof JunctionNode) {
			return transform((JunctionNode) node);
		} else if (node instanceof FunctionNode) {
			return transform((FunctionNode) node);
		} else if (node instanceof LiteralNode) {
			return transform((LiteralNode<?>) node);
		} else {
			throw new RuntimeException();
		}
	}

	private TargetElement transform(JunctionNode junction) {
		JunctionElement junctionElement = new JunctionElement(junction.getType() == JunctionNode.AND ? JunctionElement.AND : JunctionElement.OR);
		junctionElement.getChildren().addAll(junction.getChildren().stream().map(this::transform).collect(Collectors.toList()));
		return junctionElement;
	}

	private TargetElement transform(FunctionNode call) {
		Property property = call.getPath().isEmpty() ? null : getAliasProperty(call.getPath());
		Function function = this.context.getFunctionProvider().getFunction(call.getName());
		if (function == null) {
			throw new RuntimeException("Function '" + call.getName() + "' not found");
		}
		return function.createElement(property, call.getArgs(), this);
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

	private Property getAliasProperty(List<String> parts) {
		String realPath = this.aliases.get("") + ".";
		Type currentType = this.type;
		List<String> fullTablePath = Lists.newArrayList();
		for (int i = 0; i < parts.size(); i++) {
			Member member = currentType.getMember(parts.get(i));
			if (member instanceof Containment) {
				Containment containment = (Containment) member;
				if (containment.isList()) {
					fullTablePath = parts.subList(0, i + 1);
					String alias = this.aliases.get(Names.joinPath(fullTablePath));
					realPath = alias + ".";
				} else {
					realPath = realPath + containment.getName() + "_";
				}
				currentType = containment.getResourceType();
			} else if (member instanceof Reference) {
				if (i == parts.size() - 1) {
					realPath = realPath + member.getName();
				} else {
					Reference reference = (Reference) member;
					fullTablePath = parts.subList(0, i + 1);
					String alias = this.aliases.get(Names.joinPath(fullTablePath));
					realPath = alias + ".";
					currentType = reference.getType();
					// i++;
				}

			} else if (member instanceof Attribute) {
				realPath = realPath + member.getName();
				break;
			}
		}
		String[] realPathParts = realPath.split("\\.");
		return prop(realPathParts[0], realPathParts[1]);
	}

	private void collectAllPaths(SourceNode node, List<String> paths) {
		if (node instanceof FunctionNode) {
			FunctionNode methodCall = (FunctionNode) node;
			paths.add(Names.joinPath(methodCall.getPath()));
		}
		for (SourceNode child : node.getChildren()) {
			collectAllPaths(child, paths);
		}
	}

	private void joinTables() {
		this.aliases.put("", "tab0");
		List<String> allPaths = Lists.newArrayList();
		if (this.context.getQueryTransformerParameters().getQuery().getOrder() != null) {
			allPaths.add(this.context.getQueryTransformerParameters().getQuery().getOrder());
		}
		collectAllPaths(this.node, allPaths);
		for (String path : allPaths) {
			List<String> parts = Lists.newArrayList(path.split("\\."));
			Type fromType = this.type;
			List<String> tablePath = Lists.newArrayList();
			for (int i = 0; i < parts.size(); i++) {
				Member member = fromType.getMember(parts.get(i));
				if (member instanceof Attribute) {
					break;
				} else if (member instanceof Containment) {
					Containment containment = (Containment) member;
					Type toType = containment.getResourceType();
					if (containment.isList()) {
						updateJoins(tablePath, tablePath = parts.subList(0, i + 1), new Join(fromType, containment, toType));
					}
					fromType = toType;
				} else if (member instanceof Reference) {
					// Member nextMember = fromType.getMember(parts.get(i + 1));
					if (i == parts.size() - 1) {
						// nothing
					} else {
						Reference reference = (Reference) member;
						Type toType = reference.getType();
						Join join = new Join(fromType, reference, toType);
						updateJoins(tablePath, tablePath = parts.subList(0, i + 1), join);
						fromType = toType;
					}
				}
			}
		}
	}

	private List<JoinElement> buildJoins() {
		List<JoinElement> joinElements = Lists.newArrayList();
		for (Join join : this.joins) {
			List<JoinElement> elements = createJoinElements(join);
			if (elements != null) {
				joinElements.addAll(elements);
			}
		}
		return joinElements;
	}

	private void updateJoins(List<String> pathFrom, List<String> pathTo, Join join) {

		if (this.joins.contains(join)) {
			return;
		}

		// empty String is root
		String aliasKeyFrom = Names.joinPath(pathFrom);
		String aliasKeyTo = Names.joinPath(pathTo);
		if (!this.aliases.containsKey(aliasKeyFrom)) {
			this.aliases.put(aliasKeyFrom, "tab" + (this.aliasCounter++));
		}
		if (!this.aliases.containsKey(aliasKeyTo)) {
			this.aliases.put(aliasKeyTo, "tab" + (this.aliasCounter++));
		}
		join.aliasFrom = this.aliases.get(aliasKeyFrom);
		join.aliasTo = this.aliases.get(aliasKeyTo);
		this.joins.add(join);

	}

	private List<JoinElement> createJoinElements(Join join) {
		List<JoinElement> joinElements = Lists.newArrayList();
		if (join.via instanceof Containment && ((Containment) join.via).isList()) {
			String table = Names.getTableName(join.to, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
			List<Property> fromKeys = Names.getKeys(join.aliasFrom, join.from, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
			List<Property> toKeys = Names.getKeys(join.aliasTo, join.to, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
			joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys.subList(0, toKeys.size() - 1)));
			return joinElements;
		} else if (join.via instanceof Reference) {
			String table = Names.getTableName(join.to, this.context.getQueryTransformerParameters().getSchema().getAllTypes());
			String fromKey = null;
			String toKey = null;
			if (join.from instanceof ReferenceType) {
				fromKey = getKey((ReferenceType) join.from, join.to);
				toKey = "_" + join.to.getName() + "Id";
			} else if (join.to instanceof ReferenceType) {
				fromKey = "_" + join.from.getName() + "Id";
				toKey = getKey(join.from, (ReferenceType) join.to);
			}
			List<Property> fromKeys = Lists.newArrayList(prop(join.aliasFrom, fromKey));
			List<Property> toKeys = Lists.newArrayList(prop(join.aliasTo, toKey));
			joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys));
			return joinElements;
		}
		return joinElements;
	}

	private String getKey(ReferenceType fromType, Type toType) {
		for (Member member : fromType.getMembers()) {
			if (member instanceof Reference) {
				Reference reference = (Reference) member;
				if (toType == reference.getType()) {
					return reference.getName().replace("_ref_", "");
				}
			}
		}
		return null;
	}

	private String getKey(Type fromType, ReferenceType toType) {
		for (Member member : fromType.getMembers()) {
			if (member instanceof Reference) {
				Reference reference = (Reference) member;
				if (toType == reference.getType()) {
					return "_" + reference.getName() + "_" + fromType.getName();
				}
			}
		}
		return null;
	}

	private Property prop(String ns, String name) {
		return new Property(ns, name);
	}

	private JoinElement toJoinString(String table, String alias, List<Property> keys1, List<Property> keys2) {
		JoinElement joinElement = new JoinElement();
		joinElement.setTable(table);
		joinElement.setTableAlias(alias);
		for (int i = 0; i < keys1.size(); i++) {
			EqualsElement equalsElement = new EqualsElement();
			equalsElement.setLeft(new PropertyElement(keys1.get(i)));
			equalsElement.setRight(new PropertyElement(keys2.get(i)));
			joinElement.getProperties().add(equalsElement);
		}
		return joinElement;
	}

}
