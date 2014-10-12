package de.fhws.rdsl.generator.db.mysql.components

import com.google.common.collect.Lists
import de.fhws.rdsl.generator.db.mysql.utils.AbstractTrigger
import de.fhws.rdsl.generator.db.mysql.utils.DeleteSubtableTrigger
import de.fhws.rdsl.generator.db.mysql.utils.DeleteSubtableTriggerExpression
import de.fhws.rdsl.generator.db.mysql.utils.ForeignKeyConstraint
import de.fhws.rdsl.generator.db.mysql.utils.Index
import de.fhws.rdsl.generator.db.mysql.utils.NestedRevisionTrigger
import de.fhws.rdsl.generator.db.mysql.utils.NestedTriggerExpression
import de.fhws.rdsl.generator.db.mysql.utils.OneToManyTrigger
import de.fhws.rdsl.generator.db.mysql.utils.OneToOneTrigger
import de.fhws.rdsl.generator.db.mysql.utils.SimpleRevisionTrigger
import de.fhws.rdsl.generator.db.mysql.utils.TableAttributeDefinition
import de.fhws.rdsl.generator.db.mysql.utils.TableDefinition
import de.fhws.rdsl.generator.db.mysql.utils.TriggerExpression
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.db.workflow.ConfigurationKeys
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.TableContainment
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.rdsl.PrimitiveType
import de.fhws.rdsl.workflow.TextFile
import java.util.List
import javax.inject.Inject
import javax.inject.Named

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import de.fhws.rdsl.rdsl.DateType
import de.fhws.rdsl.generator.table.BooleanAttribute
import de.fhws.rdsl.generator.table.IntAttribute
import de.fhws.rdsl.generator.table.FloatAttribute
import de.fhws.rdsl.generator.table.StringAttribute
import de.fhws.rdsl.generator.table.DateAttribute

class MySQLScriptComponent extends AbstractComponent implements MySQLConfigurationKeys {
	
	static final val PK_TYPE = "CHAR(32)"
	
	@Inject @Named(ConfigurationKeys.USE_SEQUENCES)
	Boolean useSequences 
	
	@Inject @Named(DB_MYSQL_RESOURCE_PACKAGE) String resPckg;
	
	override run() {
		
		val tables = ctx.get(TABLES) as List<Table>
				// Create contains fk constraints
		var containsFkConstraints = tables.map[members].flatten.filter(TableContainment).filter[list].map[subTable].map[
			foreignKeyConstraints].flatten

		// Create references fk constraints
		var referencesFkConstraints = tables.filter(ReferenceTable).map[foreignKeyConstraints].flatten

		// Create table definitions
		var tableDefinitions = tables.tableDefinitions;

		// Create trigger
		var revisionTriggers = tables.createRevisionTriggers
		var oneToOneTriggers = tables.createOneToOneTriggers
		var oneToManyTriggers = tables.createOneToManyTriggers
		var deleteSubtableTriggers = tables.createDeleteSubTablesTriggers

		// Create indices
		var indices = createIndices(tableDefinitions)

		// Create sequence tables
		var createSequenceTables = ""
		var createDropSequenceTables = ""
		if (useSequences) {
			createSequenceTables = createCreateSequences(tableDefinitions)
			createDropSequenceTables = createDropSequences(tableDefinitions)
		}

		var script = newArrayList

		script += indices.map[it.formatDropIndex]
		script += oneToManyTriggers.map[it.formatDropTrigger]
		script += oneToOneTriggers.map[it.formatDropTrigger]
		script += revisionTriggers.map[it.formatDropTrigger]		
		script += deleteSubtableTriggers.map[it.formatDropTrigger]
		script += referencesFkConstraints.map[it.formatDropForeignKeyConstraintString]
		script += containsFkConstraints.map[it.formatDropForeignKeyConstraintString]

		script += tableDefinitions.map[it.formatDropTable]
		script += createDropSequenceTables
		script += tableDefinitions.map[it.formatCreateTable]
		script += createSequenceTables

		script += containsFkConstraints.map[it.formatAddForeignKeyConstraintString]
		script += referencesFkConstraints.map[it.formatAddForeignKeyConstraintString]
		script += revisionTriggers.filter(SimpleRevisionTrigger).map[it.formatSimpleRevisionTrigger]

		script += oneToOneTriggers.map[it.formatOneToOneTrigger]
		script += oneToManyTriggers.map[it.formatOneToManyTrigger]
		script += revisionTriggers.filter(NestedRevisionTrigger).map[it.formatNestedRevisionTrigger]
		script += deleteSubtableTriggers.map[it.formatDeleteSubtableTrigger]
		script += indices.map[it.formatCreateIndex]

		val scriptStr = script.join('\n\n')

		ctx.addFile(new TextFile => [
			name = "sqlscripts.sql"
			pckg = resPckg
			content = scriptStr
		])
	}
	
