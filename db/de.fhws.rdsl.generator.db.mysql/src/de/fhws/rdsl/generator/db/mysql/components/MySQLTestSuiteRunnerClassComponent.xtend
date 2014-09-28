package de.fhws.rdsl.generator.db.mysql.components

import javax.inject.Inject
import javax.inject.Named
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class MySQLTestSuiteRunnerClassComponent extends AbstractComponent implements MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg
	@Inject @Named(DB_MYSQL_CONVERTERS_PACKAGE) protected String dbMySqlConvertersPckg
	@Inject @Named(TEST_CONNECTION_FILE) protected String testConnectionFile
	@Inject @Named(DB_MYSQL_TEST_PACKAGE) protected String dbMySqlTestPckg

	override protected createJavaClass() {

		return new JavaClass => [
			name = "MySQLTestSuiteRunner"
			pckg = dbMySqlTestPckg
			content = '''
			

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import javax.sql.DataSource;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.junit.runners.Suite;
import org.junit.runners.model.InitializationError;
import org.junit.runners.model.RunnerBuilder;

import com.google.common.io.Files;
import com.google.inject.AbstractModule;
import com.google.inject.Module;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;


public class «name» extends Suite {

    public «name»(Class<?> klass, org.junit.runners.model.RunnerBuilder builder) throws org.junit.runners.model.InitializationError {
        super(klass, new «dbTestPckg».GuiceRunnerBuilder(createModule()));
    }

    public «name»(RunnerBuilder builder, Class<?>[] classes) throws InitializationError {
        super(new «dbTestPckg».GuiceRunnerBuilder(createModule()), classes);
    }

    private static Module createModule() {
        return new AbstractModule() {
            @Override
            protected void configure() {
                bind(DataSource.class).toInstance(getDataSource());
                bind(«commonDbPckg».SessionFactory.class).to(«dbMySqlPckg».MySQLSessionFactory.class);
            }

			private DataSource getDataSource() {
				try {
					byte[] bytes = Files.toByteArray(new File("«testConnectionFile»"));					
					JSONObject jsonObject = fromBytes(bytes, "UTF-8");
					MysqlDataSource dataSource = new MysqlDataSource();
					String host = get(jsonObject, "host");
					int port = get(jsonObject, "port");
					String db = get(jsonObject, "database");
					String user = get(jsonObject, "user");
					String password = get(jsonObject, "password");
					String url = "jdbc:mysql://" + host + ":" + port + "/" + db;
					if (user != null) {
						url += "?user=" + user + "&password=" + password;
					}
					dataSource.setUrl(url);
					return dataSource;
				} catch (IOException e) {
					throw new RuntimeException(e);
				}

			}

			private <T> T get(JSONObject object, String field) {
				try {
					Object o = object.get(field);
					if (o == JSONObject.NULL) {
						return null;
					} else {
						return (T) o;
					}
				} catch (JSONException e) {
					return null;
				}
			}

			private JSONObject fromBytes(byte[] bytes, String encoding) {
				try {
					JSONTokener tokener = new JSONTokener(new InputStreamReader(new ByteArrayInputStream(bytes), encoding));
					JSONObject root = new JSONObject(tokener);
					return root;
				} catch (UnsupportedEncodingException | JSONException e) {
					throw new RuntimeException(e);
				}
			}
        };
    }
}
			'''
		]
	}

}
