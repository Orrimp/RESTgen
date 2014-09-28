package examples;

import mypckg.db.api.QueryResult;
import mypckg.db.api.QueryService;
import mypckg.db.api.Session;
import mypckg.db.api.SessionFactory;
import mypckg.db.api.data.DefaultResourceIdentifier;
import mypckg.db.api.data.MovieData;
import mypckg.db.api.data.SynopsisData;

import org.junit.Test;

import com.google.inject.Injector;

import de.fhws.rdsl.query.Query;

public class MySQLExample {

	@Test
	public void test() throws Exception {
		Injector injector = MySQLBinding.getInjector();
		SessionFactory factory = injector.getInstance(SessionFactory.class);
		QueryService queryService = injector.getInstance(QueryService.class);

		try (Session session = factory.createSession()) {
			session.updateMovie(null, new MovieData() {
				{
					setIdentifier(new DefaultResourceIdentifier("alien"));
					setTitle("Alien");
					setRevision("1");
				}
			});
			session.updateSynopsis(null, new SynopsisData() {
				{
					setIdentifier(new DefaultResourceIdentifier("alien", "alien-synopsis"));
					setText("Alien Movie");
					setAuthor("Leonid");
				}
			});
			QueryResult<MovieData> result1 = queryService.queryMovie(new Query() {
				{
					setLanguage("querylang");
					setSize(10L);
					setStart(0L);
					setText("title.eq(\"Alien\") && description.author.eq(\"Leonid\")");
				}
			});
			System.out.println("Found: " + result1.getTotalCount());
			System.out.println(result1.getResult());

			QueryResult<SynopsisData> result2 = queryService.querySynopsis(new Query() {
				{
					setLanguage("querylang");
					setSize(10L);
					setStart(0L);
					setText("_movieId.eq(\"alien\")");
				}
			});
			System.out.println("Found: " + result2.getTotalCount());
			System.out.println(result2.getResult());

			session.deleteMovie("1", new DefaultResourceIdentifier("alien"));
		}

	}
}
