package de.fhws.rdsl.generator.db.mysql.utils

import java.util.List

@Data
class TableDefinition {
	String name
	List<String> keys
	List<TableAttributeDefinition> attributes
}