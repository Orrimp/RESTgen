package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class ResourceIdentifierClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			pckg = commonDbDataPckg
			name = "ResourceIdentifier"
			content = '''		
				public interface «name» extends Identifier {
					
					«type("java.util.List")»<String> getPath();
					
					String getSegment(int idx);
					
					String getLastSegment();
					
				}
			'''
		]
	}

}
