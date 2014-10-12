package de.fhws.rdsl.generator.db.components

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableContainment
import de.fhws.rdsl.generator.table.TableFactory
import de.fhws.rdsl.rdsl.Attribute
import de.fhws.rdsl.rdsl.Containment
import de.fhws.rdsl.rdsl.Member
import de.fhws.rdsl.rdsl.Package
import de.fhws.rdsl.rdsl.PrimitiveType
import de.fhws.rdsl.rdsl.Reference
import de.fhws.rdsl.rdsl.ResourceType
import de.fhws.rdsl.rdsl.RootResourceType
import java.util.List
import javax.inject.Inject
import org.eclipse.xtext.util.Pair
import org.eclipse.xtext.util.Tuples

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.rdsl.StringType
import de.fhws.rdsl.rdsl.IntType
import de.fhws.rdsl.rdsl.FloatType
import de.fhws.rdsl.rdsl.BooleanType
import de.fhws.rdsl.rdsl.DateType

class TablesComponent extends AbstractComponent {

	@Inject
	Package pckg

	override run() {
		val rootTables = pckg.createRootTables.toList
		val subResourceTables1 = pckg.createSubTables1.toList
		val subResourceTables2 = pckg.createSubTables2.toList
		val referenceTables = pckg.createReferenceTables(rootTables)
		val allTables = rootTables + subResourceTables1 + subResourceTables2 + referenceTables

		pckg.updateContainmentProperties(allTables)
		updateTables(allTables.toList);

//		allTables.forEach [ table |
//			println("=========================")
//			println(table.name)
//			table.members.filter(TableAttribute).forEach[println("attribute " + name + ": type->" + type)]
//			table.members.filter(TableContainment).forEach[println("containment " + name + ": list->" + list + ", subTable-> " + subTable.name)]
//			table.members.filter(TableReference).forEach[println("reference " + name + ": list->" + list + ", referenceTable-> " + referenceTable.name)]
//			newArrayList(table).filter(ReferenceTable).forEach [
//				println("left " + left.name + ": list->" + left.list + ", table->" + (left.eContainer as RootTable).name)
//				println("right " + right.name + ": list->" + right.list + ", table->" + (right.eContainer as RootTable).name)
//			]
//		]
		ctx.put(TABLES, allTables.toList)
	}

	def updateTables(List<Table> tables) {
		tables.forEach [ table |
			table.members += TableFactory.eINSTANCE.createStringAttribute => [
				name = "_revision"
				flags += "revision"
			]
			table.members += TableFactory.eINSTANCE.createStringAttribute => [
				name = "_revisiontemp"
				flags += "revisiontemp"
			]
		]
		tables.forEach [ table |
			switch table.eContainer {
				TableContainment:
					if(!(table.eContainer as TableContainment).list)
						table.members += TableFactory.eINSTANCE.createStringAttribute => [
							name = "_"
							flags += "basefield"
						]
			}
		]
	}

	def updateContainmentProperties(Package pckg, Iterable<Table> tables) {

		// 1:1, 1:n Containment
		pckg.eAllContents.filter(Containment).forEach [ containment |
			val container = containment.eContainer as ResourceType
			tables.findFirst[name.equals(container.name)].members += TableFactory.eINSTANCE.createTableContainment => [
				name = containment.name
				subTable = tables.findFirst[name.equals(containment.resourceType.name)] as SubTable
				list = containment.list
			]
		]

		// 1:n from list attributes
		pckg.eAllContents.filter(Attribute).filter[list].forEach [ attr |
			val container = attr.eContainer as ResourceType
			tables.findFirst[name.equals(container.name)].members += TableFactory.eINSTANCE.createTableContainment => [
				name = attr.name
				subTable = tables.findFirst[name.equals(attr.tableName)] as SubTable
				list = true
			]
		]
	}

