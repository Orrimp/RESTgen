package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.workflow.JavaClass
import java.util.List
import javax.inject.Inject
import javax.inject.Named

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.rdsl.PrimitiveType
import de.fhws.rdsl.generator.table.DateAttribute

class ToJSONObjectConverterClassesComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg

	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return tables.map [ table |
			return new JavaClass => [
				name = "From" + table.name + "Converter"
				pckg = dbRiakConvertersPckg
				content = '''
					public class «name» implements «type(dbRiakConvertersPckg, "ToJSONObjectConverter")»<«type(commonDbDataPckg, table.name + "Data")»> {
							
						private JSONObject toUpdate;
						
						public From«table.name»Converter(«type("org.json.JSONObject")» toUpdate) {
							super();
							this.toUpdate = toUpdate;
						}
						
						@Override
						public JSONObject convert(«table.name»Data _from) {
							try {
								JSONObject data = this.toUpdate == null ? new JSONObject() : this.toUpdate;
								«IF table instanceof ReferenceTable»
									data.put("«table.keys.get(0)»", _from.getIdentifier().getId1().getSegment(0));
									data.put("«table.keys.get(1)»", _from.getIdentifier().getId2().getSegment(0));
								«ELSE»
									// «var counter = 0»
										«FOR key : table.keys»
											data.put("«key»", _from.getIdentifier().getSegment(«counter»)); // «counter = counter + 1»
										«ENDFOR»																	
								«ENDIF»
								data.put("«table.revisionField»", _from.getRevision());
								data.put("_dummy", 1); // Dummy field for Solr Search
								«IF table.baseField != null»
									data.put("«table.baseField»", 1);
								«ENDIF»
								
								«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
								«IF attr instanceof DateAttribute»
									data.put("«attr.actualAttributeName»", «type("org.apache.commons.lang3.time.DateFormatUtils")».ISO_DATETIME_TIME_ZONE_FORMAT.format(_from.get«attr.name.toFirstUpper»()));
								«ELSE»
									data.put("«attr.actualAttributeName»", _from.get«attr.name.toFirstUpper»());
								«ENDIF»									
								«ENDFOR»									
								return data;
							} catch («type("org.json.JSONException")» e) {
								throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
							}
						}
					}
				'''
			]
		]
	}

}
