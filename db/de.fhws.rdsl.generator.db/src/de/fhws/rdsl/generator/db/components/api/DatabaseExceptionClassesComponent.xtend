package de.fhws.rdsl.generator.db.components.api

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class DatabaseExceptionClassesComponent extends AbstractComponent {

	override protected createJavaClass() {
		var excs = newArrayList(
			new ExceptionDefinition("ConcurrencyException", false, "SessionException"),
			new ExceptionDefinition("ConstraintException", false, "SessionException"),
			new ExceptionDefinition("DatabaseException", true, "RuntimeException"),
			new ExceptionDefinition("DataNotFoundException", false, "SessionException"),
			new ExceptionDefinition("DuplicateDataException", false, "ConstraintException"),
			new ExceptionDefinition("InitializationException", false, "DatabaseException"),
			new ExceptionDefinition("InternalStorageException", false, "SessionException"),
			new ExceptionDefinition("OneToManyConstraintException", false, "ConstraintException"),
			new ExceptionDefinition("OneToOneConstraintException", false, "ConstraintException"),
			new ExceptionDefinition("QueryException", false, "DatabaseException"),
			new ExceptionDefinition("SessionException", true, "DatabaseException")
		)
		excs.map [ ex |
			val javaClass = new JavaClass => [
				pckg = commonDbExceptionsPckg
				name = ex.name
				content = '''
					public «IF ex.abstract_»abstract «ENDIF»class «ex.name» extends «ex.extendedType» {
						
						public «ex.name»(String message, Throwable cause) {
							super(message, cause);
						}
						
						public «ex.name»(String message) {
							super(message);
						}
						
						public «ex.name»(Throwable cause) {
							super(cause);
						}
						
					}
				'''
			]
			return javaClass
		].toList
	}

}

@Data
class ExceptionDefinition {
	String name
	boolean abstract_
	String extendedType

}