	// Creates root tables with primitive attributes (no list)
	def createRootTables(Package pckg) {
		pckg.eAllContents.filter(RootResourceType).map [ resourceType |
			TableFactory.eINSTANCE.createRootTable => [
				name = resourceType.name
				members += resourceType.members.filter(Attribute).filter[!list].map [ attr |
					val tableAttr = attr.createTableAttribute
					if(tableAttr == null)
						println(tableAttr)
					return tableAttr
				]
			]
		]
	}
	
	def createTableAttribute(Attribute attr) {
		val t = attr.primitiveType
		switch(t) {
			StringType: TableFactory.eINSTANCE.createStringAttribute => [
				name = attr.name
				queryable = attr.queryable
			]
			IntType: TableFactory.eINSTANCE.createIntAttribute => [
				name = attr.name
				queryable = attr.queryable
			]
			FloatType: TableFactory.eINSTANCE.createFloatAttribute => [
				name = attr.name
				queryable = attr.queryable
			]
			BooleanType: TableFactory.eINSTANCE.createBooleanAttribute => [
				name = attr.name
				queryable = attr.queryable
			]
			DateType: TableFactory.eINSTANCE.createDateAttribute => [
				name = attr.name
				queryable = attr.queryable
			]
		}
	}

	// Creates sub tables from containments
	def createSubTables1(Package pckg) {
		pckg.eAllContents.filter(Containment).map[resourceType].map [ resourceType |
			TableFactory.eINSTANCE.createSubTable => [
				name = resourceType.name
				members += resourceType.members.filter(Attribute).filter[!list].map [ attr |
					attr.createTableAttribute
				]
			]
		]
	}

	// Creates sub tables from list attributes
	def createSubTables2(Package pckg) {
		pckg.eAllContents.filter(Attribute).filter[list].map [ attr |
			TableFactory.eINSTANCE.createSubTable => [
				name = attr.tableName
				val tableAttr = attr.createTableAttribute
				tableAttr.name = "value"
				members += tableAttr			
			]
		]
	}

	// Create tables from references
	def createReferenceTables(Package pckg, Iterable<RootTable> rootTables) {

		val worked = newHashSet()
		val tables = newArrayList()

		// 1:1
		pckg.eAllContents.filter(Reference).forEach [ reference |
			val referencePair = reference.getReferenceOrder(pckg)
			val tableName = referencePair.tableName
			if(!worked.contains(tableName)) {
				worked.add(tableName)
				val table = TableFactory.eINSTANCE.createReferenceTable => [
					name = tableName
					if(reference.referenceSchema != null)
						members += reference.referenceSchema.attributes.map [ attr |
							attr.createTableAttribute
						]
				]
				table.left = TableFactory.eINSTANCE.createTableReference => [
					name = referencePair.first.name
					list = referencePair.first.list
					referenceTable = table
				]

				rootTables.findFirst[name.equals((referencePair.first.eContainer as RootResourceType).name)].members += table.left

				table.right = TableFactory.eINSTANCE.createTableReference => [
					name = referencePair.second.name
					list = referencePair.second.list
					referenceTable = table
				]

				rootTables.findFirst[name.equals((referencePair.second.eContainer as RootResourceType).name)].members += table.right

				tables.add(table)
			}
		]

		return tables
	}

	def getReferenceOrder(Reference reference, Package pckg) {
		var String one = (reference.eContainer as ResourceType).name + reference.name
		var String two = (reference.resourceType as ResourceType).name + reference.opposite
		var Reference left
		var Reference right
		if(one.compareTo(two) < 0) {
			left = reference
			right = reference.resourceType.findMember(reference.opposite) as Reference
		} else {
			left = reference.resourceType.findMember(reference.opposite) as Reference
			right = reference
		}
		return Tuples.create(left, right)
	}

	def getTableName(Pair<Reference, Reference> pair) {
		return (pair.first.eContainer as ResourceType).name + pair.first.name + (pair.second.eContainer as ResourceType).name + pair.second.name
	}

	def Member findMember(RootResourceType type, String searchName) {
		type.members.findFirst[name.equalsIgnoreCase(searchName)]
	}

}
