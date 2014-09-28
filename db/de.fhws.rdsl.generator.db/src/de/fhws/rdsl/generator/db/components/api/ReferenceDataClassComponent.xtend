package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ReferenceDataClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "ReferenceData"
			content = '''		
				public abstract class «name» extends Data<ReferenceIdentifier> {
					
				}
			'''
		]
	}

}