	def createCreateSequences(List<TableDefinition> definitions) {
		return '''
			CREATE TABLE IF NOT EXISTS `_sequence` (
				`id` VARCHAR(512) NOT NULL,
				`value` int(16) DEFAULT NULL,
				PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		'''

	}

	def createDropSequences(List<TableDefinition> definitions) {
		return '''
			DROP TABLE IF EXISTS `_sequence`;
		'''

	}

	def createIndices(List<TableDefinition> tables) {
		val indices = newArrayList
		tables.forEach [ table |
			table.attributes.forEach [ attr |
				if (attr.indexed)
					indices += new Index("index_" + table.name + "_" + attr.name, table.name, attr.name)
			]
		]
		return indices
	}

	def createOneToOneTriggers(List<Table> tables) {
		val triggers = newArrayList
		tables.filter(ReferenceTable).forEach [ table |
			if (!table.left.list && !table.right.list) {

				// 1:1
				var leftKey = (table.left.parentTable as RootTable).key.toString
				var leftTable = table.left.parentTable.name
				var leftField = table.left.name
				var rightKey = (table.right.parentTable as RootTable).key.toString
				var rightTable = table.right.parentTable.name
				var rightField = table.right.name
				triggers += new OneToOneTrigger("validate_onetoone_for_" + table.name, table.name, false, leftKey,
					leftTable, leftField, table.keys.get(0), rightKey, rightTable, rightField, table.keys.get(1))
			}
		]
		return triggers
	}

	def createOneToManyTriggers(List<Table> tables) {
		val triggers = newArrayList
		tables.filter(ReferenceTable).forEach [ table |
			if (!table.left.list && table.right.list) {
				var leftKey = (table.left.parentTable as RootTable).key.toString
				var leftTable = table.left.parentTable.name
				var leftField = table.left.name
				var rightKey = (table.right.parentTable as RootTable).key.toString
				var leftRefId = table.keys.get(0)
				var rightRefId = table.keys.get(1)
				triggers += new OneToManyTrigger("validate_onetomany_for_" + table.name, table.name, false, leftKey,
					leftTable, leftField, rightKey, leftRefId, rightRefId)
			}
			if (table.left.list && !table.right.list) {
				var leftKey = (table.right.parentTable as RootTable).key.toString
				var leftTable = table.right.parentTable.name
				var leftField = table.right.name
				var rightKey = (table.left.parentTable as RootTable).key.toString
				var leftRefId = table.keys.get(1)
				var rightRefId = table.keys.get(0)
				triggers += new OneToManyTrigger("validate_onetomany_for_" + table.name, table.name, false, leftKey,
					leftTable, leftField, rightKey, leftRefId, rightRefId)
			}
		]
		return triggers
	}
	
	def createDeleteSubTablesTriggers(List<Table> tables) {
		val triggers = newArrayList
		val map = newHashMap
		tables.filter(SubTable).filter[!it.containment.list].forEach [t |
			val actualTable = t.actualTable.name			
			val baseField = t.baseField
			var expressions = newArrayList
			if(map.containsKey(actualTable)) {
				expressions = map.get(actualTable)
			}
			expressions += t.listDescendants.map[child |
				 new DeleteSubtableTriggerExpression(baseField, t.keys, child.name)
			]
			map.put(actualTable, expressions)			
		]
		map.keySet.forEach[tableName |
			triggers += new DeleteSubtableTrigger("delete_subtables_" + tableName + "_trigger", tableName, false, map.get(tableName))
		]
		return triggers
	}

	def createRevisionTriggers(List<Table> tables) {

		// root resources
		val List<AbstractTrigger> triggers = newArrayList
		val filtered = Lists.newArrayList(tables)
		tables.filter(SubTable).forEach [ table |
			// Remove all 1:1 nested tables
			if (!table.containment.list) {
				filtered.remove(table)
			}
		]
		tables.filter[filtered.contains(it)].forEach [ table |
			if (table.members.filter(TableContainment).filter[!list].empty) {

				// Only tables without nested 1:1 tables
				var name = "validate_" + table.name + "_revision"
				var tableName = table.name
				var trigger = new SimpleRevisionTrigger(name, tableName, true, "_revision", "_revisiontemp")
				triggers += trigger
				filtered.remove(table)
			} else {
				triggers += createNestedTrigger(table)
			}
		]
		filtered.forEach [ table |
			// Only reference Tables
			if (table instanceof ReferenceTable) {
				var name = "validate_" + table.name + "_revision"
				var tableName = table.name
				var trigger = new SimpleRevisionTrigger(name, tableName, true, "_revision", "_revisiontemp")
				triggers += trigger
				filtered.remove(table)
			}
		]
		return triggers
	}

