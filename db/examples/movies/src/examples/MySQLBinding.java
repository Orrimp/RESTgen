package examples;

import javax.inject.Provider;
import javax.sql.DataSource;

import mypckg.db.api.QueryService;
import mypckg.db.api.SessionFactory;
import mypckg.db.impl.DefaultSchema;
import mypckg.db.impl.mysql.MySQLQueryTransformerProvider;
import mypckg.db.impl.mysql.MySQLSessionFactory;
import mypckg.db.impl.mysql.SQLQueryService;
import mypckg.db.spi.QueryTransformerProvider;

import org.junit.Test;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import de.fhws.rdsl.query.transformer.antlr.DefaultQueryParser;
import de.fhws.rdsl.query.transformer.api.schema.Schema;
import de.fhws.rdsl.query.transformer.spi.ElementTransformer;
import de.fhws.rdsl.query.transformer.spi.FormatterProvider;
import de.fhws.rdsl.query.transformer.spi.FunctionProvider;
import de.fhws.rdsl.query.transformer.spi.NodeTransformer;
import de.fhws.rdsl.query.transformer.spi.QueryParser;
import de.fhws.rdsl.query.transformer.sql.SQLElementTransformer;
import de.fhws.rdsl.query.transformer.sql.SQLFormatterProvider;
import de.fhws.rdsl.query.transformer.sql.SQLFunctionProvider;
import de.fhws.rdsl.query.transformer.sql.SQLNodeTransformer;

public class MySQLBinding {

	@Test
	public void test() {
		Injector injector = getInjector();
		SessionFactory factory = injector.getInstance(SessionFactory.class);
		QueryService service = injector.getInstance(QueryService.class);
		System.out.println(factory);
		System.out.println(service);
	}

	static Injector getInjector() {

		

		Injector injector = Guice.createInjector(new AbstractModule() {

			@Override
			protected void configure() {
				bind(SessionFactory.class).to(MySQLSessionFactory.class);
				bind(DataSource.class).toInstance(new MysqlDataSource() {
					{
						String host = "localhost";
						String db = "test2";
						String url = "jdbc:mysql://" + host + ":" + this.port + "/" + db;
						if (this.user != null) {
							url += "?user=" + this.user + "&password=" + this.password;
						}
						setUrl(url);
					}
				});
				bind(QueryService.class).to(SQLQueryService.class);
				bind(Schema.class).to(DefaultSchema.class);
				bind(QueryTransformerProvider.class).to(MySQLQueryTransformerProvider.class);
				bind(QueryParser.class).toProvider(QueryParserProvider.class);
				bind(NodeTransformer.class).toProvider(NodeTransformerProvider.class);
				bind(ElementTransformer.class).toProvider(ElementTransformerProvider.class);
				bind(FunctionProvider.class).to(SQLFunctionProvider.class);
				bind(FormatterProvider.class).to(SQLFormatterProvider.class);

			}
		});
		return injector;
	}

	static class NodeTransformerProvider implements Provider<NodeTransformer> {
		@Override
		public NodeTransformer get() {
			return new SQLNodeTransformer();
		}
	}

	static class ElementTransformerProvider implements Provider<ElementTransformer> {
		@Override
		public ElementTransformer get() {
			return new SQLElementTransformer();
		}
	}

	static class QueryParserProvider implements Provider<QueryParser> {
		@Override
		public QueryParser get() {
			return new DefaultQueryParser();
		}
	}

}
