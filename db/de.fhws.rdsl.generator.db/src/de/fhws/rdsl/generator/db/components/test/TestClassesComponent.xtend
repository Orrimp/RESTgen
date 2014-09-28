package de.fhws.rdsl.generator.db.components.test


import java.util.List


import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*

import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.ReferenceTable

class TestClassesComponent extends AbstractComponent {
	
	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		var list1 = tables.filter(RootTable).map [ table |
			return new JavaClass => [
				name = table.name + "Test"
				pckg = dbTestPckg
				content = '''
					public class «name» extends AbstractSessionTest {
						
						@org.junit.Test
						public void testSaveAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(data, loadedData);
						}
					
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndRollback() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								this.session.rollback();
								this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test
						public void testSaveAndCommit() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								this.session.commit();
								
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision1() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(getRandomRevision(), data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision2() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndDeleteRevision() {
							«table.getSaveString(commonDbDataPckg)»
							try {
								this.session.delete«table.name»(getRandomRevision(), data.getIdentifier());
							} catch («commonDbExceptionsPckg».ConcurrencyException e) {
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
								throw e;
							}
						}
						
						@org.junit.Test
						public void testSaveAndUpdateAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» updatedData = getRandom«table.name»();
							updatedData.setIdentifier(data.getIdentifier());
							this.session.update«table.name»(data.getRevision(), updatedData);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(updatedData.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(updatedData, loadedData);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testLoadDataNotFound() {
							this.session.load«table.name»(new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(getRandomUUID()), «commonDbPckg».Locks.NONE);
						}
					
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testDeleteDataNotFound() {
						«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»();
						this.session.delete«table.name»(data.getRevision(), data.getIdentifier());
						}
					}
					
				'''
			]
		].toList

		var list2 = tables.filter(ReferenceTable).map [ table |
			return new JavaClass => [
				name = table.name + "Test"
				pckg = dbTestPckg
				content = '''
					public class «name» extends AbstractSessionTest {
						
						@org.junit.Test
						public void testSaveAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(data, loadedData);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndRollback() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
								this.session.update«table.name»(null, data);
								this.session.rollback();
								this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test
						public void testSaveAndCommit() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
								this.session.update«table.name»(null, data);
								this.session.commit();
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision1() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							this.session.update«table.name»(getRandomRevision(), data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision2() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							this.session.update«table.name»(null, data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndDeleteRevision() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							try {
								this.session.delete«table.name»(getRandomRevision(), data.getIdentifier());
							} catch («commonDbExceptionsPckg».ConcurrencyException e) {
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
								throw e;
							}
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndDelete() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							this.session.delete«table.name»(loadedData.getRevision(), loadedData.getIdentifier());
							this.session.load«table.name»(loadedData.getIdentifier(), «commonDbPckg».Locks.NONE);
						}
						
						@org.junit.Test
						public void testSaveAndUpdateAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» updatedData = getRandom«table.name»(left, right);
							updatedData.setIdentifier(data.getIdentifier());
							this.session.update«table.name»(data.getRevision(), updatedData);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(updatedData.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(updatedData, loadedData);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testLoadDataNotFound() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConstraintException.class)
						public void testDeleteAnchors1() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							this.session.delete«table.leftName»(left.getRevision(), left.getIdentifier());
						}
					
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConstraintException.class)
						public void testDeleteAnchors2() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							this.session.delete«table.rightName»(right.getRevision(), right.getIdentifier());
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testDeleteDataNotFound() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.delete«table.name»(data.getRevision(), data.getIdentifier());
						}
						
						«IF table.left.list && !table.right.list»
						@org.junit.Test(expected = «commonDbExceptionsPckg».OneToManyConstraintException.class)
						public void testConstraintViolation() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«commonDbDataPckg».«table.leftName»Data anotherLeft = saveRandom«table.leftName»();
							«type(commonDbDataPckg, table.name + "Data")» newData = getRandom«table.name»(anotherLeft, right);
							try {
								this.session.update«table.name»(null, newData);
							} catch («commonDbExceptionsPckg».OneToManyConstraintException e) {
								try {
									this.session.load«table.name»(newData.getIdentifier(), «commonDbPckg».Locks.NONE);
								} catch («commonDbExceptionsPckg».DataNotFoundException e2) {
									// ok
									throw e;
								}
							}
							org.junit.Assert.fail();
						}
						«ENDIF»
						«IF !table.left.list && table.right.list»
						@org.junit.Test(expected = «commonDbExceptionsPckg».OneToManyConstraintException.class)
						public void testConstraintViolation() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«commonDbDataPckg».«table.rightName»Data anotherRight = saveRandom«table.rightName»();
							«type(commonDbDataPckg, table.name + "Data")» newData = getRandom«table.name»(left, anotherRight);
							try {
								this.session.update«table.name»(null, newData);
							} catch («commonDbExceptionsPckg».OneToManyConstraintException e) {
								try {
									this.session.load«table.name»(newData.getIdentifier(), «commonDbPckg».Locks.NONE);
								} catch («commonDbExceptionsPckg».DataNotFoundException e2) {
									// ok
									throw e;
								}
							}
							org.junit.Assert.fail();
						}
						«ENDIF»
						«IF !table.left.list && !table.right.list»
						@org.junit.Test(expected =  «commonDbExceptionsPckg».OneToOneConstraintException.class)
						public void testConstraintViolation1() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«commonDbDataPckg».«table.leftName»Data anotherLeft = saveRandom«table.leftName»();
							«type(commonDbDataPckg, table.name + "Data")» newData = getRandom«table.name»(anotherLeft, right);
							this.session.update«table.name»(null, newData);
						}
						
						@org.junit.Test(expected =  «commonDbExceptionsPckg».OneToOneConstraintException.class)
						public void testConstraintViolation2() {
							«table.getSaveString(commonDbDataPckg)»
							«type(commonDbDataPckg, table.name + "Data")» data = getRandom«table.name»(left, right);
							this.session.update«table.name»(null, data);
							«commonDbDataPckg».«table.rightName»Data anotherRight = saveRandom«table.rightName»();
							«type(commonDbDataPckg, table.name + "Data")» newData = getRandom«table.name»(left, anotherRight);
							this.session.update«table.name»(null, newData);
						}
						«ENDIF»

					}
				'''
			]
		].toList

