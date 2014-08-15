package de.fhws.rdsl.querylang;

import java.io.IOException;
import java.io.StringReader;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.FormatterProvider;
import de.fhws.rdsl.querylang.function.FunctionProvider;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.parser.NodeParser;
import de.fhws.rdsl.querylang.schema.Schema;

public class DefaultQueryTransformer implements QueryTransformer {

    private Provider<NodeParser> nodeParser;
    private Provider<NodeTransformer> nodeTransformer;
    private Provider<ElementTransformer> elementTransformer;
    private FormatterProvider formatterProvider;
    private FunctionProvider functionProvider;

    public DefaultQueryTransformer(Provider<NodeParser> nodeParser, Provider<NodeTransformer> nodeTransformer, Provider<ElementTransformer> elementTransformer,
            FormatterProvider formatterProvider, FunctionProvider functionProvider) {
        super();
        this.nodeParser = nodeParser;
        this.nodeTransformer = nodeTransformer;
        this.elementTransformer = elementTransformer;
        this.formatterProvider = formatterProvider;
        this.functionProvider = functionProvider;
    }

    @Override
    public Map<String, Object> transform(Query query, String name, Schema schema, Map<String, String> parameters) throws IOException {
        TransformerContext context = new TransformerContext(schema, name, query, this.functionProvider, this.formatterProvider, parameters);
        Node node = this.nodeParser.get().parse(new StringReader(query.getText()));
        Element element = this.nodeTransformer.get().transform(node, context);
        Map<String, Object> map = this.elementTransformer.get().transform(element, context);
        return map;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