	def void createNestedTrigger(Table table, List<NestedTriggerExpression> nestedExpressions) {

		// find revision
		var revision = table.members.filter(TableAttribute).filter[flags.contains("revision")].head
		var revisionField = getActualAttributeName(revision)
		var revisionTemp = table.members.filter(TableAttribute).filter[flags.contains("revisiontemp")].head
		var revisionTempField = getActualAttributeName(revisionTemp)
		var base = table.members.filter(TableAttribute).filter[flags.contains("basefield")].head
		var baseField = getActualAttributeName(base)
		nestedExpressions += new NestedTriggerExpression(revisionField, revisionTempField, baseField)
		table.members.filter(TableContainment).filter[!list].map[subTable].forEach [ child |
			createNestedTrigger(child, nestedExpressions)
		]
	}

	def createNestedTrigger(Table table) {

		var expression = new TriggerExpression("_revision", "_revisiontemp")
		val List<NestedTriggerExpression> nestedExpressions = newArrayList()

		table.members.filter(TableContainment).filter[!list].map[subTable].forEach [ child |
			createNestedTrigger(child, nestedExpressions)
		]
		var trigger = new NestedRevisionTrigger("validate_" + table.name + "_revision", table.name, true,
			nestedExpressions, expression)
		return trigger
	}

	def getTableDefinitions(List<Table> tables) {

		var defs = newArrayList();

		// Root tables
		defs += tables.filter(RootTable).map [ rootTable |
			var definition = new TableDefinition(rootTable.name, newArrayList(rootTable.key.toString),
				rootTable.attributeDefinitions)
			return definition
		]

		// Reference tables
		defs += tables.filter(ReferenceTable).map [ refTable |
			var definition = new TableDefinition(refTable.name,
				newArrayList(refTable.keys.get(0),
					refTable.keys.get(1)), refTable.attributeDefinitions)
			return definition
		]

		// Sub tables
		defs += tables.filter(SubTable).filter[it.containment.list].map [ subTable |
			var definition = new TableDefinition(subTable.name, subTable.keys, subTable.attributeDefinitions)
			return definition
		]
		return defs
	}

	def List<TableAttributeDefinition> getAttributeDefinitions(Table table) {
		val attrs = newArrayList
		attrs += table.members.filter(TableAttribute).map [
			new TableAttributeDefinition(it.actualAttributeName, it.getSQLType, true, false, it.queryable)
		]
		table.members.filter(TableContainment).filter[!list].map[subTable].forEach [ t |
			attrs += t.attributeDefinitions
		]
		table.members.filter(TableReference).filter[!list].forEach [ t |
			attrs += new TableAttributeDefinition(t.name, PK_TYPE, true, true, true)
		]

		return attrs
	}

	def getSQLType(TableAttribute attr) {
		if(attr.flags.contains("revision") || attr.flags.contains("revisiontemp")) return "CHAR(32)"
		if(attr.flags.contains("basefield")) return "BIT(1)"
		switch attr {
			DateAttribute: "DATETIME"
			StringAttribute: "TEXT"
			FloatAttribute: "FLOAT"
			IntAttribute: "INT(10)"
			BooleanAttribute: "BIT(1)"
			default: "***********************************"
		}
	}