		var list3 = tables.filter(SubTable).map [ table |
			return new JavaClass => [
				name = table.name + "Test"
				pckg = dbTestPckg
				content = '''
					public class «name» extends AbstractSessionTest {
						
						@org.junit.Test
						public void testSaveAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(data, loadedData);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndRollback() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								this.session.update«table.name»(null, data);
								this.session.rollback();
								this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test
						public void testSaveAndCommit() {
							try {
								this.session.beginTransaction();
								«table.getSaveString(commonDbDataPckg)»
								this.session.update«table.name»(null, data);
								this.session.commit();
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
							} catch (Exception e) {
								this.session.rollback();
								throw e;
							}
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision1() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							this.session.update«table.name»(getRandomRevision(), data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndUpdateRevision2() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							this.session.update«table.name»(null, data);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».ConcurrencyException.class)
						public void testSaveAndDeleteRevision() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							try {
								this.session.delete«table.name»(getRandomRevision(), data.getIdentifier());
							} catch («commonDbExceptionsPckg».ConcurrencyException e) {
								«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
								org.junit.Assert.assertEquals(data, loadedData);
								throw e;
							}
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndDelete() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
							this.session.delete«table.name»(loadedData.getRevision(), loadedData.getIdentifier());
							this.session.load«table.name»(loadedData.getIdentifier(), «commonDbPckg».Locks.NONE);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testSaveAndDeleteParent() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							this.session.delete«table.parentTableName»(parent.getRevision(), parent.getIdentifier());
							this.session.load«table.name»(data.getIdentifier(), «commonDbPckg».Locks.NONE);
						}
						
						@org.junit.Test
						public void testSaveAndUpdateAndLoad() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.update«table.name»(null, data);
							«type(commonDbDataPckg, table.name + "Data")» updatedData = getRandom«table.name»(parent);
							updatedData.setIdentifier(data.getIdentifier());
							this.session.update«table.name»(data.getRevision(), updatedData);
							«type(commonDbDataPckg, table.name + "Data")» loadedData = this.session.load«table.name»(updatedData.getIdentifier(), «commonDbPckg».Locks.NONE);
							org.junit.Assert.assertEquals(updatedData, loadedData);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testLoadDataNotFound() {							
							this.session.load«table.name»(new «type(commonDbDataPckg, "DefaultResourceIdentifier")»(«table.keys.map['getRandomUUID()'].join(', ')»), «commonDbPckg».Locks.NONE);
						}
						
						@org.junit.Test(expected = «commonDbExceptionsPckg».DataNotFoundException.class)
						public void testDeleteDataNotFound() {
							«table.getSaveString(commonDbDataPckg)»
							this.session.delete«table.name»(data.getRevision(), data.getIdentifier());
						}
						
					}
				'''
			]
		].toList

		return (list1 + list2 + list3).toList
	}
	
	def getSaveString(SubTable table, String pckg) {
		'''
		«pckg».«table.parentTableName»Data parent = saveRandom«table.parentTableName»();
		«pckg».«table.name»Data data = getRandom«table.name»(parent);		
		'''
	}

	def getSaveString(ReferenceTable table, String pckg) {
		'''
			«pckg».«table.leftName»Data left = saveRandom«table.leftName»();
			«pckg».«table.rightName»Data right = saveRandom«table.rightName»();
		'''
	}
	
	def getParentTableName(SubTable table) {
		table.containment.parentTable.name
	}

	def getLeftName(ReferenceTable table) {
		table.left.parentTable.name
	}

	def getRightName(ReferenceTable table) {
		table.right.parentTable.name
	}

	def getSaveString(RootTable table, String pckg) {
		'''
			«pckg».«table.name»Data data = getRandom«table.name»();
			this.session.update«table.name»(null, data);
			
		'''
	}
	
}