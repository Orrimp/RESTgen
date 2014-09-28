package de.fhws.rdsl.generator.db.components.impl


import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ThrowingConsumerClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = dbPckg
			name = "ThrowingConsumer"
			content = '''		
				public interface «name»<T> {
					
					void consume(T value) throws Exception;
					
				}
			'''
		]
	}

}
