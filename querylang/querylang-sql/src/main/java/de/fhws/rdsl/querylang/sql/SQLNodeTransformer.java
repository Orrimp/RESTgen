package de.fhws.rdsl.querylang.sql;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import de.fhws.rdsl.querylang.NodeTransformer;
import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.Query;
import de.fhws.rdsl.querylang.TransformerContext;
import de.fhws.rdsl.querylang.elements.BooleanElement;
import de.fhws.rdsl.querylang.elements.DoubleElement;
import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.ExpressionElement;
import de.fhws.rdsl.querylang.elements.IntegerElement;
import de.fhws.rdsl.querylang.elements.JunctionElement;
import de.fhws.rdsl.querylang.elements.NullElement;
import de.fhws.rdsl.querylang.elements.PropertyElement;
import de.fhws.rdsl.querylang.elements.StringElement;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.parser.BooleanLiteralNode;
import de.fhws.rdsl.querylang.parser.FloatLiteralNode;
import de.fhws.rdsl.querylang.parser.FunctionNode;
import de.fhws.rdsl.querylang.parser.IntegerLiteralNode;
import de.fhws.rdsl.querylang.parser.JunctionNode;
import de.fhws.rdsl.querylang.parser.LiteralNode;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.parser.NullLiteralNode;
import de.fhws.rdsl.querylang.parser.StringLiteralNode;
import de.fhws.rdsl.querylang.schema.Attribute;
import de.fhws.rdsl.querylang.schema.Containment;
import de.fhws.rdsl.querylang.schema.Member;
import de.fhws.rdsl.querylang.schema.Reference;
import de.fhws.rdsl.querylang.schema.ReferenceType;
import de.fhws.rdsl.querylang.schema.RootResourceType;
import de.fhws.rdsl.querylang.schema.Type;
import de.fhws.rdsl.querylang.sql.elements.EqualsElement;
import de.fhws.rdsl.querylang.sql.elements.JoinElement;
import de.fhws.rdsl.querylang.sql.elements.OrderElement;
import de.fhws.rdsl.querylang.sql.elements.QueriesElement;
import de.fhws.rdsl.querylang.sql.elements.SelectElement;
import de.fhws.rdsl.querylang.sql.elements.StatementElement;

public class SQLNodeTransformer implements NodeTransformer, FunctionContext {

    private List<Join> joins;
    private Map<String, String> aliases;
    private TransformerContext context;
    private Node node;
    private int aliasCounter;
    private Type type;
    private Query query;

    @Override
    public TransformerContext getTransformerContext() {
        return this.context;
    }

    @Override
    public Element createElement(Node node) {
        return transform(node);
    }

    @Override
    public Element transform(Node node, TransformerContext context) {
        this.aliasCounter = 1;
        this.joins = Lists.newArrayList();
        this.aliases = Maps.newHashMap();
        this.context = context;
        this.node = node;
        this.type = context.getSchema().findType(context.getTypeName());
        this.query = context.getQuery();
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
        queryStatement.setOffset(this.query.getOffset());
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
        selectElement.setFromTable(Names.getTableName(this.type, this.context.getSchema().getAllTypes()));
        selectElement.setFromTableAlias(this.aliases.get(""));
        List<Property> properties = Lists.newArrayList(getKeys().stream().collect(Collectors.toList()));
        if (!count) {
            properties.addAll(getTableAttributes().stream().filter(prop -> !properties.contains(prop)).collect(Collectors.toList()));
        }
        selectElement.getProperties().addAll(properties.stream().map(PropertyElement::new).collect(Collectors.toList()));
        return selectElement;
    }

    private List<Property> getKeys() {
        String alias = this.aliases.get("");
        return Names.getKeys(alias, this.type, this.context.getSchema().getAllTypes());
    }

    private List<Property> getTableAttributes() {
        return this.type.getMembers().stream().filter(Attribute.class::isInstance).filter(member -> !member.isList())
                .map(member -> getAliasProperty(Lists.newArrayList(member.getName()))).collect(Collectors.toList());
    }

