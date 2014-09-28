package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class FromJSONObjectConverterClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg

	override protected createJavaClass() {

		return new JavaClass => [
			pckg = dbRiakConvertersPckg
			name = "FromJSONObjectConverter"
			content = '''		
				public interface «name»<R> extends «type(dbPckg, "Converter")»<R, «type("org.json.JSONObject")»> {
				
				}
			'''
		]
	}

}
