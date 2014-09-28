package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class RiakTestSuiteRunnerClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg
	@Inject @Named(DB_RIAK_TEST_PACKAGE) protected String dbRiakTestPckg
	@Inject @Named(TEST_CONNECTION_FILE) protected String testConnectionFile

	override protected createJavaClass() {

	
		return new JavaClass => [
			name = "RiakTestSuiteRunner"
			pckg = dbRiakTestPckg
			content = '''

			public class «name» extends «type("org.junit.runners.Suite")» {
				
				public «name»(Class<?> klass, «type("org.junit.runners.model.RunnerBuilder")» builder) throws «type("org.junit.runners.model.InitializationError")» {
					super(klass, new «type(dbTestPckg, "GuiceRunnerBuilder")»(createModule()));
				}
				
				public «name»(RunnerBuilder builder, Class<?>[] classes) throws InitializationError {
					super(new GuiceRunnerBuilder(createModule()), classes);
				}
				
				private static «type("com.google.inject.Module")» createModule() {
					return new «type("com.google.inject.AbstractModule")»() {
						@Override
						protected void configure() {
							bind(«type(commonDbPckg, "SessionFactory")».class).to(«type(dbRiakPckg, "RiakSessionFactory")».class);
							bind(«type("de.fhws.rdsl.riak.JSONConverter")».class).to(«type("de.fhws.rdsl.riak.DefaultJSONConverter")».class);
							bind(«type(dbSpiPckg, "DistributedLock")».class).to(NopDistributedLock.class);
							bind(«type("de.fhws.rdsl.riak.RiakSource")».class).toProvider(RiakDataSourceProvider.class);
						}
					};
				}
				
				private static class RiakDataSourceProvider implements «type("javax.inject.Provider")»<RiakSource> {
					
					@«type("javax.inject.Inject")»
					protected «type("de.fhws.rdsl.riak.JSONConverter")» jsonConverter;
					
					@Override
					public RiakSource get() {
						try {
							byte[] bytes = «type("com.google.common.io.Files")».toByteArray(new «type("java.io.File")»("«testConnectionFile»"));
							«type("de.fhws.rdsl.riak.DefaultRiakSource")» dataSource = new «type("de.fhws.rdsl.riak.DefaultRiakSource")»();
							«type("org.json.JSONObject")» jsonObject = jsonConverter.fromBytes(bytes, "UTF-8");
							dataSource.setHost(jsonObject.getString("host"));
							dataSource.setPort(jsonObject.getInt("port"));
							dataSource.setPoolSize(jsonObject.getInt("poolSize"));
							dataSource.setQueryPoolSize(jsonObject.getInt("queryPoolSize"));
							dataSource.setQueryPort(jsonObject.getInt("queryPort"));
							return dataSource;
						} catch («type("java.io.IOException")» | «type("org.json.JSONException")» e) {
							throw new RuntimeException(e);
						}
					}	
				}
				
				public static class NopDistributedLock implements DistributedLock {
					@Override
					public «type("java.util.concurrent.locks.Lock")» getLock(Object obj) {
						return new Lock() {
				
							@Override
							public void unlock() {
							}
				
							@Override
							public boolean tryLock(long time, «type("java.util.concurrent.TimeUnit")» unit) throws InterruptedException {
								return true;
							}
				
							@Override
							public boolean tryLock() {
								return true;
							}
				
							@Override
							public «type("java.util.concurrent.locks.Condition")» newCondition() {
								return null;
							}
				
							@Override
							public void lockInterruptibly() throws InterruptedException {
							}
				
							@Override
							public void lock() {
							}
						};
					}
				}
				
			}
			


			'''
		]
	}

}