    private JunctionElement buildWhere() {
        List<Property> keys = getKeys();
        JunctionElement junction = new JunctionElement(JunctionElement.AND);
        junction.getChildren().add(transform(this.node));
        List<EqualsElement> keyExpressions = Lists.newArrayList();
        JunctionElement filter = new JunctionElement(JunctionElement.AND);
        if (!this.context.getQuery().getIdentifiers().isEmpty()) {
            for (int i = 0; i < keys.size() - 1; i++) {
                Object key = this.context.getQuery().getIdentifiers().get(i);
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

    private Element transform(Node node) {
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

    private Element transform(JunctionNode junction) {
        JunctionElement junctionElement = new JunctionElement(junction.getType() == JunctionNode.AND ? JunctionElement.AND : JunctionElement.OR);
        junctionElement.getChildren().addAll(junction.getChildren().stream().map(this::transform).collect(Collectors.toList()));
        return junctionElement;
    }

    private Element transform(FunctionNode call) {
        Property property = call.getPath().isEmpty() ? null : getAliasProperty(call.getPath());
        Function function = this.context.getFunctionProvider().getFunction(call.getName());
        if (function == null) {
            throw new RuntimeException("Function '" + call.getName() + "' not found");
        }
        return function.createElement(property, call.getArgs(), this);
    }

    private Element transform(LiteralNode<?> literal) {
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
                Reference reference = (Reference) member;
                fullTablePath = parts.subList(0, i + 1);
                String alias = this.aliases.get(Names.joinPath(fullTablePath));
                realPath = alias + ".";
                currentType = reference.getResourceType();
            } else if (member instanceof Attribute) {
                realPath = realPath + member.getName();
                break;
            }
        }
        String[] realPathParts = realPath.split("\\.");
        String namespace = null, name = null;
        if (realPathParts.length == 1) {
            name = realPathParts[0];
        } else {
            namespace = realPathParts[0];
            name = realPathParts[1];
        }
        return prop(namespace, name);
    }

    private void collectAllPaths(Node node, List<String> paths) {
        if (node instanceof FunctionNode) {
            FunctionNode methodCall = (FunctionNode) node;
            paths.add(Names.joinPath(methodCall.getPath()));
        }
        for (Node child : node.getChildren()) {
            collectAllPaths(child, paths);
        }
    }

    private void joinTables() {
        this.aliases.put("", "tab0");
        List<String> allPaths = Lists.newArrayList();
        if (this.context.getQuery().getOrder() != null) {
            allPaths.add(this.context.getQuery().getOrder());
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
                    Reference reference = (Reference) member;
                    Type toType = reference.getResourceType();
                    updateJoins(tablePath, tablePath = parts.subList(0, i + 1), new Join(fromType, reference, toType));
                    fromType = toType;
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
        if (join.via instanceof Containment) {
            // Join from Type to SubResourceType
            Containment containment = (Containment) join.via;
            if (containment.isList()) {
                String table = Names.getTableName(join.to, this.context.getSchema().getAllTypes());
                List<Property> fromKeys = Names.getKeys(join.aliasFrom, join.from, this.context.getSchema().getAllTypes());
                List<Property> toKeys = Names.getKeys(join.aliasTo, join.to, this.context.getSchema().getAllTypes());
                joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys.subList(0, toKeys.size() - 1)));
                return joinElements;
            }
        } else if (join.via instanceof Reference && join.from instanceof ReferenceType) {
            // Join from ReferenceType to RootResourceType
            String table = Names.getTableName(join.to, this.context.getSchema().getAllTypes());
            String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.to);
            List<Property> fromKeys = Lists.newArrayList(new Property(join.aliasFrom, propertyName));
            List<Property> toKeys = Lists.newArrayList(new Property(join.aliasTo, "_" + join.to.getName() + "Id"));
            joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys));
            return joinElements;
        } else if (join.via instanceof Reference) {
            // Join from RootResourceType to RootResourceType
            Reference reference = (Reference) join.via;
            {
                String table = Names.getTableName(reference.getReferenceType(), this.context.getSchema().getAllTypes());
                List<Property> fromKeys = Names.getKeys(join.aliasFrom, join.from, this.context.getSchema().getAllTypes());
                String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.from);
                List<Property> toKeys = Lists.newArrayList(prop(table, propertyName));
                joinElements.add(toJoinString(table, table, fromKeys, toKeys));
            }
            {
                String table = Names.getTableName(join.to, this.context.getSchema().getAllTypes());
                String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.to);
                List<Property> fromKeys = Lists.newArrayList(prop(Names.getTableName(reference.getReferenceType(), this.context.getSchema().getAllTypes()),
                        propertyName));
                List<Property> toKeys = Names.getKeys(join.aliasTo, reference.getResourceType(), this.context.getSchema().getAllTypes());
                joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys));
            }
            return joinElements;
        }
        return joinElements;
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