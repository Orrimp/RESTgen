package de.fhws.rdsl.generator.db.mysql.utils


@Data
class OneToManyTrigger extends AbstractTrigger {
	
	String leftId
	String leftTable
	String leftField
	String rightId
	
	String leftRefId
	String rightRefId
	
}