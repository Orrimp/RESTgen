package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.rdsl.PrimitiveType
import java.util.List
import javax.inject.Inject
import javax.inject.Named

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.workflow.TextFile

class RiakSchemaFilesComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(RIAK_USE_WHITESPACE_ANALYZER)	
	protected Boolean useWhitespaceAnalyzer
	
	@Inject @Named(DB_RIAK_RESOURCES_PACKAGE) protected String dbRiakResourcesPckg

	override run() {
		val tables = ctx.get(TABLES) as List<Table>
		val files = newArrayList

		files += tables.filter[it == it.actualTable].map [ table |
			return new TextFile => [
				name = table.name + "-schema.erl"
				pckg = dbRiakResourcesPckg
				content = '''
					{
						schema,
						[
							{version, "1.1"},
							{n_val, 3},
							{default_field, "___value___"},
							{analyzer_factory, {erlang, text_analyzers, whitespace_analyzer_factory}}
						],
					}
					[
						«FOR key : table.keys»
							{ field, [
								{name, "«key»"},
								{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
							]},					
						«ENDFOR»
						
						«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
							«attr.getFieldDefinition»,
						«ENDFOR»
						
						«FOR child : table.nonListDescendants»
							{ field, [
								{name, "«child.revisionField»"},
								{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
							]},
							{ field, [
								{name, "«child.baseField»"},
								{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
							]},
							
							«FOR attr : child.members.filter(TableAttribute).filter[flags.empty]»
								«attr.getFieldDefinition»,
							«ENDFOR»
							
						«ENDFOR»
						
						{ field, [
							{name, "_dummy"},
							{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
						]},
						
						{ field, [
							{name, "«table.revisionField»"},
							{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
						]},
						
						{ dynamic_field, [
							{name, "*"},
							{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
						]}
					]
				'''
			]
		].toList
		files.forEach[ctx.addFile(it)]
	}

	def getFieldDefinition(TableAttribute attribute) {
		'''
			{ field, [
				{name, "«attribute.actualAttributeName»"},
				«IF attribute.queryable»
					«IF attribute.type == PrimitiveType.BOOLEAN.getName»
						{type, string},
						{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
					«ELSEIF attribute.type == PrimitiveType.INT.getName»
						{type, integer},
						{padding_size, 16}
					«ELSEIF attribute.type == PrimitiveType.STRING.getName»
						{type, string},
						{analyzer_factory, {erlang, text_analyzers, «IF useWhitespaceAnalyzer»whitespace_analyzer_factory«ELSE»standard_analyzer_factory«ENDIF»}}
					«ELSEIF attribute.type == PrimitiveType.DATE.getName»
						{type, date}
					«ELSE»
						{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
					«ENDIF»
				«ELSE»
					{analyzer_factory, {erlang, text_analyzers, noop_analyzer_factory}}
				«ENDIF»
			]}
		'''
	}
}
