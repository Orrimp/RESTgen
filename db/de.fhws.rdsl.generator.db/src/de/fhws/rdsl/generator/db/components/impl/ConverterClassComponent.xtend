package de.fhws.rdsl.generator.db.components.impl

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ConverterClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = dbPckg
			name = "Converter"
			content = '''		
				public interface «name»<T, R> {
					
					T convert(R from) throws Exception;
					
				}
			'''
		]
	}

}
