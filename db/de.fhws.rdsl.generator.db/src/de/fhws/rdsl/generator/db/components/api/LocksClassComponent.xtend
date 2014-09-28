package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class LocksClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = commonDbPckg
			name = "Locks"
			content = '''		
				public interface «name» {
					
					public static int NONE = 0;
					public static int TRANSACTION = 1;
					
				}
			'''
		]
	}

}