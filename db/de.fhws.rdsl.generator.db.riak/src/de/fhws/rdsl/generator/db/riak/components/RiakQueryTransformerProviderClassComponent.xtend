package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class RiakQueryTransformerProviderClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg

	override protected createJavaClass() {

		return new JavaClass => [
			pckg = dbRiakPckg
			name = "RiakQueryTransformerProvider"
			content = '''		
				public class «name» implements «type(dbSpiPckg, "QueryTransformerProvider")» {
				
					private «type("de.fhws.rdsl.query.transformer.spi.FunctionProvider")» functionProvider;
					private «type("de.fhws.rdsl.query.transformer.spi.FormatterProvider")» formatterProvider;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.QueryParser")»> queryParser;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.NodeTransformer")»> nodeTransformer;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.ElementTransformer")»> elementTransformer;
				
					@«type("javax.inject.Inject")»
					public RiakQueryTransformerProvider(
							Provider<QueryParser> queryParser,
							Provider<NodeTransformer> nodeTransformer,
							Provider<ElementTransformer> elementTransformer,
							FunctionProvider functionProvider,
							FormatterProvider formatterProvider) {
						this.queryParser = queryParser;
						this.nodeTransformer = nodeTransformer;
						this.elementTransformer = elementTransformer;
						this.functionProvider = functionProvider;
						this.formatterProvider = formatterProvider;
					}
				
					@Override
					public «type("de.fhws.rdsl.query.transformer.api.QueryTransformer")» getQueryTransformer(String source, String target) {
						if("querylang".equals(source) && "solr".equals(target)) {
							return new «type("de.fhws.rdsl.query.transformer.spi.DefaultQueryTransformer")»(queryParser, nodeTransformer, elementTransformer, formatterProvider, functionProvider);
						} else {
							return null;
						}
					}
				
				}
			'''
		]
	}

}
