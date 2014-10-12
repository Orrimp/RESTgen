package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.workflow.JavaClass
import java.util.List
import javax.inject.Inject
import javax.inject.Named

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.rdsl.PrimitiveType
import de.fhws.rdsl.generator.table.DateAttribute

class FromJSONObjectConverterClassesComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg

	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return tables.map [ table |
			return new JavaClass => [
				name = "To" + table.name + "Converter"
				pckg = dbRiakConvertersPckg
				content = '''
					public class «name» implements «type(dbRiakConvertersPckg, "FromJSONObjectConverter")»<«type(commonDbDataPckg, table.name + "Data")»> {
						
						@Override
						public «table.name»Data convert(«type("org.json.JSONObject")» _from) {	
							try {
								return new «table.name»Data() {
									{
										«IF table instanceof ReferenceTable»
											setIdentifier(										
												new «type(commonDbDataPckg, "DefaultReferenceIdentifier")»(
													new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(_from.getString("«table.keys.get(0)»")),
													new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(_from.getString("«table.keys.get(1)»"))
												)										
											);
										«ELSE»
											setIdentifier(										
												new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(
												«FOR key : table.keys SEPARATOR ', '»
													_from.getString("«key»")
												«ENDFOR»
												)										
											);																		
										«ENDIF»
										setRevision(_from.getString("«table.revisionField»"));
										«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»									
											try {
												Object _obj = _from.get("«attr.actualAttributeName»");
												if(_obj == JSONObject.NULL) {
													set«attr.name.toFirstUpper»(null);
												} else {
													«IF attr instanceof DateAttribute»
													set«attr.name.toFirstUpper»(«type("org.apache.commons.lang3.time.DateFormatUtils")».ISO_DATETIME_TIME_ZONE_FORMAT.parse((String) _obj));													
													«ELSE»
													set«attr.name.toFirstUpper»((«attr.javaType») _obj);
													«ENDIF»
												}
											} catch(Exception e) {
												set«attr.name.toFirstUpper»(null);
											}
										«ENDFOR»
										«FOR ref : table.members.filter(TableReference).filter[!list]»
											try {
												Object _obj = _from.get("«ref.name»");
												if(_obj == JSONObject.NULL) {
													this.«ref.name» = null;
												} else {
													this.«ref.name» = new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(String.valueOf(_obj));
												}
											} catch(«type("org.json.JSONException")» e) {
												this.«ref.name» = null;
											}
										«ENDFOR»	
									}
								};
							} catch(«type("org.json.JSONException")» e) {
								throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
							}
						}
					}
				'''
			]
		].toList
	}

}
