package de.fhws.rdsl.generator.db.mysql.utils

@Data
class AbstractTrigger {
	String name
	String table
	boolean beforeUpdate
}