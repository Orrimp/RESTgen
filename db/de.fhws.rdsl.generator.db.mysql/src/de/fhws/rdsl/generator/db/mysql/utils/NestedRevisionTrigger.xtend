package de.fhws.rdsl.generator.db.mysql.utils

import java.util.List
import de.fhws.rdsl.generator.db.mysql.utils.AbstractTrigger

@Data
class NestedRevisionTrigger extends AbstractTrigger {
	List<NestedTriggerExpression> nestedExpressions
	TriggerExpression baseExpression
}

@Data
class TriggerExpression {
	String revisionField
	String revisionTempField
}

@Data
class NestedTriggerExpression extends TriggerExpression {
	String baseField
}
