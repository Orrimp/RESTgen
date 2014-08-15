package de.fhws.rdsl.querylang;

import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.formatter.Formatter;
import de.fhws.rdsl.querylang.formatter.FormatterProvider;
import de.fhws.rdsl.querylang.function.FunctionProvider;
import de.fhws.rdsl.querylang.schema.Schema;

public class TransformerContext {

    private Schema schema;
    private Query query;
    private FunctionProvider functionProvider;
    private FormatterProvider formatterProvider;
    private String typeName;
    private Map<String, String> parameters;

    public TransformerContext(Schema schema, String typeName, Query query, FunctionProvider functionProvider, FormatterProvider formatterProvider,
            Map<String, String> parameters) {
        super();
        this.schema = schema;
        this.query = query;
        this.functionProvider = functionProvider;
        this.formatterProvider = formatterProvider;
        this.typeName = typeName;
        this.parameters = parameters;
    }

    public Map<String, String> getParameters() {
        return this.parameters;
    }

    public String getTypeName() {
        return this.typeName;
    }

    public FormatterProvider getFormatterProvider() {
        return this.formatterProvider;
    }

    public FunctionProvider getFunctionProvider() {
        return this.functionProvider;
    }

    public Query getQuery() {
        return this.query;
    }

    public Schema getSchema() {
        return this.schema;
    }

    public String format(Element element) {
        Formatter formatter = this.formatterProvider.getFormatter(element);
        if (formatter == null) {
            throw new RuntimeException("Formatter for element " + element + " not found");
        }
        return formatter.format(element, this);
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
