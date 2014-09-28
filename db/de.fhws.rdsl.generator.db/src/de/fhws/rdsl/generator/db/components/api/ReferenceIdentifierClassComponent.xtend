package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ReferenceIdentifierClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "ReferenceIdentifier"
			content = '''		
				public interface «name» extends Identifier {
					
					ResourceIdentifier getId1();
					
					ResourceIdentifier getId2();
					
				}
			'''
		]
	}

}
