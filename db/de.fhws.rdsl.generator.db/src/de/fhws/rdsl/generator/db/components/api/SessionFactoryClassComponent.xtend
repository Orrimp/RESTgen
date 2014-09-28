package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class SessionFactoryClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = commonDbPckg
			name = "SessionFactory"
			content = '''		
				public interface «name» extends AutoCloseable {
					
					«type(commonDbPckg + ".Session")» createSession();
					
				}
			'''
		]
	}

}
