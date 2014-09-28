package de.fhws.rdsl.generator.db.mysql.utils

import java.util.List

@Data
class ForeignKeyConstraint {
	String table
	String name
	List<String> keys
	List<String> referenceKeys
	String referenceTable
	String ondelete
}
