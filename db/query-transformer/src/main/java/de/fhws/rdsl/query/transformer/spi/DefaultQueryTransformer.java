package de.fhws.rdsl.query.transformer.spi;

import java.io.IOException;
import java.io.StringReader;
import java.util.Map;

import javax.inject.Provider;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import de.fhws.rdsl.query.transformer.api.QueryTransformer;
import de.fhws.rdsl.query.transformer.api.QueryTransformerParameters;
import de.fhws.rdsl.query.transformer.spi.source.SourceNode;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class DefaultQueryTransformer implements QueryTransformer {

	private Provider<QueryParser> nodeParser;
	private Provider<NodeTransformer> nodeTransformer;
	private Provider<ElementTransformer> elementTransformer;
	private FormatterProvider formatterProvider;
	private FunctionProvider functionProvider;

	public DefaultQueryTransformer(Provider<QueryParser> nodeParser, Provider<NodeTransformer> nodeTransformer,
	        Provider<ElementTransformer> elementTransformer, FormatterProvider formatterProvider, FunctionProvider functionProvider) {
		super();
		this.nodeParser = nodeParser;
		this.nodeTransformer = nodeTransformer;
		this.elementTransformer = elementTransformer;
		this.formatterProvider = formatterProvider;
		this.functionProvider = functionProvider;
	}

	@Override
	public Map<String, Object> transform(QueryTransformerParameters parameterObject) throws IOException {
		TransformerContext context = new TransformerContext(parameterObject, this.functionProvider, this.formatterProvider);
		SourceNode node = this.nodeParser.get().parse(new StringReader(parameterObject.query.getText()));
		TargetElement element = this.nodeTransformer.get().transform(node, context);
		Map<String, Object> map = this.elementTransformer.get().transform(element, context);
		return map;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}

}
