package de.fhws.rdsl.generator.db.mysql.components


import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import java.util.List
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.Table

class ResultSetConverterClassesComponent extends AbstractComponent implements MySQLConfigurationKeys {
	
	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg
	@Inject @Named(DB_MYSQL_CONVERTERS_PACKAGE) protected String dbMySqlConvertersPckg
	
	override protected createJavaClass() {
		var tables = ctx.get(TABLES) as List<Table>
		return tables.map [ table |
			return new JavaClass => [
				name = "To" + table.name.toFirstUpper + "Converter"
				pckg = dbMySqlConvertersPckg
				content = '''
					public class «name» implements «type(dbMySqlPckg + ".ResultSetConverter")»<«type(commonDbDataPckg + "." + table.name.toFirstUpper + "Data")»> {
					
						@Override
						public «commonDbDataPckg + "." + table.name.toFirstUpper + "Data"» convert(«type("java.sql.ResultSet")» _from) throws «type("java.sql.SQLException")» {
							
							return new «type(commonDbDataPckg + "." + table.name.toFirstUpper + "Data")»() {
								{
									setRevision(_from.getString("«table.members.filter(TableAttribute).filter[flags.contains("revision")].head.actualAttributeName»"));
									if(_from.wasNull()) {
										setRevision(null);
									}																
									
									«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
										set«attr.name.toFirstUpper»((«attr.type.javaType») _from.getObject("«attr.actualAttributeName»"));
										if (_from.wasNull()) {
											set«attr.name.toFirstUpper»(null);
										}															
									«ENDFOR»
									
									«FOR ref : table.members.filter(TableReference).filter[!list]»
										String «ref.name» = _from.getString("«ref.name»");
										if («ref.name» != null) {
											this.«ref.name» = new «type(commonDbDataPckg + ".DefaultResourceIdentifier")»(«ref.name»);
										}																						
									«ENDFOR»
									
									«IF table instanceof ReferenceTable»
										setIdentifier(
											new «type(commonDbDataPckg + ".DefaultReferenceIdentifier")»(
													new «type(commonDbDataPckg + ".DefaultResourceIdentifier")»(_from.getString("«table.keys.get(0)»")),
													new «type(commonDbDataPckg + ".DefaultResourceIdentifier")»(_from.getString("«table.keys.get(1)»")))
													);
									«ENDIF»
									«IF table instanceof RootTable»
										setIdentifier(new «type(commonDbDataPckg + ".DefaultResourceIdentifier")»(_from.getString("«table.key»")));
									«ENDIF»
									«IF table instanceof SubTable»
										«var keys = table.keys»
										setIdentifier(
											new «type(commonDbDataPckg + ".DefaultResourceIdentifier")»(
												«FOR key : keys SEPARATOR ', '»
													_from.getString("«key»")
												«ENDFOR»
												)
										);
									«ENDIF»
								}
							};
							
						}
					}
				'''
			]
		].toList
	}

}
