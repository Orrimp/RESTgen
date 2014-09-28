package de.fhws.rdsl.generator.db.mysql.components


import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableContainment
import java.util.List

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class SQLQueryServiceClassComponent extends AbstractComponent implements MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg
	@Inject @Named(DB_MYSQL_CONVERTERS_PACKAGE) protected String dbMySqlConvertersPckg
	
	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		
		return new JavaClass => [
			name = "SQLQueryService"
			pckg = dbMySqlPckg
			content =
			'''
			public class «name» implements «type(commonDbPckg, "QueryService")» {
				
				private «type("javax.sql.DataSource")» dataSource;
				private «type(dbSpiPckg, "QueryTransformerProvider")» queryTransformerProvider;
				private «type("de.fhws.rdsl.query.transformer.api.schema.Schema")» schema;
				private «type("de.fhws.rdsl.query.transformer.spi.FunctionProvider")» functionProvider;
			
				@«type("javax.inject.Inject")»
				public «name»(DataSource dataSource, QueryTransformerProvider queryTransformerProvider, Schema schema, FunctionProvider functionProvider) {
					super();
					this.dataSource = dataSource;
					this.queryTransformerProvider = queryTransformerProvider;
					this.schema = schema;
					this.functionProvider = functionProvider;
				}
			
				private <T> T connectAndReturnSafely(«type(dbPckg, "ThrowingFunction")»<T, «type("java.sql.Connection")»> function) {
					try {
						try (Connection connection = this.dataSource.getConnection()) {
							return function.apply(this.dataSource.getConnection());
						}
					} catch (Exception e) {
						handleException(e);
						return null; // Will never be called.
					}
				}
			
				protected void handleException(Exception t) {
					if (t instanceof «type(commonDbExceptionsPckg, "QueryException")») {
						throw (QueryException) t;
					} else {
						throw new QueryException(t);
					}
				}
				
				private «type(commonDbPckg, "QueryResult")» find(«type("de.fhws.rdsl.query.Query")» query, String table, «type(dbMySqlPckg, "ResultSetConverter")» converter) {
					return connectAndReturnSafely(connection -> {
						«type("java.util.Map")»<String, Object> transformResult = getTransformer(query.getLanguage()).transform(new «type("de.fhws.rdsl.query.transformer.api.QueryTransformerParameters")»(query, table, this.schema, «type("java.util.Collections")».emptyMap()));
						QueryResult response = new QueryResult();
						String sqlCountQuery = (String) transformResult.get("sqlCountQuery");
						if (sqlCountQuery != null) {
							response.setTotalCount(executeCountQuery(sqlCountQuery, connection));
						}
						String sqlQuery = (String) transformResult.get("sqlQuery");
						«type("java.util.List")»<?> result = executeQuery(sqlQuery, connection, converter);
						response.getResult().addAll(result);
						return response;
					});
				}
			
				private Long executeCountQuery(String sqlQuery, Connection connection) throws «type("java.sql.SQLException")» {
					try («type("java.sql.Statement")» statement = connection.createStatement()) {
						try («type("java.sql.ResultSet")» resultSet = statement.executeQuery(sqlQuery)) {
							while (resultSet.next()) {
								return resultSet.getLong(1);
							}
						}
					}
					return 0l;
				}
			
				private List<?> executeQuery(String sqlQuery, Connection connection, ResultSetConverter converter) throws Exception {
					try (Statement statement = connection.createStatement()) {
						try (ResultSet resultSet = statement.executeQuery(sqlQuery)) {
							List<«type(commonDbDataPckg, "Data")»<?>> result = new «type("java.util.ArrayList")»<Data<?>>();
							while (resultSet.next()) {
								result.add((Data) converter.convert(resultSet));
							}
							return result;
						}
					}
				}
				
				private «type("de.fhws.rdsl.query.transformer.api.QueryTransformer")» getTransformer(String language) {
					QueryTransformer transformer = this.queryTransformerProvider.getQueryTransformer(language, "sql");
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
				
				private List<«type(commonDbPckg, "QueryPath")»> getSupportedPaths() {
					List<QueryPath> paths = new ArrayList<QueryPath>();
					
					«FOR table : tables»
					«IF table instanceof ReferenceTable»
					paths.add(new QueryPath("«table.name»", "«table.keys.get(0)»"));
					paths.add(new QueryPath("«table.name»", "«table.keys.get(1)»"));
					«ENDIF»
					«FOR member : table.members.filter(TableContainment)»
					paths.add(new QueryPath("«table.name»", "«member.name»"));
					«ENDFOR»			
					«FOR member : table.members.filter(TableReference)»
					paths.add(new QueryPath("«table.name»", "«member.name»"));
					«ENDFOR»		
					«ENDFOR»
										
					return paths;
				}
				
				«FOR table : tables.filter[it.actualTable == it]»
				
				@Override
				public «type(commonDbPckg, "QueryResult")»<«type(commonDbDataPckg, table.name + "Data")»> query«table.name»(«type("de.fhws.rdsl.query.Query")» query) {
					return find(query, "«table.name»", new «type(dbMySqlConvertersPckg, "To" + table.name + "Converter")»());
				}
				
				«ENDFOR»
				
			}
			'''
		]
	}

}
