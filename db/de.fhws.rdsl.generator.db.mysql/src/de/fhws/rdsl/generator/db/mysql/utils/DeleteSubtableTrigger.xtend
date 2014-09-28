package de.fhws.rdsl.generator.db.mysql.utils

import java.util.List
import de.fhws.rdsl.generator.db.mysql.utils.AbstractTrigger

@Data
class DeleteSubtableTrigger extends AbstractTrigger {
	List<DeleteSubtableTriggerExpression> expressions
}

@Data
class DeleteSubtableTriggerExpression {
	String baseField
	List<String> keys
	String subTable
}