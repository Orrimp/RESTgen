package de.fhws.rdsl.generator.db.mysql.utils


@Data
class OneToOneTrigger extends AbstractTrigger {
	
	String leftId
	String leftTable
	String leftField
	String leftRefId
	
	String rightId
	String rightTable
	String rightField
	String rightRefId

	
}