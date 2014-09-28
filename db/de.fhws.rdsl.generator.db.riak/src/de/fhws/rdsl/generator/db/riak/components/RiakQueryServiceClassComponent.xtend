package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableContainment
import java.util.List
import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class RiakQueryServiceClassComponent extends AbstractComponent implements RiakConfigurationKeys {
	
	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg
	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg
	
	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "RiakQueryService"
			pckg = dbRiakPckg
			content = '''
				public class «name» implements «type(commonDbPckg, "QueryService")» {
					
					private «type("de.fhws.rdsl.riak.RiakSolrClient")» solrClient;
					private «type(dbSpiPckg, "QueryTransformerProvider")» queryTransformerProvider;
					private «type("de.fhws.rdsl.query.transformer.api.schema.Schema")» schema;
					private «type("de.fhws.rdsl.query.transformer.spi.FunctionProvider")» functionProvider;
				
					@«type("javax.inject.Inject")»
					public «name»(RiakSolrClient solrClient, QueryTransformerProvider queryTransformerProvider, Schema schema, FunctionProvider functionProvider) {
						super();
						this.solrClient = solrClient;
						this.queryTransformerProvider = queryTransformerProvider;
						this.schema = schema;
						this.functionProvider = functionProvider;
					}
				
					private «type(commonDbPckg, "QueryResult")» find(«type("de.fhws.rdsl.query.Query")» query, String index, «type(dbRiakConvertersPckg, "FromJSONObjectConverter")» converter) {
						try {
							«type("java.util.Map")»<String, Object> transformResult = getTransformer(query.getLanguage()).transform(new «type("de.fhws.rdsl.query.transformer.api.QueryTransformerParameters")»(query, index, this.schema, «type("java.util.Collections")».emptyMap()));
							String solrQuery = (String) transformResult.get("solrQuery");
							«type(commonDbPckg, "QueryResult")» result = executeQuery(solrQuery, index, converter);
							return result;
						} catch (Exception e) {
							throw new «type(commonDbExceptionsPckg, "QueryException")»(e);
						}
					}				
				
					private QueryResult executeQuery(String sqlQuery, String index, FromJSONObjectConverter converter) throws Exception {
						«type("de.fhws.rdsl.riak.RiakSolrResponse")» solrResponse = this.solrClient.query(index, sqlQuery);
						QueryResult queryResponse = new QueryResult();
						queryResponse.setTotalCount(solrResponse.getNumFound());
						for («type("de.fhws.rdsl.riak.Doc")» doc : solrResponse.getDocs()) {
							«type(commonDbDataPckg, "Data")» data = (Data) converter.convert(doc.getFields());
							queryResponse.getResult().add(data);
						}
						return queryResponse;
					}
								
					private «type("de.fhws.rdsl.query.transformer.api.QueryTransformer")» getTransformer(String language) {
						«type("de.fhws.rdsl.query.transformer.api.QueryTransformer")» transformer = this.queryTransformerProvider.getQueryTransformer(language, "sql");
						if (transformer == null) {
							throw new QueryException("Unsupported query language: " + language + " -> sql");
						} else {
							return transformer;
						}
					}
				
					@Override
					public «type(commonDbPckg, "QuerySpecification")» getSpecification() {
						return new QuerySpecification(getSupportedPaths(), getSupportedFunctions());
					}
					
					private List<«type("de.fhws.rdsl.query.FunctionDescription")»> getSupportedFunctions() {
						return this.functionProvider.getFunctions().stream().map(f -> f.getDescription()).collect(«type("java.util.stream.Collectors")».toList());
					}
					
					private «type("java.util.List")»<«type(commonDbPckg, "QueryPath")»> getSupportedPaths() {
						List<QueryPath> paths = new «type("java.util.ArrayList")»<QueryPath>();
						
						«FOR table : tables»
							«FOR member : table.members.filter(TableContainment).filter[list]»
								paths.add(new QueryPath("«table.name»", "«member.name»"));
							«ENDFOR»			
						«ENDFOR»
						
						return paths;
					}
					
					«FOR table : tables.filter[it.actualTable == it]»
						
						@Override
						public «type(commonDbPckg, "QueryResult")»<«type(commonDbDataPckg, table.name + "Data")»> query«table.name»(«type("de.fhws.rdsl.query.Query")» query) {
							return find(query, "«table.name»", new «type(dbRiakConvertersPckg, "To" + table.name + "Converter")»());
						}
						
					«ENDFOR»
					
				}
			'''
		]
	}

}
