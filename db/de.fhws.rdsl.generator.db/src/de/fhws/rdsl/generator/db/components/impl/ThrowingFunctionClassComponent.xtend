package de.fhws.rdsl.generator.db.components.impl

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ThrowingFunctionClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = dbPckg
			name = "ThrowingFunction"
			content = '''		
				public interface «name»<T, R> {
					
					T apply(R value) throws Exception;
					
				}
			'''
		]
	}

}
