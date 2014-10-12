package de.fhws.rdsl.generator.db.components.test


import de.fhws.rdsl.rdsl.PrimitiveType
import java.util.List

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.BooleanAttribute
import de.fhws.rdsl.generator.table.IntAttribute
import de.fhws.rdsl.generator.table.FloatAttribute
import de.fhws.rdsl.generator.table.DateAttribute
import de.fhws.rdsl.generator.table.StringAttribute

class AbstractSessionTestClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "AbstractSessionTest"
			pckg = dbTestPckg
			content = '''
				public abstract class «name» {
					
					@«type("javax.inject.Inject")»
					protected «type(commonDbPckg, "SessionFactory")» sessionFactory;
				
					protected «type(commonDbPckg, "Session")» session;
					
					@org.junit.Before
					public void init() {
						this.session = this.sessionFactory.createSession();					
					}
					
					@org.junit.After
					public void dispose() throws Exception {
						if (this.session != null) {
							this.session.close();
						}
					}
					
					protected String getRandomUUID() {
						return java.util.UUID.randomUUID().toString().replaceAll("\\-", "");
					}
				
					protected String getRandomString() {
						return org.apache.commons.lang3.RandomStringUtils.randomAlphabetic(64);
					}
				
					protected Integer getRandomInteger() {
						return new Integer(new java.util.Random().nextInt(1000));
					}
				
					protected Boolean getRandomBoolean() {
						return new java.util.Random().nextBoolean();
					}
					
					protected Double getRandomDouble() {
						return new java.util.Random().nextDouble();
					}
					
					protected java.util.Date getRandomDate() {
						return new java.util.Date();
					}
					
					protected String getRandomRevision() {
						return org.apache.commons.lang3.RandomStringUtils.randomAlphabetic(32);
					}
				
					protected «type(commonDbDataPckg, "ResourceIdentifier")» getResourceIdentifier(java.util.List<String> first, String last) {
						java.util.List<String> path = com.google.common.collect.Lists.newArrayList(first);
						path.add(last);
						return new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(path);
					}
				
					protected «type(commonDbDataPckg, "ResourceIdentifier")» getResourceIdentifier(String path) {
						return new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(path);
					}
				
					protected «type(commonDbDataPckg, "ReferenceIdentifier")» getReferenceIdentifier(«commonDbDataPckg».Data<«type(commonDbDataPckg, "ResourceIdentifier")»> left, «commonDbDataPckg».Data<«type(commonDbDataPckg, "ResourceIdentifier")»> right) {
						return new «type(commonDbDataPckg, "DefaultReferenceIdentifier")»(new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(left.getIdentifier().getPath()), new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(right.getIdentifier().getPath()));
					}
					
					
					«FOR table : tables»
						«IF table instanceof ReferenceTable»
							protected «type(commonDbDataPckg, table.name + "Data")» getRandom«table.name»(«commonDbDataPckg».«table.left.parentTable.name»Data left, «commonDbDataPckg».«table.right.parentTable.name»Data right) {
								return new «type(commonDbDataPckg, table.name + "Data")»() {
									{
										setIdentifier(getReferenceIdentifier(left, right));
										setRevision(getRandomRevision());
										«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
											set«attr.name.toFirstUpper»(«attr.methodByName»());
										«ENDFOR»
									}
								};
							}
						«ELSE»				
							protected «type(commonDbDataPckg, table.name + "Data")» getRandom«table.name»(«IF table instanceof SubTable»«commonDbDataPckg».«table.containment.parentTable.name»Data _parent«ENDIF») {
								return new «type(commonDbDataPckg, table.name + "Data")»() {
									{
										«IF table instanceof RootTable»
											setIdentifier(getResourceIdentifier(getRandomUUID()));
										«ELSEIF table.actualTable == table»
											setIdentifier(getResourceIdentifier(_parent.getIdentifier().getPath(), getRandomUUID()));
										«ELSE»
											setIdentifier(_parent.getIdentifier());
										«ENDIF»
										setRevision(getRandomRevision());							
										«FOR attr : table.members.filter(TableAttribute).filter[flags.empty]»
											set«attr.name.toFirstUpper»(«attr.methodByName»());
										«ENDFOR»
									}
								};
							}
						«ENDIF»
						
					«ENDFOR»
					
					«FOR table : tables.filter[!(it instanceof ReferenceTable)]»
						
						protected «type(commonDbDataPckg, table.name + "Data")» saveRandom«table.name»() {
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(«IF !(table instanceof RootTable)»saveRandom«(table as SubTable).containment.parentTable.name»()«ENDIF»);
							this.session.update«table.name»(null, data);
							return data;
						}
						
					«ENDFOR»
				}
			'''
		]
	}

	def getMethodByName(TableAttribute attr) {
		switch attr {
			BooleanAttribute: "getRandomBoolean"
			IntAttribute: "getRandomInteger"
			FloatAttribute: "getRandomDouble"
			DateAttribute: "getRandomDate"
			StringAttribute: "getRandomString"
		}
	}

}
