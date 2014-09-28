package de.fhws.rdsl.generator.db.mysql.components

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import javax.inject.Inject
import javax.inject.Named

class MySQLQueryTransformerProviderClassComponent extends AbstractComponent implements de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg

	override protected createJavaClass() {

		return new JavaClass => [
			pckg = dbMySqlPckg
			name = "MySQLQueryTransformerProvider"
			content = '''		
				public class «name» implements «type(dbSpiPckg, "QueryTransformerProvider")» {
				
					private «type("de.fhws.rdsl.query.transformer.spi.FunctionProvider")» functionProvider;
					private «type("de.fhws.rdsl.query.transformer.spi.FormatterProvider")» formatterProvider;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.QueryParser")»> queryParser;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.NodeTransformer")»> nodeTransformer;
					private «type("javax.inject.Provider")»<«type("de.fhws.rdsl.query.transformer.spi.ElementTransformer")»> elementTransformer;
				
					@«type("javax.inject.Inject")»
					public «name»(
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
						if("querylang".equals(source) && "sql".equals(target)) {
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
