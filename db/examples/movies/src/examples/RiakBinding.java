package examples;

import javax.inject.Provider;

import mypckg.db.api.QueryService;
import mypckg.db.api.SessionFactory;
import mypckg.db.impl.DefaultSchema;
import mypckg.db.impl.riak.RiakQueryService;
import mypckg.db.impl.riak.RiakQueryTransformerProvider;
import mypckg.db.impl.riak.RiakSessionFactory;
import mypckg.db.spi.DistributedLock;
import mypckg.db.spi.QueryTransformerProvider;
import mypckg.db.test.impl.riak.RiakTestSuiteRunner.NopDistributedLock;

import org.junit.Test;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;

import de.fhws.rdsl.query.transformer.antlr.DefaultQueryParser;
import de.fhws.rdsl.query.transformer.api.schema.Schema;
import de.fhws.rdsl.query.transformer.solr.SolrElementTransformer;
import de.fhws.rdsl.query.transformer.solr.SolrFormatterProvider;
import de.fhws.rdsl.query.transformer.solr.SolrFunctionProvider;
import de.fhws.rdsl.query.transformer.solr.SolrNodeTransformer;
import de.fhws.rdsl.query.transformer.spi.ElementTransformer;
import de.fhws.rdsl.query.transformer.spi.FormatterProvider;
import de.fhws.rdsl.query.transformer.spi.FunctionProvider;
import de.fhws.rdsl.query.transformer.spi.NodeTransformer;
import de.fhws.rdsl.query.transformer.spi.QueryParser;
import de.fhws.rdsl.riak.DefaultJSONConverter;
import de.fhws.rdsl.riak.DefaultRiakSolrClient;
import de.fhws.rdsl.riak.DefaultRiakSource;
import de.fhws.rdsl.riak.JSONConverter;
import de.fhws.rdsl.riak.RiakSolrClient;
import de.fhws.rdsl.riak.RiakSource;

public class RiakBinding {

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
				bind(SessionFactory.class).to(RiakSessionFactory.class);
				bind(JSONConverter.class).to(DefaultJSONConverter.class);
				bind(DistributedLock.class).to(NopDistributedLock.class);
				bind(RiakSource.class).toInstance(new DefaultRiakSource() {
					{
						setHost("riak");
						setPoolSize(10);
						setPort(10017);
						setQueryPoolSize(10);
						setQueryPort(10018);
					}
				});
				bind(QueryService.class).to(RiakQueryService.class);
				bind(RiakSolrClient.class).toInstance(new DefaultRiakSolrClient("riak", 10118));
				bind(Schema.class).to(DefaultSchema.class);
				bind(QueryTransformerProvider.class).to(RiakQueryTransformerProvider.class);
				bind(QueryParser.class).toProvider(QueryParserProvider.class);
				bind(NodeTransformer.class).toProvider(NodeTransformerProvider.class);
				bind(ElementTransformer.class).toProvider(ElementTransformerProvider.class);
				bind(FunctionProvider.class).to(SolrFunctionProvider.class);
				bind(FormatterProvider.class).to(SolrFormatterProvider.class);

			}
		});
		return injector;
	}

	static class NodeTransformerProvider implements Provider<NodeTransformer> {
		@Override
		public NodeTransformer get() {
			return new SolrNodeTransformer();
		}
	}

	static class ElementTransformerProvider implements Provider<ElementTransformer> {
		@Override
		public ElementTransformer get() {
			return new SolrElementTransformer();
		}
	}

	static class QueryParserProvider implements Provider<QueryParser> {
		@Override
		public QueryParser get() {
			return new DefaultQueryParser();
		}
	}

}
