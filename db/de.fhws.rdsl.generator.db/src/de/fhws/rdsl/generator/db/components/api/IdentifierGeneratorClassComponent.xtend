package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class IdentifierGeneratorClassComponent extends AbstractComponent {
	
	override protected createJavaClass() {
				return new JavaClass => [
			pckg = commonDbPckg
			name = "IdentifierGenerator"
			content = '''		
				public interface �name� {
					
					String generate(String namespace);
					
				}
			'''
		]
	}
	
}