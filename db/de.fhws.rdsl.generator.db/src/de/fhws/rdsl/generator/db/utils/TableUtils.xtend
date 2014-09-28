package de.fhws.rdsl.generator.db.utils

import de.fhws.rdsl.generator.table.TableMember
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableContainment
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.rdsl.Attribute
import de.fhws.rdsl.rdsl.ResourceType
import de.fhws.rdsl.rdsl.PrimitiveType
import de.fhws.rdsl.generator.table.RootTable
import org.eclipse.emf.ecore.EObject
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.TableAttribute
import java.util.List
import de.fhws.rdsl.generator.table.TableReference

class TableUtils {

	static def Table getParentTable(TableMember member) {
		member.eContainer as Table
	}

	static def TableContainment getContainment(SubTable table) {
		return table.eContainer as TableContainment
	}

	static def getTableName(Attribute attr) {
		(attr.eContainer as ResourceType).name + attr.name.toFirstUpper
	}
	

	static def getJavaType(String name) {
		switch name {
			case PrimitiveType.BOOLEAN.getName: "Boolean"
			case PrimitiveType.INT.getName: "Integer"
			case PrimitiveType.DATE.getName: "java.util.Date"
			case PrimitiveType.FLOAT.getName: "Double"
			case PrimitiveType.STRING.getName: "String"
		}
	}
	
	static def getJavaTypeForSchema(String name) {
		switch name {
			case PrimitiveType.BOOLEAN.getName: "BOOLEAN"
			case PrimitiveType.INT.getName: "INTEGER"
			case PrimitiveType.DATE.getName: "DATE"
			case PrimitiveType.FLOAT.getName: "FLOAT"
			case PrimitiveType.STRING.getName: "STRING"
		}
	}

	static def getKeys(SubTable table) {
		table.getActualTablePath.map['''_«it.name.toFirstLower»Id''']
	}

	static def getActualTablePath(SubTable table) {
		var EObject eObject = table
		var eObjectPath = newArrayList
		while (eObject != null) {
			eObjectPath.add(0, eObject)
			eObject = eObject.eContainer
		}
		var first = eObjectPath.filter(RootTable).head
		var last = eObjectPath.filter(TableContainment).filter[list].map[subTable].toList
		var list = newArrayList
		list.add(first)
		list.addAll(last)
		return list
	}

	static def getKey(RootTable table) {
		'''_«table.name.toFirstLower»Id'''
	}

	static def getKeys(Table table) {
		switch table {
			ReferenceTable:
				newArrayList("_" + table.left.name.toFirstLower + "_" + table.left.parentTable.name,
					"_" + table.right.name.toFirstLower + "_" + table.right.parentTable.name)
			SubTable:
				table.keys
			RootTable:
				newArrayList(table.key.toString)
		}
	}

	def static List<SubTable> getContainedNonListTables(Table table) {
		val List<SubTable> containedTables = newArrayList
		table.members.filter(TableContainment).filter[!list].forEach [ m |
			containedTables.add(m.subTable)
			containedTables += getContainedNonListTables(m.subTable)
		]
		return containedTables
	}

	static def getActualAttributeName(TableAttribute attribute) {
		var EObject eObject = attribute.parentTable
		val path = newArrayList(attribute.name);
		while (eObject != null) {
			switch eObject {
				RootTable: return path.join("_")
				ReferenceTable: return path.join("_")
				TableContainment: if(eObject.list) return path.join("_") else path.add(0, eObject.name)
			}
			eObject = eObject.eContainer
		}
	}

	static def getActualParentTable(SubTable subTable) {
		var EObject eObject = subTable.containment.parentTable
		switch eObject {
			RootTable: return eObject
		}
		//eObject = subTable.containment
		while (eObject != null) {
			switch eObject {
				TableContainment: if(eObject.list) return eObject.subTable
				RootTable: return eObject
			}
			eObject = eObject.eContainer
		}
	}

	def static getActualTable(Table table) {
		switch table {
			ReferenceTable: table
			RootTable: table
			SubTable: if(table.containment.list) return table else return table.actualParentTable
		}
	}

	def static getListDescendants(Table table) {
		return table.members.filter(TableContainment).filter[list].map[subTable]
	}

	def static getContainedListChildren(Table table) {
		return table.eAllContents.filter(TableContainment).filter[list].map[subTable].toList
	}

	def static getNonListDescendants(Table table) {
		return table.members.filter(TableContainment).filter[!list].map[subTable]
	}

	def static getNonListReferenceMembers(Table table) {
		return table.members.filter(TableReference).filter[!list]
	}

	def static getActualAttributes(Table table) {
		table.members.filter(TableAttribute).filter[flags.empty].map[it.actualAttributeName]
	}

	def static getBaseField(Table table) {
		table.members.filter(TableAttribute).filter[flags.contains("basefield")].map[actualAttributeName].head
	}

	def static getRevisionField(Table table) {
		table.members.filter(TableAttribute).filter[flags.contains("revision")].map[it.actualAttributeName].head
	}

	def static getRevisionTempField(Table table) {
		table.members.filter(TableAttribute).filter[flags.contains("revisiontemp")].map[it.actualAttributeName].head
	}

	def static hasContainmentMembers(Table table) {
		table.members.filter(TableContainment).size > 0
	}
}
