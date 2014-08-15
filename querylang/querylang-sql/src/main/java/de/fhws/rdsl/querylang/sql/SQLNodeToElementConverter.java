package de.fhws.rdsl.querylang.sql;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.NodeToElementTransformerContext;
import de.fhws.rdsl.querylang.NodeToElementTransformer;
import de.fhws.rdsl.querylang.Property;
import de.fhws.rdsl.querylang.function.Function;
import de.fhws.rdsl.querylang.function.FunctionContext;
import de.fhws.rdsl.querylang.parser.Arg;
import de.fhws.rdsl.querylang.parser.BooleanArg;
import de.fhws.rdsl.querylang.parser.DoubleArg;
import de.fhws.rdsl.querylang.parser.IntegerArg;
import de.fhws.rdsl.querylang.parser.Junction;
import de.fhws.rdsl.querylang.parser.MethodCall;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.parser.NodeArg;
import de.fhws.rdsl.querylang.parser.NullArg;
import de.fhws.rdsl.querylang.parser.StringArg;
import de.fhws.rdsl.querylang.schema.Attribute;
import de.fhws.rdsl.querylang.schema.Containment;
import de.fhws.rdsl.querylang.schema.Member;
import de.fhws.rdsl.querylang.schema.Reference;
import de.fhws.rdsl.querylang.schema.ReferenceType;
import de.fhws.rdsl.querylang.schema.RootResourceType;
import de.fhws.rdsl.querylang.schema.Type;
import de.fhws.rdsl.querylang.sql.elements.BooleanElement;
import de.fhws.rdsl.querylang.sql.elements.DoubleElement;
import de.fhws.rdsl.querylang.sql.elements.EqualsElement;
import de.fhws.rdsl.querylang.sql.elements.ExpressionElement;
import de.fhws.rdsl.querylang.sql.elements.IntegerElement;
import de.fhws.rdsl.querylang.sql.elements.JoinElement;
import de.fhws.rdsl.querylang.sql.elements.JunctionElement;
import de.fhws.rdsl.querylang.sql.elements.NullElement;
import de.fhws.rdsl.querylang.sql.elements.PropertyElement;
import de.fhws.rdsl.querylang.sql.elements.SelectElement;
import de.fhws.rdsl.querylang.sql.elements.StatementElement;
import de.fhws.rdsl.querylang.sql.elements.StringElement;

public class SQLNodeToElementConverter implements NodeToElementTransformer, FunctionContext {

    private List<Join> joins = Lists.newArrayList();
    private Map<String, String> aliases = Maps.newHashMap();
    private NodeToElementTransformerContext context;
    private Node node;
    private StatementElement statementElement;

    @Override
    public Element getElement(Node node, NodeToElementTransformerContext context) {
        this.context = context;
        this.statementElement = new StatementElement();
        this.node = node;
        joinTables();
        this.statementElement.setSelect(buildSelect());
        this.statementElement.getJoins().addAll(buildJoins());
        this.statementElement.setFilter(buildWhere());
        return this.statementElement;
    }

    private SelectElement buildSelect() {
        SelectElement selectElement = new SelectElement();
        selectElement.setDistinct(true);
        selectElement.setFromTable(Names.getTableName(this.context.getType(), this.context.getAllTypes()));
        selectElement.setFromTableAlias(this.aliases.get(""));
        selectElement.getProperties().addAll(getKeys().stream().map(key -> new PropertyElement(key)).collect(Collectors.toList()));
        return selectElement;
    }

    private List<Property> getKeys() {
        String alias = this.aliases.get("");
        List<Property> keys = Names.getKeys(alias, this.context.getType(), this.context.getAllTypes());
        return keys;
    }

