package de.fhws.rdsl.generator.db.components.api


import java.util.List


import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*

import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.TableReference

class DataClassesComponent extends AbstractComponent {
	
	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return tables.map[ table |		
			return new JavaClass => [
				pckg = commonDbDataPckg
				name = table.name.toFirstUpper + "Data"
				content = 
				'''
				public class «name» extends «if(table instanceof ReferenceTable) "ReferenceData" else "ResourceData"» {
					
					«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
					
					protected «attr.type.javaType» «attr.name.toFirstLower»;
					
					public «attr.type.javaType» get«attr.name.toFirstUpper»() {
						return this.«attr.name.toFirstLower»;
					}
					
					public void set«attr.name.toFirstUpper»(«attr.type.javaType» value) {
						this.«attr.name.toFirstLower» = value;
					}
					
					«ENDFOR»
					
					«FOR ref : table.members.filter(TableReference).filter[!list]»

					protected ResourceIdentifier «ref.name.toFirstLower»;
					
					public ResourceIdentifier get«ref.name.toFirstUpper»() {
						return this.«ref.name.toFirstLower»;
					}
					
					«ENDFOR»
					
					
					@Override
					public boolean equals(Object _obj) {
						if (this == _obj) {
							return true;
						}
						if (_obj == null) {
							return false;
						}
						if (! (_obj instanceof «name»)) {
							return false;
						}
						
						«name» _other = («name») _obj;
						
						if (this.revision == null) {
							if (_other.revision != null) {
								return false;
							}
						} else if(!this.revision.equals(_other.revision)) {
							return false;
						}
						
						«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
						if (this.«attr.name.toFirstLower» == null) {
							if (_other.«attr.name.toFirstLower» != null) {
								return false;
							}
						} else if(!this.«attr.name.toFirstLower».equals(_other.«attr.name.toFirstLower»)) {
							return false;
						}
						«ENDFOR»
						
						return true;
						
					}

					
					@Override
					public String getClassifier() {
						return "«table.name.toFirstUpper»";
					}
				}
				'''
			]
		]		
	}
	
}