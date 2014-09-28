package de.fhws.rdsl.generator.db.components.spi

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class DistributedLockClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			name = "DistributedLock"
			pckg = dbSpiPckg
			content = '''
				public interface «name» {
					
					«type("java.util.concurrent.locks.Lock")» getLock(Object obj);
					
				}
			'''
		]
	}

}
