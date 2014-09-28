package de.fhws.rdsl.query.transformer.spi;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import de.fhws.rdsl.query.transformer.api.QueryTransformerParameters;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class TransformerContext {

	private FunctionProvider functionProvider;
	private FormatterProvider formatterProvider;
	private QueryTransformerParameters queryTransformerParameters;

	public TransformerContext(QueryTransformerParameters queryTransformerParameters, FunctionProvider functionProvider, FormatterProvider formatterProvider) {
		super();
		this.functionProvider = functionProvider;
		this.formatterProvider = formatterProvider;
		this.queryTransformerParameters = queryTransformerParameters;
	}

	public FormatterProvider getFormatterProvider() {
		return this.formatterProvider;
	}

	public FunctionProvider getFunctionProvider() {
		return this.functionProvider;
	}

	public QueryTransformerParameters getQueryTransformerParameters() {
		return this.queryTransformerParameters;
	}

	public String format(TargetElement element) {
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
