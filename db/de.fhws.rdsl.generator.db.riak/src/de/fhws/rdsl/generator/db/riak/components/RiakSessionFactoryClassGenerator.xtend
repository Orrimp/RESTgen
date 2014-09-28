package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.workflow.JavaClass
import javax.inject.Inject
import javax.inject.Named

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*

class RiakSessionFactoryClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg
	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg
	
	override protected createJavaClass() {
		return new JavaClass => [
			
			name = "RiakSessionFactory"
			pckg = dbRiakPckg
			content =
			'''
			public class «name» implements «type(commonDbPckg, "SessionFactory")» {

				private «type("de.fhws.rdsl.riak.RiakSource")» source;
				private «type("de.fhws.rdsl.riak.JSONConverter")» jsonConverter;
				private «type(dbSpiPckg, "DistributedLock")» distributedLock;

				private boolean closed = false;

				@«type("javax.inject.Inject")»
				public RiakSessionFactory(RiakSource source, JSONConverter jsonConverter, DistributedLock distributedLock) {
					this.source = source;
					this.jsonConverter = jsonConverter;
					this.distributedLock = distributedLock;
				}

				@Override
				public «type(commonDbPckg, "Session")» createSession() {
					if (this.closed) {
						throw new «type(commonDbExceptionsPckg, "InternalStorageException")»("Session factory is closed");
					} else {
						return new RiakSession(this.source.getConnection(), this.jsonConverter, this.distributedLock);
					}
				}

				@Override
				public void close() throws Exception {
					this.closed = true;
					this.source.dispose();
				}
			}
			'''
			
		]
	}
	
	def getParentTables(SubTable table) {
		val path = table.actualTablePath
		return path.subList(0, path.size-1);
	}

}
