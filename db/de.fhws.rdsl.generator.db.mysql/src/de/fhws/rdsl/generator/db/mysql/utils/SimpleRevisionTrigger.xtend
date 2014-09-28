package de.fhws.rdsl.generator.db.mysql.utils

import java.util.List
import de.fhws.rdsl.generator.db.mysql.utils.AbstractTrigger

@Data
class SimpleRevisionTrigger extends AbstractTrigger {
	String revisionField
	String revisionTempField
}
