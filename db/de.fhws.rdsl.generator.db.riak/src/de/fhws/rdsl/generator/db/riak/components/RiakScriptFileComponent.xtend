package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.workflow.TextFile
import java.util.List
import de.fhws.rdsl.generator.table.Table

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*

class RiakScriptFileComponent extends AbstractComponent implements RiakConfigurationKeys {
	
	@Inject @Named(DB_RIAK_RESOURCES_PACKAGE)
	protected String dbRiakResourcesPckg
	
	override run() {
		val tables = ctx.get(TABLES) as List<Table>
		ctx.addFile(new TextFile => [
			pckg = dbRiakResourcesPckg
			name = "install.sh"
			content = '''
			#!/bin/sh
			# install-script for riak
			«FOR table : tables.filter[it == it.actualTable]»
			sudo $riak_home/bin/search-cmd set-schema «table.name» «table.name»-schema.erl
			curl -i http://$riak_host:$riak_port/buckets/counterBucket/props -X PUT -d '{"props":{"allow_mult":true}}' -H "Content-Type: application/json"
			«ENDFOR»
			'''
		])
	}
	
}