	def getForeignKeyConstraints(SubTable subTable) {
		var name = '''fk_«subTable.name»_«subTable.containment.name»'''
		var table = subTable.name
		var allKeys = subTable.keys
		var keys = allKeys.subList(0, allKeys.size - 1)
		var referenceKeys = keys
		var referenceTable = subTable.actualParentTable.name
		return newArrayList(new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, "CASCADE"))
	}

	def getForeignKeyConstraints(ReferenceTable refTable) {
		var constraints = newArrayList()
		{
			var name = '''fk_«refTable.name»_«refTable.left.name»'''
			var table = refTable.name
			var keys = newArrayList(refTable.keys.get(0))
			var referenceKeys = refTable.left.parentTable.keys
			var referenceTable = refTable.left.parentTable.name
			constraints += new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, null)
		}
		{
			var name = '''fk_«refTable.name»_«refTable.right.name»'''
			var table = refTable.name
			var keys = newArrayList(refTable.keys.get(1))
			var referenceKeys = refTable.right.parentTable.keys
			var referenceTable = refTable.right.parentTable.name
			constraints += new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, null)
		}
		if (refTable.left.list && refTable.left.list) {
			// n:n
			// nothing
		}
		if (refTable.left.list && !refTable.right.list) {

			// 1:n
			var name = '''fk_«refTable.name»_«refTable.left.name»_«refTable.right.name»'''
			var table = refTable.right.parentTable.name
			var keys = newArrayList(refTable.right.name)
			var referenceKeys = newArrayList(refTable.keys.get(0))
			var referenceTable = refTable.name
			constraints += new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, "SET NULL")
		}
		if (!refTable.left.list && refTable.right.list) {

			// 1:n
			var name = '''fk_«refTable.name»_«refTable.left.name»_«refTable.right.name»'''
			var table = refTable.left.parentTable.name
			var keys = newArrayList(refTable.left.name)
			var referenceKeys = newArrayList(refTable.keys.get(1))
			var referenceTable = refTable.name
			constraints += new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, "SET NULL")
		}
		if (!refTable.left.list && !refTable.right.list) {

			// 1:1
			{
				var name = '''fk_«refTable.name»_«refTable.left.name»_«refTable.right.name»'''
				var table = refTable.left.parentTable.name
				var keys = newArrayList(refTable.left.name)
				var referenceKeys =  newArrayList(refTable.keys.get(1))
				var referenceTable = refTable.name
				constraints +=
					new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, "SET NULL")
			}
			{
				var name = '''fk_«refTable.name»_«refTable.right.name»_«refTable.left.name»'''
				var table = refTable.right.parentTable.name
				var keys = newArrayList(refTable.right.name)
				var referenceKeys = newArrayList(refTable.keys.get(0))
				var referenceTable = refTable.name
				constraints +=
					new ForeignKeyConstraint(table, name, keys, referenceKeys, referenceTable, "SET NULL")
			}
		}

		return constraints
	}

	def formatDropForeignKeyConstraintString(ForeignKeyConstraint constraint) {
		'''
			ALTER TABLE `«constraint.table»` DROP FOREIGN KEY `«constraint.name»`;
		'''
	}

	def formatAddForeignKeyConstraintString(ForeignKeyConstraint constraint) {
		'''
			ALTER TABLE `«constraint.table»` ADD CONSTRAINT `«constraint.name»` FOREIGN KEY («FOR key : constraint.keys SEPARATOR ", "»`«key»`«ENDFOR») REFERENCES `«constraint.
				referenceTable»` («FOR key : constraint.referenceKeys SEPARATOR ", "»`«key»`«ENDFOR»)«IF constraint.ondelete !=
				null» ON DELETE «constraint.ondelete»«ENDIF»;
		'''
	}

	def formatCreateTable(TableDefinition tableDefinition) {
		'''
			CREATE TABLE IF NOT EXISTS `«tableDefinition.name»` (
				«FOR key : tableDefinition.keys»
					«key» «PK_TYPE» NOT NULL,
				«ENDFOR»
				«FOR attr : tableDefinition.attributes»
					`«attr.name»` «attr.type» «if(attr.nullable) "DEFAULT NULL" else "NOT NULL"»,
				«ENDFOR»
				PRIMARY KEY («FOR key : tableDefinition.keys SEPARATOR ', '»`«key»`«ENDFOR»)
			) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		'''
	}

	def formatDropTable(TableDefinition tableDefinition) {
		'''
			DROP TABLE IF EXISTS `«tableDefinition.name»`;
		'''
	}

	def formatDropTrigger(AbstractTrigger trigger) {
		'''
			DROP TRIGGER IF EXISTS `«trigger.name»`;
		'''
	}

	def formatSimpleRevisionTrigger(SimpleRevisionTrigger trigger) {
		'''
			delimiter //
			CREATE TRIGGER `«trigger.name»` «if(trigger.beforeUpdate) "BEFORE UPDATE ON" else "AFTER INSERT ON"» `«trigger.table»` FOR EACH ROW
			IF NEW.`«trigger.revisionTempField»` is NULL or NEW.`«trigger.revisionTempField»` != OLD.`«trigger.revisionField»` THEN
				SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Revision validation error';
			ELSE
				SET NEW.`«trigger.revisionTempField»` = NEW.`«trigger.revisionField»`;
			END IF;
			//
			delimiter ;
		'''
	}

	def formatOneToOneTrigger(OneToOneTrigger trigger) {
		'''
			delimiter //
			CREATE TRIGGER `«trigger.name»` «if(trigger.beforeUpdate) "BEFORE UPDATE ON" else "AFTER INSERT ON"» `«trigger.table»` FOR EACH ROW BEGIN
			IF EXISTS (select `«trigger.leftId»` from `«trigger.leftTable»` where `«trigger.leftId»` = NEW.`«trigger.leftRefId»` and `«trigger.
				leftField»` is not null) THEN
				BEGIN
					SIGNAL SQLSTATE VALUE '47000' SET MESSAGE_TEXT = 'One to one validation error';
				END;
			END IF;
			IF EXISTS (select «trigger.rightId» from «trigger.rightTable» where «trigger.rightId» = NEW.`«trigger.rightRefId»` and `«trigger.
				rightField»` is not null) THEN
				BEGIN
					SIGNAL SQLSTATE VALUE '47000' SET MESSAGE_TEXT = 'One to one validation error';
				END;
			END IF;
			update `«trigger.leftTable»` set «trigger.leftField» = NEW.`«trigger.rightRefId»` where `«trigger.leftId»` = NEW.`«trigger.
				leftRefId»`;
			update `«trigger.rightTable»` set «trigger.rightField» = NEW.`«trigger.leftRefId»` where «trigger.rightId» =  NEW.`«trigger.
				rightRefId»`;
			END;
			//
			delimiter ;
		'''
	}

	def formatOneToManyTrigger(OneToManyTrigger trigger) {
		'''
			delimiter //
			CREATE TRIGGER `«trigger.name»` «if(trigger.beforeUpdate) "BEFORE UPDATE ON" else "AFTER INSERT ON"» `«trigger.table»` FOR EACH ROW BEGIN
			IF EXISTS (select `«trigger.leftId»` from `«trigger.leftTable»` where `«trigger.leftId»` = NEW.`«trigger.leftRefId»` and `«trigger.
				leftField»` is not null) THEN
				SIGNAL SQLSTATE VALUE '46000' SET MESSAGE_TEXT = 'One to many validation error';
			END IF;
			update `«trigger.leftTable»` set `«trigger.leftField»` = NEW.`«trigger.rightRefId»` where «trigger.leftId» = NEW.`«trigger.
				leftRefId»`;
			END;
			//
			delimiter ;
		'''
	}
	
	def formatDeleteSubtableTrigger(DeleteSubtableTrigger trigger) {
		return '''
				delimiter //
				CREATE TRIGGER `«trigger.name»` AFTER UPDATE ON `«trigger.table»` FOR EACH ROW BEGIN
				«FOR expr : trigger.expressions»
					IF NEW.`«expr.baseField»` is null and OLD.`«expr.baseField»` is not null THEN
						DELETE FROM `«expr.subTable»` where «FOR key : expr.keys SEPARATOR ' AND '»`«key»` = NEW.`«key»`«ENDFOR»;
					END IF;
				«ENDFOR»
				END;
				//
				delimiter ;
			'''
	}

	def formatNestedRevisionTrigger(NestedRevisionTrigger trigger) {
		var counter = 0
		'''
			delimiter //
			CREATE TRIGGER `«trigger.name»` «if(trigger.beforeUpdate) "BEFORE UPDATE ON" else "AFTER INSERT ON"» `«trigger.table»` FOR EACH ROW BEGIN
			«FOR expr : trigger.nestedExpressions»
				IF NEW.`«expr.baseField»` = 1 THEN
					IF (NEW.`«expr.revisionTempField»` is NULL and OLD.`«expr.revisionField»` is not NULL) or NEW.`«expr.
				revisionTempField»` != OLD.`«expr.revisionField»` THEN
						SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Revision validation error («expr.baseField»)...';
					ELSE
						SET NEW.`«expr.revisionTempField»` = NEW.`«expr.revisionField»`;
					END IF;
					/* «counter = counter + 1» */ 
				END IF;
			«ENDFOR»
			
				IF NEW.`«trigger.baseExpression.revisionTempField»` is NULL or NEW.`«trigger.baseExpression.revisionTempField»` != OLD.`«trigger.
				baseExpression.revisionField»` THEN
					SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Revision validation error (address)...';
				ELSE
					SET NEW.`«trigger.baseExpression.revisionTempField»` = NEW.`«trigger.baseExpression.revisionField»`;
				END IF;
			
			END;
			//
			delimiter ;
		'''
	}

	def formatCreateIndex(Index index) {
		'''
			CREATE INDEX «index.name» ON «index.table» («index.column»);
		'''
	}

	def formatDropIndex(Index index) {
		'''
			DROP INDEX «index.name» ON «index.table»;
		'''
	}
	
}