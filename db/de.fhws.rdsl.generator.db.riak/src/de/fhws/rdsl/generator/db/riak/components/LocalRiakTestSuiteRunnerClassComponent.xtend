package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class LocalRiakTestSuiteRunnerClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg
	@Inject @Named(DB_RIAK_TEST_PACKAGE) protected String dbRiakTestPckg

	override protected createJavaClass() {

	
		return new JavaClass => [
			name = "LocalRiakTestSuiteRunner"
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
							bind(«type(commonDbPckg, "SessionFactory")».class).to(RiakSessionFactoryMock.class);
							bind(«type("de.fhws.rdsl.riak.JSONConverter")».class).to(«type("de.fhws.rdsl.riak.DefaultJSONConverter")».class);
							bind(«type(dbSpiPckg, "DistributedLock")».class).to(NopDistributedLock.class);
							bind(«type("de.fhws.rdsl.riak.RiakSource")».class).toInstance(getRiakSource());
						}

						private RiakSource getRiakSource() {
							return new RiakSource() {

								@Override
								public «type("de.fhws.rdsl.riak.RiakConnection")» getConnection() {
									return new «type("de.fhws.rdsl.riak.RiakConnectionMock")»();
								}

								@Override
								public void dispose() {
									// TODO Auto-generated method stub
								}
							};
						}
					};
				}
				
				public static class RiakSessionFactoryMock implements SessionFactory {
					@javax.inject.Inject
					protected JSONConverter jsonConverter;

					@Override
					public void close() throws Exception {
					}

					@Override
					public «type(commonDbPckg, "Session")» createSession() {
						return new «type(dbRiakPckg, "RiakSession")»(new «type("de.fhws.rdsl.riak.RiakConnectionMock")»(), this.jsonConverter, new NopDistributedLock());
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
