package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class IdentifierClassComponent extends AbstractComponent {

	override protected createJavaClass() {

		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "Identifier"
			content = '''		
				public interface «name» extends Cloneable {
					
				}
			'''
		]
	}

}
