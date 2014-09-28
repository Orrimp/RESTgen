package de.fhws.rdsl.generator.db.mysql.components


import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.TableAttribute
import de.fhws.rdsl.generator.table.TableReference
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.SubTable
import java.util.List

import de.fhws.rdsl.generator.db.mysql.workflow.MySQLConfigurationKeys
import javax.inject.Named
import javax.inject.Inject
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class SQLSessionClassComponent extends AbstractComponent implements MySQLConfigurationKeys {

	@Inject @Named(DB_MYSQL_PACKAGE) protected String dbMySqlPckg
	@Inject @Named(DB_MYSQL_CONVERTERS_PACKAGE) protected String dbMySqlConvertersPckg

	override protected createJavaClass() {
		
		val tables = ctx.get(TABLES) as List<Table>

		return new JavaClass => [
			name = "SQLSession"
			pckg = dbMySqlPckg
			content = '''
				
				public abstract class «name» implements «type(commonDbPckg, "Session")» {
					
					private final «type(dbMySqlPckg, "LazyConnection")» connection;
					private boolean connectionUsed;
					private boolean transactionStarted = false;
					
					@«type("javax.inject.Inject")»
					public «name»(«type(dbMySqlPckg, "LazyConnection")» connection) {
						super();
						this.connection = connection;
					
					}
				
					private <T> T connectAndReturnSafely(«type(dbPckg, "ThrowingFunction")»<T, «type("java.sql.Connection")»> function) {
					try {
						return function.apply(getConnection());
					} catch (Exception e) {
						handleException(e);
						return null; // Will never be called.
					}
					}
				
					private void connectAndConsumeSafely(«type(dbPckg, "ThrowingConsumer")»<«type("java.sql.Connection")»> function) {
					try {
						function.consume(getConnection());
					} catch (Exception e) {
						handleException(e);
					}
					}
					
					protected void handleException(Exception t) {
						if (t instanceof «type(commonDbExceptionsPckg, "SessionException")») {
							throw («type(commonDbExceptionsPckg, "SessionException")») t;
						}
						if (t instanceof «type("java.sql.SQLException")») {
							handleSQLException((«type("java.sql.SQLException")») t);
						}
						throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(t);
					}
				
					protected abstract void handleSQLException(«type("java.sql.SQLException")» t);
				
					@Override
					public void beginTransaction() {
					try {
						getConnection().setAutoCommit(false);
						this.transactionStarted = true;
					} catch («type("java.sql.SQLException")» e) {
						throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
					}
					}
				
					private «type("java.sql.Connection")» getConnection() {
					this.connectionUsed = true;
					return this.connection.get();
					}
				
					@Override
					public void commit() {
					try {
						getConnection().commit();
					} catch («type("java.sql.SQLException")» e) {
						throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
					} finally {
						this.transactionStarted = false;
					}
					}
					
					@Override
					public void rollback() {
						try {
							getConnection().rollback();
						} catch («type("java.sql.SQLException")» e) {
							throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
						} finally {
							this.transactionStarted = false;
						}
					}
				
					@Override
					public void close() {
					try {
						if (this.connectionUsed) {
							getConnection().close();
						}
					} catch («type("java.sql.SQLException")» e) {
						throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(e);
					}
					}
				
					@Override
					public boolean isTransactionSupported() {
					return true;
					}
					
					private <T> T load(«type(commonDbDataPckg, "Identifier")» object, String template, «type(dbMySqlPckg,
					"ResultSetConverter")»<T> converter) {
						return connectAndReturnSafely(connection -> {
							try (final «type("java.sql.PreparedStatement")» stmt = connection.prepareStatement(template)) {
								if (object instanceof «type(commonDbDataPckg, "ResourceIdentifier")») {
									«type(commonDbDataPckg, "ResourceIdentifier")» resourceIdentifier = («type(commonDbDataPckg,
					"ResourceIdentifier")») object;
									for (int i = 0; i < resourceIdentifier.getPath().size(); i++) {
										stmt.setObject(i + 1, resourceIdentifier.getSegment(i));
									}
								} else if (object instanceof «type(commonDbDataPckg, "ReferenceIdentifier")») {
									«type(commonDbDataPckg, "ReferenceIdentifier")» referenceIdentifier = («type(commonDbDataPckg,
					"ReferenceIdentifier")») object;
									«type("java.util.List")»<Object> ids = «type("com.google.common.collect.Lists")».newArrayList();
									ids.addAll(referenceIdentifier.getId1().getPath());
									ids.addAll(referenceIdentifier.getId2().getPath());
									for (int i = 0; i < ids.size(); i++) {
										stmt.setObject(i + 1, ids.get(i));
									}
								}
								try (final «type("java.sql.ResultSet")» rs = stmt.executeQuery()) {
									if (rs.first()) {
										return converter.convert(rs);
									} else {
										throw new «type(commonDbExceptionsPckg, "DataNotFoundException")»(object.toString());
									}
								}
							}
						});
					}
				
					private void delete(String oldRevision, «type(commonDbDataPckg, "Identifier")» object, String template) {
					connectAndConsumeSafely(connection -> {
						try (final «type("java.sql.PreparedStatement")» stmt = connection.prepareStatement(template, java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE, java.sql.ResultSet.CONCUR_UPDATABLE)) {
							if (object instanceof «type(commonDbDataPckg, "ResourceIdentifier")») {
								«type(commonDbDataPckg, "ResourceIdentifier")» resourceIdentifier = («type(commonDbDataPckg,
					"ResourceIdentifier")») object;
								for (int i = 0; i < resourceIdentifier.getPath().size(); i++) {
									stmt.setObject(i + 1, resourceIdentifier.getSegment(i));
								}
							} else if (object instanceof «type(commonDbDataPckg, "ReferenceIdentifier")») {
								«type(commonDbDataPckg, "ReferenceIdentifier")» referenceIdentifier = («type(commonDbDataPckg,
					"ReferenceIdentifier")») object;
								«type("java.util.List")»<Object> ids = «type("com.google.common.collect.Lists")».newArrayList();
								ids.addAll(referenceIdentifier.getId1().getPath());
								ids.addAll(referenceIdentifier.getId2().getPath());
								for (int i = 0; i < ids.size(); i++) {
									stmt.setObject(i + 1, ids.get(i));
								}
							}
							try (ResultSet rs = stmt.executeQuery()) {
								if (!rs.first()) {
									throw new «type(commonDbExceptionsPckg, "DataNotFoundException")»(object.toString());
								} else {
									String _oldRevision = oldRevision == null ? "" : oldRevision;
									if (!_oldRevision.equals(rs.getObject("_revision"))) {
										throw new «type(commonDbExceptionsPckg, "ConcurrencyException")»(object.toString());
									}
									rs.deleteRow();									
								}
							}
						}
					});
					}
					
					private void deleteWithoutRevisionTest(«type(commonDbDataPckg, "Identifier")» object, String template) {
					connectAndConsumeSafely(connection -> {
						try (final «type("java.sql.PreparedStatement")» stmt = connection.prepareStatement(template)) {
							if (object instanceof «type(commonDbDataPckg, "ResourceIdentifier")») {
								«type(commonDbDataPckg, "ResourceIdentifier")» resourceIdentifier = («type(commonDbDataPckg,
					"ResourceIdentifier")») object;
								for (int i = 0; i < resourceIdentifier.getPath().size(); i++) {
									stmt.setObject(i + 1, resourceIdentifier.getSegment(i));
								}
							} else if (object instanceof «type(commonDbDataPckg, "ReferenceIdentifier")») {
								«type(commonDbDataPckg, "ReferenceIdentifier")» referenceIdentifier = («type(commonDbDataPckg,
					"ReferenceIdentifier")») object;
								«type("java.util.List")»<Object> ids = «type("com.google.common.collect.Lists")».newArrayList();
								ids.addAll(referenceIdentifier.getId1().getPath());
								ids.addAll(referenceIdentifier.getId2().getPath());
								for (int i = 0; i < ids.size(); i++) {
									stmt.setObject(i + 1, ids.get(i));
								}
							}
							stmt.executeUpdate();
							//if (stmt.executeUpdate() <= 0) {
							//	throw new DataNotFoundException(object.toString());
							//}
						}
					});
					}
				
					private String considerTransactionLock(String selectTemplate, int lock) {
					if (this.transactionStarted && lock == «type(commonDbPckg, "Locks")».TRANSACTION) {
						selectTemplate = selectTemplate + " for update";
					}
					return selectTemplate;
					}
					
					«FOR table : tables»
						«IF table instanceof ReferenceTable»
							@Override
							public «type(commonDbDataPckg, table.name.toFirstUpper + "Data")» load«table.name.toFirstUpper»(ReferenceIdentifier object, int lock) {
								final String template = considerTransactionLock(	
										"select «table.keys.join(', ')», _revision «table.joinedAttributes» from «table.name» where «table.keys.
					get(0)» = ? and «table.keys.get(1)» = ?",
										lock);
								return load(object, template, new «type(dbMySqlConvertersPckg, "To" + table.name.toFirstUpper + "Converter")»());					
							}
							
							@Override
							public void delete«table.name.toFirstUpper»(String oldRevision, ReferenceIdentifier object) {
								String template = "select * from «table.name» where «table.keys.get(0)» = ? and «table.keys.get(1)» = ? for update";
								delete(oldRevision, object, template);
							}
							
							@Override
							public void update«table.name.toFirstUpper»(String oldRevision, «type(commonDbDataPckg, table.name + "Data")» object) {
								connectAndConsumeSafely(connection -> {
									String template = "insert into «table.name» («table.insertIntoAttributes.map["`" + it + "`"].join(',')») values («table.insertIntoAttributes.map['?'].join(',')») on duplicate key update «table.revisionField» = ?, «table.revisionTempField» = ? «IF !table.attributes.empty», «table.attributes.map["`" + it + "`" + " = ?"].join(',')»«ENDIF»";
									try (final PreparedStatement stmt = connection.prepareStatement(template)) {
										stmt.setObject(1, object.getIdentifier().getId1().getLastSegment());
										stmt.setObject(2, object.getIdentifier().getId2().getLastSegment());
										stmt.setObject(3, object.getRevision());
										stmt.setObject(4, object.getRevision());
										«var counter = 5»
										«FOR attr : table.attributes»							
											stmt.setObject(«counter», object.get«attr.toFirstUpper»());
											// «counter = counter + 1»
										«ENDFOR»
										stmt.setObject(«counter», object.getRevision()); // «counter = counter + 1»
										stmt.setObject(«counter», oldRevision); // «counter = counter + 1»
										«FOR attr : table.attributes»							
										stmt.setObject(«counter», object.get«attr.toFirstUpper»());
										// «counter = counter + 1»
										«ENDFOR»
										if (stmt.executeUpdate() <= 0) {
											throw new InternalStorageException(object.toString());
										}
									}
								});
							}
						«ELSE»
							
							@Override
							public «type(commonDbDataPckg, table.name.toFirstUpper + "Data")» load«table.name.toFirstUpper»(ResourceIdentifier object, int lock) {
								final String template = considerTransactionLock(
										"select «table.keys.join(', ')», «table.revisionField» «FOR a : table.relevantMemberNames.map["`" + it + "`"] BEFORE ', ' SEPARATOR ', '»«a»«ENDFOR» from «table.
					actualTable.name» where «table.keys.map[it + " = ?"].join(' and ')» «IF table.baseField != null»and «table.
					baseField» is not null «ENDIF»",
										lock);
								return load(object, template, new «type(dbMySqlConvertersPckg, "To" + table.name.toFirstUpper + "Converter")»());
							}
							
							«IF table.actualTable == table»
							@Override
							public void update«table.name.toFirstUpper»(String oldRevision, «table.name.toFirstUpper»Data object) {
								final String template = "insert into «table.name» («table.insertIntoAttributes.join(', ')») values («table.insertIntoAttributes.map["?"].join(',')») on duplicate key update «table.revisionField» = ?, «table.revisionTempField» = ?, «table.attributes.map[it + " = ?"].join(',')»";
								connectAndConsumeSafely(connection -> {
									try (final PreparedStatement stmt = connection.prepareStatement(template)) {
										// «var counter = 1»
										«FOR key : table.keys»
										stmt.setObject(«counter», object.getIdentifier().getSegment(«counter-1»)); // «counter = counter + 1»
										«ENDFOR»
										stmt.setObject(«counter», object.getRevision()); // «counter = counter + 1»
										stmt.setObject(«counter», object.getRevision()); // «counter = counter + 1»
										«FOR attr : table.attributes»							
											stmt.setObject(«counter», object.get«attr.toFirstUpper»());
											// «counter = counter + 1»
										«ENDFOR»
										stmt.setObject(«counter», object.getRevision()); // «counter = counter + 1»
										stmt.setObject(«counter», oldRevision); // «counter = counter + 1»
										«FOR attr : table.attributes»							
										stmt.setObject(«counter», object.get«attr.toFirstUpper»());
										// «counter = counter + 1»
										«ENDFOR»
										if (stmt.executeUpdate() <= 0) {
											throw new InternalStorageException(object.toString());
										}
									}
								});
							}
							«ELSE»
							
							@Override
							public void update«table.name.toFirstUpper»(String oldRevision, «table.name.toFirstUpper»Data object) {
								// In nested objects also test if parent is not null: update
								// nestedNestedNestedObject where nestedObject != null and
								// nestedNestedObject != null
								final String template = "update «table.actualTable.name» «table.setFieldPart» «table.revisionField» = ?, «table.
					revisionTempField» = ?, «table.actualAttributes.map[it + " = ?"].join(', ')» where «table.keys.map[it + " = ?"].join(' and ')» «table.
					testNestedObjectPart»";
								connectAndConsumeSafely(connection -> {
									try (final PreparedStatement stmt = connection.prepareStatement(template)) {
										stmt.setObject(1, object.getRevision());
										stmt.setObject(2, oldRevision);
										// «var counter = 3»
										«FOR attr : table.attributes»
											stmt.setObject(«counter», object.get«attr.toFirstUpper»());
											// «counter = counter + 1»
										«ENDFOR»
										// «var idCounter = 0»
										«FOR key : table.keys»
											stmt.setObject(«counter», object.getIdentifier().getSegment(«idCounter»)); // «counter = counter + 1» «idCounter = idCounter +
					1»
										«ENDFOR»
										if (stmt.executeUpdate() <= 0) {
											throw new DataNotFoundException(object.toString());
										}
									}
								});
							}
							«ENDIF»
							
							@Override
							public void delete«table.name.toFirstUpper»(String oldRevision, ResourceIdentifier object) {
								«IF table.actualTable == table»
									String template = "select * from «table.name» where «table.keys.map[it + " = ?"].join(' and ')» for update";
									delete(oldRevision, object, template);
								«ELSE»									
									final String template = "select «table.keys.join(', ')», «FOR a : (table as SubTable).allFields SEPARATOR ', '»«a»«ENDFOR» from «table.actualTable.name» where «table.keys.map[it + " = ?"].join(' and ')» and «table.baseField» is not null for update";
									connectAndConsumeSafely(connection -> {
										try (final PreparedStatement stmt = connection.prepareStatement(template, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)) {
											// «var counter = 1»
											«FOR key : table.keys»
												stmt.setObject(«counter», object.getSegment(«counter - 1»)); // «counter = counter + 1»										
											«ENDFOR»
											try (ResultSet rs = stmt.executeQuery()) {
												if(!rs.first()) {
													throw new DataNotFoundException(object.toString());
												}
												String _oldRevision = oldRevision == null ? "" : oldRevision;
												if (!_oldRevision.equals(rs.getObject("«table.revisionField»"))) {
													throw new ConcurrencyException(object.toString());
												}
												«FOR attr: (table as SubTable).allFields»
												rs.updateObject("«attr»", null);
												«ENDFOR»
												rs.updateRow();
											}
										}
«««									«FOR childTable: table.listDescendants»
«««									deleteWithoutRevisionTest(object, "delete from «childTable.name» where «table.keys.map[it + " = ?"].join(' and ')»"); 
«»									});
								«ENDIF»
							}
														

							
							
						«ENDIF»				
					«ENDFOR»
					
								
				}
				
			'''
		]
	}
	
	def getTestNestedObjectPart(Table table) {
		if (table instanceof SubTable) {
			if (!table.containment.list) {
				var baseField = table.containment.parentTable.baseField
				if (baseField != null)
					return "and " + table.containment.parentTable.baseField + " is not null"
			}
		}
		return ""
	}

	def getSetFieldPart(Table table) {
		var baseField = table.members.filter(TableAttribute).filter[flags.contains("basefield")].head
		if (baseField == null) {
			return ""
		} else {
			return " set " + baseField.actualAttributeName + " = 1, "
		}
	}

	def getValueMarks(ReferenceTable table) {
		return 4 + table.attributes.length
	}

	def getJoinedAttributes(ReferenceTable table) {
		var els = table.attributes.map["`" + it + "`"].join(', ')
		if (els.empty) {
			""
		} else {
			", " + els
		}
	}

	def getAttributes(Table table) {
		table.members.filter(TableAttribute).filter[flags.empty].map[name]
	}



	def getRelevantMembers(Table table) {
		var members = table.members.filter(TableAttribute).filter[flags.empty] +
			table.members.filter(TableReference).filter[!list]
		return members;
	}

	def getRelevantMemberNames(Table table) {
		var relevantMembers = table.relevantMembers
		var names = relevantMembers.map [ member |
			if (member instanceof TableReference) {
				return member.name
			} else if (member instanceof TableAttribute) {
				return member.actualAttributeName
			}
		]
		return names
	}
	
	def getAllFields(SubTable subTable) {
		var allTables = newArrayList
		val allFields = newArrayList
		allTables += subTable
		allTables += subTable.containedNonListTables
		allTables.forEach[t |
			allFields += t.baseField
			allFields += t.revisionField
			allFields += t.revisionTempField
			allFields += t.relevantMemberNames
		]
		return allFields	
	}


	
	def getInsertIntoAttributes(Table table) {
		return table.keys + newArrayList(table.revisionField) + newArrayList(table.revisionTempField) + table.attributes
	}
	

}
