package de.fhws.rdsl.generator.db.components.spi

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class QueryTransformerProviderClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			name = "QueryTransformerProvider"
			pckg = dbSpiPckg
			content = '''
				public interface «name» {
				
					«type("de.fhws.rdsl.query.transformer.api.QueryTransformer")» getQueryTransformer(String source, String target);
				
				}
			'''
		]
	}

}
