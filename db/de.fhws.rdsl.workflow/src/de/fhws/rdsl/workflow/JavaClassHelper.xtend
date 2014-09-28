package de.fhws.rdsl.workflow;

import java.util.Map
import java.util.Set
import org.apache.commons.lang.text.StrSubstitutor
import de.fhws.rdsl.workflow.JavaClass
import java.util.HashMap

class JavaClassHelper {

	var Set<String> types = newHashSet()

	def register(String typeName) {
		types.add(typeName)
		'${' + typeName + '}'
	}


	def organizeImports(JavaClass doc) {

		val map = correctMap(createMap)
		map.filter[k, v|k != v].filter[k, v|!k.startsWith("java.lang")].forEach [ k, v |
			if (!doc.imports.map[it.name].contains(v)) {
				doc.imports.add(new Import(k))
			}
		]
		val requestedImports = newArrayList

		val str = new StrSubstitutor(
			new HashMap() {

				override get(Object key) {
					requestedImports.add(new Import(String.valueOf(key)));
					map.get(key)
				}

			})
		val newBody = str.replace(doc.content)
		doc.content = newBody
		
		val docImports = newArrayList()
		docImports.addAll(doc.imports)
		doc.imports.clear
		docImports.forEach[ i |
			if(requestedImports.contains(i)) {
				doc.imports.add(i)
			}
		]
		
		return doc
	}

	def private createMap() {
		val Map<String, String> map = newHashMap()
		types.forEach[map.put(it, it.split('\\.').last)]
		return map
	}

	// Find duplicate simple class names
	def private correctMap(Map<String, String> map) {

		val Map<String, Integer> duplicates = newHashMap()
		val Map<String, String> newMap = newHashMap()
		map.forEach [ key, value |
			if (!duplicates.containsKey(value)) {
				duplicates.put(value, 0)
			}
			duplicates.put(value, duplicates.get(value) + 1)
			newMap.put(key, if(duplicates.get(value) > 1) key else value)
		]
		return newMap

	}

}
