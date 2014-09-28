package de.fhws.rdsl.generator.db.components.impl



import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import java.util.List

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.TableContainment
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.generator.table.TableAttribute

class DefaultSchemaClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "DefaultSchema"
			pckg = dbPckg
			content = '''
				public class «name» extends «type("de.fhws.rdsl.query.transformer.api.schema.Schema")» {
					
					public «name»() {
						super(createTypes());
					}
					
					private static «type("java.util.List")»<«type("de.fhws.rdsl.query.transformer.api.schema.Type")»> createTypes() {
						«FOR table : tables.filter(RootTable)»
							«type("de.fhws.rdsl.query.transformer.api.schema.RootResourceType")» «table.varName» = new RootResourceType("«table.name»");					
						«ENDFOR»
						«FOR table : tables.filter(ReferenceTable)»
							«type("de.fhws.rdsl.query.transformer.api.schema.ReferenceType")» «table.varName» = new ReferenceType("«table.name»");					
						«ENDFOR»
						«FOR table : tables.filter(SubTable)»
							«type("de.fhws.rdsl.query.transformer.api.schema.SubResourceType")» «table.varName» = new SubResourceType("«table.name»");					
						«ENDFOR»
						
						«FOR table : tables»
							
							// «table.name»
							«IF table instanceof ReferenceTable»
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Reference")»("«table.keys.get(0)»", false, «table.
					left.parentTable.varName», null)); // Reference to root table	
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Reference")»("«table.keys.get(1)»", false, «table.
					right.parentTable.varName», null)); // Reference to root table	
							«ELSE»
							«FOR key : table.keys»
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Attribute")»("«key»", Attribute.STRING)); // Key
							«ENDFOR»
							«ENDIF»

							
							«FOR attr : table.members.filter(TableAttribute)»
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Attribute")»("«attr.name»", Attribute.«attr.
					type.javaTypeForSchema»)); // Attribute	
							«ENDFOR»
							«FOR attr : table.members.filter(TableContainment)»
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Containment")»("«attr.name»", «if(attr.
					list) "true" else "false"», «attr.subTable.varName», null)); // Containment					
							«ENDFOR»
							«FOR attr : table.members.filter(TableReference)»
								«table.varName».getMembers().add(new «type("de.fhws.rdsl.query.transformer.api.schema.Reference")»("«attr.name»", «if(attr.
					list) "true" else "false"», «attr.referenceTable.varName», "«attr.opposite»")); // Reference					
							«ENDFOR»
						«ENDFOR»
						
						«type("java.util.List")»<Type> all = new «type("java.util.ArrayList")»<Type>();
						«FOR table : tables»
							all.add(«table.varName»);
						«ENDFOR»
						return all;
					}
					
				}
			'''
		]
	}

	def getOpposite(TableReference ref) {
		var table = ref.referenceTable
		if (ref == ref.referenceTable.left) {
			return ref.referenceTable.right.name
		} else {
			return ref.referenceTable.left.name
		}
	}

	def getVarName(Table table) {
		return table.name.toFirstLower
	}

}
