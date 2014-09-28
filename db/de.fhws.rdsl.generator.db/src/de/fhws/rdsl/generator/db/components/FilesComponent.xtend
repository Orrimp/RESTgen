package de.fhws.rdsl.generator.db.components

import de.fhws.rdsl.workflow.Component
import javax.inject.Inject
import de.fhws.rdsl.workflow.Context
import de.fhws.rdsl.workflow.FileSystemAccess
import de.fhws.rdsl.workflow.TextFile
import de.fhws.rdsl.workflow.JavaClass

class FilesComponent implements Component {

	@Inject
	protected Context context;

	@Inject
	protected FileSystemAccess fsa;

	override run() {

		context.files.filter(TextFile).forEach [ file |
			var fileName = file.getName
			val path = file.pckg.split("\\.").join('/')
			fsa.generateFile(path + '/' + fileName, file.content)
		]

		context.files.filter(JavaClass).forEach [ file |
			var fileName = file.getName + ".java"
			val path = file.pckg.split("\\.").join('/')
			val text = '''				
				package «file.pckg»;
				
				«FOR i : file.imports»
					import «i.name»;
				«ENDFOR»
				
				«file.content»
				'''
			fsa.generateFile(path + "/" + fileName, text)
		]
	}

}
