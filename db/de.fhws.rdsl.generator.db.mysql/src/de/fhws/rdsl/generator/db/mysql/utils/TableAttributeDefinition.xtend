package de.fhws.rdsl.generator.db.mysql.utils

@Data
class TableAttributeDefinition {
	String name
	String type
	boolean nullable
	boolean reference
	boolean indexed
}