    private JunctionElement buildWhere() {
        List<Property> keys = getKeys();
        JunctionElement junction = new JunctionElement();
        junction.setType(JunctionElement.AND);
        junction.getChildren().add(buildElement(this.node));
        List<EqualsElement> keyExpressions = Lists.newArrayList();
        JunctionElement filter = new JunctionElement();
        for (int i = 0; i < keys.size() - 1; i++) {
            Object key = this.context.getKeys().get(i);
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
        if (!(this.context.getType() instanceof ReferenceType) && keyExpressions.size() >= 1) {
            filter.getChildren().addAll(keyExpressions);
        }
        if (!filter.getChildren().isEmpty()) {
            junction.getChildren().add(filter);
        }
        return junction;
    }

    private Element buildElement(Node node) {
        if (node instanceof Junction) {
            Junction junction = (Junction) node;
            JunctionElement junctionElement = new JunctionElement();
            if (junction.getType() == Junction.OR) {
                junctionElement.setType(JunctionElement.OR);
            } else if (junction.getType() == Junction.AND) {
                junctionElement.setType(JunctionElement.AND);
            }
            junctionElement.getChildren().addAll(junction.getChildren().stream().map(child -> buildElement(child)).collect(Collectors.toList()));
            return junctionElement;
        } else if (node instanceof MethodCall) {
            MethodCall methodCall = (MethodCall) node;
            Property property = methodCall.getPath().isEmpty() ? null : getAliasPath(methodCall.getPath());
            Function function = this.context.getFunctionProvider().getFunction(methodCall.getName());
            return function.getElement(property, methodCall.getArgs(), this);
        } else if (node instanceof Arg) {
            if (node instanceof NodeArg) {
                NodeArg nodeArg = (NodeArg) node;
                return buildElement(nodeArg);
            } else if (node instanceof NullArg) {
                return new NullElement();
            } else if (node instanceof DoubleArg) {
                DoubleArg doubleArg = (DoubleArg) node;
                return new DoubleElement(doubleArg.getValue());
            } else if (node instanceof IntegerArg) {
                IntegerArg integerArg = (IntegerArg) node;
                return new IntegerElement(integerArg.getValue());
            } else if (node instanceof BooleanArg) {
                BooleanArg booleanArg = (BooleanArg) node;
                return new BooleanElement(booleanArg.getValue());
            } else if (node instanceof StringArg) {
                StringArg stringArg = (StringArg) node;
                return new StringElement(stringArg.getValue());
            } else {
                throw new RuntimeException();
            }
        } else {
            throw new RuntimeException();
        }
    }

    private Property getAliasPath(List<String> parts) {
        String realPath = this.aliases.get("") + ".";
        Type currentType = this.context.getType();
        List<String> fullTablePath = Lists.newArrayList();
        for (int i = 0; i < parts.size(); i++) {
            Member member = currentType.getMember(parts.get(i));
            if (member instanceof Containment) {
                Containment containment = (Containment) member;
                if (containment.list) {
                    fullTablePath = parts.subList(0, i + 1);
                    String alias = this.aliases.get(Names.joinPath(fullTablePath));
                    realPath = alias + ".";
                } else {
                    realPath = realPath + containment.name + "_";
                }
                currentType = containment.resourceType;
            } else if (member instanceof Reference) {
                Reference reference = (Reference) member;
                fullTablePath = parts.subList(0, i + 1);
                String alias = this.aliases.get(Names.joinPath(fullTablePath));
                realPath = alias + ".";
                currentType = reference.resourceType;
            } else if (member instanceof Attribute) {
                realPath = realPath + member.name;
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
        if (node instanceof MethodCall) {
            MethodCall methodCall = (MethodCall) node;
            paths.add(Names.joinPath(methodCall.getPath()));
        }
        for (Node child : node.getChildren()) {
            collectAllPaths(child, paths);
        }
    }

    private void joinTables() {
        this.aliases.put("", "tab0");
        List<String> allPaths = Lists.newArrayList();
        collectAllPaths(this.node, allPaths);
        for (String path : allPaths) {
            List<String> parts = Lists.newArrayList(path.split("\\."));
            Type fromType = this.context.getType();
            List<String> tablePath = Lists.newArrayList();
            for (int i = 0; i < parts.size(); i++) {
                Member member = fromType.getMember(parts.get(i));
                if (member instanceof Attribute) {
                    break;
                } else if (member instanceof Containment) {
                    Containment containment = (Containment) member;
                    Type toType = containment.resourceType;
                    if (containment.list) {
                        updateJoins(tablePath, tablePath = parts.subList(0, i + 1), new Join(fromType, containment, toType));
                    }
                    fromType = toType;
                } else if (member instanceof Reference) {
                    Reference reference = (Reference) member;
                    Type toType = reference.resourceType;
                    updateJoins(tablePath, tablePath = parts.subList(0, i + 1), new Join(fromType, reference, toType));
                    fromType = toType;
                }
            }
        }
    }

    private List<JoinElement> buildJoins() {
        List<JoinElement> joinElements = Lists.newArrayList();
        for (Join join : this.joins) {
            List<JoinElement> elements = toJoinString(join);
            if (elements != null) {
                joinElements.addAll(elements);
            }
        }
        return joinElements;
    }

    private int aliasCounter = 1;

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

    private List<JoinElement> toJoinString(Join join) {
        List<JoinElement> joinElements = Lists.newArrayList();
        if (join.via instanceof Containment) {
            // Join from Type to SubResourceType
            Containment containment = (Containment) join.via;
            if (containment.list) {
                String table = Names.getTableName(join.to, this.context.getAllTypes());
                List<Property> fromKeys = Names.getKeys(join.aliasFrom, join.from, this.context.getAllTypes());
                List<Property> toKeys = Names.getKeys(join.aliasTo, join.to, this.context.getAllTypes());
                joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys.subList(0, toKeys.size() - 1)));
                return joinElements;
            }
        } else if (join.via instanceof Reference && join.from instanceof ReferenceType) {
            // Join from ReferenceType to RootResourceType
            String table = Names.getTableName(join.to, this.context.getAllTypes());
            String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.to);
            List<Property> fromKeys = Lists.newArrayList(new Property(join.aliasFrom, propertyName));
            List<Property> toKeys = Lists.newArrayList(new Property(join.aliasTo, "id"));
            joinElements.add(toJoinString(table, join.aliasTo, fromKeys, toKeys));
            return joinElements;
        } else if (join.via instanceof Reference) {
            // Join from RootResourceType to RootResourceType
            Reference reference = (Reference) join.via;
            {
                String table = Names.getTableName(reference.referenceType, this.context.getAllTypes());
                List<Property> fromKeys = Names.getKeys(join.aliasFrom, join.from, this.context.getAllTypes());
                String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.from);
                List<Property> toKeys = Lists.newArrayList(prop(table, propertyName));
                joinElements.add(toJoinString(table, table, fromKeys, toKeys));
            }
            {
                String table = Names.getTableName(join.to, this.context.getAllTypes());
                String propertyName = Names.getReferenceTableIdProperty((RootResourceType) join.to);
                List<Property> fromKeys = Lists.newArrayList(prop(Names.getTableName(reference.referenceType, this.context.getAllTypes()), propertyName));
                List<Property> toKeys = Names.getKeys(join.aliasTo, reference.resourceType, this.context.getAllTypes());
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

    @Override
    public Element getElement(Node node) {
        return buildElement(node);
    }

}
