package de.fhws.rdsl.generator.db

import de.fhws.rdsl.generator.IMultipleResourceGenerator
import de.fhws.rdsl.generator.db.workflow.DBGenerator
import de.fhws.rdsl.rdsl.Configuration
import de.fhws.rdsl.rdsl.Package
import de.fhws.rdsl.workflow.FileSystemAccess
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.generator.IFileSystemAccess

class DBMultipleResourceGenerator implements IMultipleResourceGenerator {

	override doGenerate(ResourceSet input, IFileSystemAccess fsa) {
		println(input)

		val p = input.resources.map(r|r.allContents.toIterable.filter(typeof(Package))).flatten.toList.head
		val conf = input.resources.map(r|r.allContents.toIterable.filter(typeof(Configuration))).flatten.toList.head

		if(conf == null || p == null) {
			return
		}

		// TODO This should be done via Eclipse Extension Point!
		val generators = newArrayList(
		"de.fhws.rdsl.generator.db.mysql.workflow.MySQLDBGenerator",
		"de.fhws.rdsl.generator.db.riak.workflow.RiakDBGenerator")

		generators.forEach[type|
			try {
				val generatorClass = Class.forName(type);
				if(generatorClass != null) {
					val generator = generatorClass.newInstance as DBGenerator
					if(generator.isGeneratorFor(conf)) {
						generator.pckg = p
						generator.configuration = conf
						generator.fileSystemAccess = new XtextFileSystemAccess => [
							delegate = fsa
						]

						generator.run
					}
				}
			} catch(ClassNotFoundException e) {
				println("Generator " + type + " not found")
			}]
	}

	override doGenerate(Resource input, IFileSystemAccess fsa) {
		// Nothing
	}

}

class XtextFileSystemAccess implements FileSystemAccess {

	@Property IFileSystemAccess delegate

	override generateFile(String fileName, CharSequence contents) {
		delegate.generateFile(fileName, contents);
	}

}
