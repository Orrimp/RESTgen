package de.fhws.rdsl.generator.db.riak.components

import de.fhws.rdsl.generator.table.ReferenceTable
import de.fhws.rdsl.generator.table.RootTable
import de.fhws.rdsl.generator.table.SubTable
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.table.TableReference
import java.util.List

import de.fhws.rdsl.generator.db.riak.workflow.RiakConfigurationKeys
import javax.inject.Named
import javax.inject.Inject

import static extension de.fhws.rdsl.generator.db.utils.TableUtils.*
import de.fhws.rdsl.generator.table.Table
import de.fhws.rdsl.generator.db.workflow.AbstractComponent
import de.fhws.rdsl.workflow.JavaClass

class RiakSessionClassComponent extends AbstractComponent implements RiakConfigurationKeys {

	@Inject @Named(DB_RIAK_PACKAGE) protected String dbRiakPckg
	@Inject @Named(DB_RIAK_CONVERTERS_PACKAGE) protected String dbRiakConvertersPckg
	
	override protected createJavaClass() {
		val tables = ctx.get(TABLES) as List<Table>
		return new JavaClass => [
			
			name = "RiakSession"
			pckg = dbRiakPckg
			content =
			'''
			public class «name» implements «type(commonDbPckg, "Session")» {
				
				private boolean transactionStarted = false;
				private «type("de.fhws.rdsl.riak.JSONConverter")» jsonConverter;
				private «type(dbSpiPckg, "DistributedLock")» distributedLock;
				private «type("de.fhws.rdsl.riak.RiakConnection")» connection;
				private «type("java.util.Map")»<Object, «type("java.util.concurrent.locks.Lock")»> lockReferencesMap = «type("com.google.common.collect.Maps")».newHashMap();
				private static final long TRY_LOCK_TIMEOUT = 5000;
				private static final String UTF8 = "UTF-8";
				
			
			
				@«type("javax.inject.Inject")»
				public RiakSession(RiakConnection connection, JSONConverter jsonConverter, DistributedLock distributedLock) {
					this.jsonConverter = jsonConverter;
					this.distributedLock = distributedLock;
					this.connection = connection;
				}
				
				private void releaseLocks() {
					this.lockReferencesMap.values().forEach(Lock::unlock);
					this.lockReferencesMap.clear();
				}
			
			
				private void lock(String bucket, String key) {
					String id = bucket + "." + key;
					if (this.transactionStarted && !this.lockReferencesMap.containsKey(id)) {
						Lock lock = this.distributedLock.getLock(id);
						try {
							if (lock.tryLock(TRY_LOCK_TIMEOUT, «type("java.util.concurrent.TimeUnit")».MILLISECONDS)) {
								this.lockReferencesMap.put(id, lock);
							} else {
								throw new «type(commonDbExceptionsPckg, "ConcurrencyException")»(""); // TODO message
							}
						} catch (InterruptedException e) {
							lock.unlock();
							throw new ConcurrencyException(e);
						} catch (Exception e) {
							lock.unlock();
							throw e;
						}
					}
				}
				
				private <T> T connectAndReturnSafely(«type(dbPckg, "ThrowingFunction")»<T, RiakConnection> function) {
					try {
						return function.apply(this.connection);
					} catch (Exception e) {
						handleException(e);
						return null; // Will never be called.
					}
				}
			
				private void connectAndConsumeSafely(«type(dbPckg, "ThrowingConsumer")»<RiakConnection> function) {
					try {
						function.consume(this.connection);
					} catch (Exception e) {
						handleException(e);
					}
				}
				
				
				protected void handleException(Exception t) {
					if (t instanceof «type(commonDbExceptionsPckg, "SessionException")») {
						throw (SessionException) t;
					}
					throw new «type(commonDbExceptionsPckg, "InternalStorageException")»(t);
				}
			
				private static String getKey(«type(commonDbDataPckg, "Identifier")» identifier) {
					if (identifier instanceof «type(commonDbDataPckg, "ResourceIdentifier")») {
						return getKey((«type(commonDbDataPckg, "ResourceIdentifier")») identifier);
					} else {
						return getKey((«type(commonDbDataPckg, "ReferenceIdentifier")») identifier);
					}
				}
			
				private static String getKey(«type(commonDbDataPckg, "ResourceIdentifier")» identifier) {
					return «type("com.google.common.base.Joiner")».on('|').join(identifier.getPath());
				}
			
				private static String getKey(«type(commonDbDataPckg, "ReferenceIdentifier")» identifier) {
					String part1 = getKey(identifier.getId1());
					String part2 = getKey(identifier.getId2());
					return part1 + ';' + part2;
				}
				
				private static «type("org.json.JSONObject")» fetchJSON(RiakSession session, String bucket, String key, JSONConverter jsonConverter) throws «type("java.io.IOException")» {
					«type("com.basho.riak.client.IRiakObject")» riakObject = session.fetch(bucket, key);
					if (riakObject != null) {
						return jsonConverter.fromBytes(riakObject.getValue(), UTF8);
					} else {
						return null;
					}
				}
			
				private static void setLink(RiakSession session, JSONConverter jsonConverter, String bucket, String key, String tag, String targetBucket, String targetKey)
				        throws IOException, JSONException {
					IRiakObject riakObject = session.fetch(bucket, key);
					if (riakObject == null) {
						throw new «type(commonDbExceptionsPckg, "DataNotFoundException")»(bucket + "." + key);
					}
					«type("com.basho.riak.client.RiakLink")» target = null;
					for (RiakLink link : riakObject) {
						if (link.getTag().equals(tag)) {
							target = link;
						}
					}
					if (target != null) {
						riakObject.removeLink(target);
					}
			
					riakObject.addLink(new RiakLink(targetBucket, targetKey, tag));
					JSONObject content = «type("de.fhws.rdsl.riak.RiakUtils")».fetchJSON(riakObject, jsonConverter);
					if (content != null) {
						content.put(tag, targetKey);
					}
					riakObject = RiakUtils.updateRiakObject(riakObject, content, jsonConverter);
					session.store(riakObject);
				}
				
				private static void removeLink(RiakSession session, JSONConverter jsonConverter, String bucket, String key, String tag) throws IOException, «type("org.json.JSONException")» {
					IRiakObject riakObject = session.fetch(bucket, key);
					if (riakObject == null) {
						throw new DataNotFoundException(bucket + "." + key);
					}
					RiakLink target = null;
					for (RiakLink link : riakObject) {
						if (link.getTag().equals(tag)) {
							target = link;
						}
					}
					if (target != null) {
						riakObject.removeLink(target);
						JSONObject content = RiakUtils.fetchJSON(riakObject, jsonConverter);
						if (content != null) {
							content.remove(tag);
						}
						riakObject = RiakUtils.updateRiakObject(riakObject, content, jsonConverter);
						session.store(riakObject);
					}
				}
			
				private static String getKey(String... path) {
					return Joiner.on('|').join(path);
				}
			
				public void store(IRiakObject object) throws IOException {
					this.connection.store(object);
				}
				
				private IRiakObject fetchHead(String bucket, String key) throws IOException {
					«type("com.basho.riak.client.raw.RiakResponse")» response = this.connection.head(bucket, key, «type("com.basho.riak.client.raw.FetchMeta")».head());
					IRiakObject[] riakObjects = response.getRiakObjects();
					if (riakObjects.length > 1) {
						throw new ConcurrencyException(""); // TODO: message
					} else if (riakObjects.length == 1) {
						return riakObjects[0];
					} else {
						return null;
					}
				}
				
				public IRiakObject fetch(String bucket, String key) throws IOException {
					RiakResponse response = this.connection.fetch(bucket, key);
					if (response.hasValue()) {
						IRiakObject[] riakObjects = response.getRiakObjects();
						if (riakObjects.length > 1) {
							throw new ConcurrencyException(""); // TODO: message
						} else {
							return riakObjects[0];
						}
					} else {
						return null;
					}
				}
				
				private void increment(String bucket, String entity, String key) throws IOException {
					this.connection.incrementCounter("counterBucket", bucket + entity + key, 1l, «type("com.basho.riak.client.raw.StoreMeta")».empty());
				}
			
				private void decrement(String bucket, String entity, String key) throws IOException {
					this.connection.incrementCounter("counterBucket", bucket + entity + key, -1l, «type("com.basho.riak.client.raw.StoreMeta")».empty());
				}
			
				private long fetchCounter(String bucket, String entity, String key) throws IOException {
					Long counter = this.connection.fetchCounter("counterBucket", bucket + entity + key, null);
					return counter == null ? 0l : counter;
				}
				
«««				private <T extends «type(commonDbDataPckg, "Data")»<?>> T loadRootData(String bucket, Identifier identifier, int lock, «type(dbRiakConvertersPckg, "FromJSONObjectConverter")»<T> converter) {
«««					return connectAndReturnSafely(connection -> {
«««						String riakKey = getKey(identifier);
«««						if (lock == «type(commonDbPckg, "Locks")».TRANSACTION) {
«««							lock(bucket, riakKey);
«««						}
«««						IRiakObject riakObject = fetch(bucket, riakKey);
«««						if (riakObject != null) {
«««							JSONObject jsonObject = RiakUtils.fetchJSON(riakObject, this.jsonConverter);
«««							return converter.convert(jsonObject);
«««						} else {
«««							throw new DataNotFoundException(identifier.toString());
«««						}
«««					});
«»			
				private void checkRevision(IRiakObject riakObject, String revisionMetaDataKey, String oldRevisionValue) {
					if (!«type("com.google.common.base.Objects")».equal(riakObject.getUsermeta(revisionMetaDataKey), oldRevisionValue)) {
						throw new ConcurrencyException(oldRevisionValue);
					}
				}
				
				@Override
				public void close() throws Exception {
					this.transactionStarted = false;
					releaseLocks();
					this.connection.close();
				}
			
				@Override
				public boolean isTransactionSupported() {
					return false;
				}
			
				@Override
				public void beginTransaction() {
					this.transactionStarted = true;
				}
			
				@Override
				public void commit() {
					releaseLocks();
					this.transactionStarted = false;
				}
			
				@Override
				public void rollback() {
					releaseLocks();
					this.transactionStarted = false;
				}
				
				«FOR table : tables.filter[!(it instanceof ReferenceTable)].filter[it instanceof RootTable || it == it.actualTable]»
				@Override
				public void update«table.name»(String oldRevision, «type(commonDbDataPckg, table.name + "Data")» data) {
					connectAndConsumeSafely(connection -> {
						«IF table instanceof SubTable»
						«FOR parent : table.parentTables»
						String keyFor«parent.name» = getKey(«FOR int i : (0..parent.keys.size) SEPARATOR ', '»data.getIdentifier().getSegment(«i»)«ENDFOR»);
						if(this.transactionStarted) lock("«parent.name»", keyFor«parent.name»);
						«ENDFOR»
						«ENDIF»
						String riakKey = getKey(data.getIdentifier());
						if(this.transactionStarted) lock("«table.name»", riakKey);
						«IF table.hasContainmentMembers»
						IRiakObject riakObject = fetch("«table.name»", riakKey);
						«ELSE»
						IRiakObject riakObject = fetchHead("«table.name»", riakKey);
						«ENDIF»
						if (riakObject == null) {
							JSONObject jsonObject = new «type(dbRiakConvertersPckg, "From" + table.name + "Converter")»(null).convert(data);
							riakObject = RiakUtils.newRiakObject("«table.name»", riakKey, jsonObject, this.jsonConverter);
						} else {
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							JSONObject toUpdate = RiakUtils.fetchJSON(riakObject, this.jsonConverter);
							JSONObject jsonObject = new  «type(dbRiakConvertersPckg, "From" + table.name + "Converter")»(toUpdate).convert(data);
							riakObject = RiakUtils.updateRiakObject(riakObject, jsonObject, this.jsonConverter);							
						}						
						riakObject.addUsermeta("«table.revisionField»", data.getRevision());
						connection.store(riakObject);
					});
				}
				
							
				@Override
				public «table.name»Data load«table.name»(«type(commonDbDataPckg, "ResourceIdentifier")» identifier, int lock) {
					return connectAndReturnSafely(connection -> {
						String riakKey = getKey(identifier);
						if (lock == Locks.TRANSACTION) {
							lock("«table.name»", riakKey);
						}
						JSONObject jsonObject = fetchJSON(this, "«table.name»", riakKey, this.jsonConverter);
						if (jsonObject != null) {
							return new «type(dbRiakConvertersPckg, "To" + table.name + "Converter")»().convert(jsonObject);
						} else {
							throw new DataNotFoundException(identifier.toString());
						}
					});
				}
				
				@Override
				public void delete«table.name»(String oldRevision, «type(commonDbDataPckg, "ResourceIdentifier")» identifier) {
					connectAndConsumeSafely(connection -> {
						String riakKey = getKey(identifier);
						if(this.transactionStarted) lock("«table.name»", riakKey);
						IRiakObject riakObject = fetchHead("«table.name»", riakKey);
						if(riakObject != null) {
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							// Check constraints
							«FOR ref : table.members.filter(TableReference)»
							if(fetchCounter("«ref.referenceTable.name»", "«table.name»", riakKey) > 0) {
								throw new «type(commonDbExceptionsPckg, "ConstraintException")»("«ref.name»");
							}
							«ENDFOR»							
							// Delete subobjects
							«FOR sub : table.containedListChildren»
							{
								«type("java.util.List")»<String> query = new «type("java.util.ArrayList")»<String>();
								«FOR int i : (0..table.keys.size-1)»
								query.add("«table.keys.get(i)»:\"" + identifier.getSegment(«i») + "\""); 
								«ENDFOR»								
								connection.deleteByQuery("«sub.name»", Joiner.on(" AND ").join(query));
							}							
							«ENDFOR»
							// Delete object
							connection.delete("«table.name»", riakKey);
						} else {
							throw new DataNotFoundException(identifier.toString());
						}
					});

				}
				«ENDFOR»
				
				«FOR table : tables.filter(ReferenceTable)»
				@Override
				public void delete«table.name»(String oldRevision, «type(commonDbDataPckg, "ReferenceIdentifier")» identifier) {
					connectAndConsumeSafely(connection -> {
						String riakKey = getKey(identifier);
						String leftRiakKey = getKey(identifier.getId1());
						String rightRiakKey = getKey(identifier.getId2());
						if(this.transactionStarted) {
							lock("«table.left.parentTable.name»", leftRiakKey);
							lock("«table.right.parentTable.name»", rightRiakKey);
							lock("«table.name»", riakKey);
						}
						IRiakObject riakObject = fetchHead("«table.name»", riakKey);
						if(riakObject != null) {
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							
							// Delete object
							connection.delete("«table.name»", riakKey);
							
	
							
							// Delete reference counters
							«IF !table.left.list && !table.right.list»
							// Delete cross references
							removeLink(this, this.jsonConverter, "«table.left.parentTable.name»", leftRiakKey, "«table.left.name»");
							removeLink(this, this.jsonConverter, "«table.right.parentTable.name»", rightRiakKey, "«table.right.name»");					
							«ENDIF»
							«IF table.left.list && !table.right.list»
							removeLink(this, this.jsonConverter, "«table.right.parentTable.name»", rightRiakKey, "«table.right.name»");
							«ENDIF»
							«IF !table.left.list && table.right.list»
							removeLink(this, this.jsonConverter, "«table.left.parentTable.name»", leftRiakKey, "«table.left.name»");
							«ENDIF»
							decrement("«table.name»", "«table.left.parentTable.name»", leftRiakKey);
							decrement("«table.name»", "«table.right.parentTable.name»", rightRiakKey);
						} else {
							throw new DataNotFoundException(identifier.toString());
						}
					});
				}
				
				@Override
				public «type(commonDbDataPckg, table.name + "Data")» load«table.name»(«type(commonDbDataPckg, "ReferenceIdentifier")» identifier, int lock) {
					return connectAndReturnSafely(connection -> {
						String riakKey = getKey(identifier);
						if (lock == «type(commonDbPckg, "Locks")».TRANSACTION) {
							lock("«table.name»", riakKey);
						}
						JSONObject jsonObject = fetchJSON(this, "«table.name»", riakKey, this.jsonConverter);
						if (jsonObject != null) {
							return new «type(dbRiakConvertersPckg, "To" + table.name + "Converter")»().convert(jsonObject);
						} else {
							throw new DataNotFoundException(identifier.toString());
						}
					});
				}
				
				@Override
				public void update«table.name»(String oldRevision, «table.name»Data data) {
					connectAndConsumeSafely(connection -> {
						String riakKey = getKey(data.getIdentifier());						
						String leftRiakKey = getKey(data.getIdentifier().getId1());
						String rightRiakKey = getKey(data.getIdentifier().getId2());
						if(this.transactionStarted) {
							lock("«table.name»", riakKey);
							lock("«table.left.parentTable.name»", leftRiakKey);
							lock("«table.right.parentTable.name»", rightRiakKey);
						}
						IRiakObject riakObject = fetchHead("«table.name»", riakKey);
						JSONObject jsonObject = new «type(dbRiakConvertersPckg, "From" + table.name + "Converter")»(null).convert(data);
						if(riakObject != null) { // update object
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							riakObject = RiakUtils.updateRiakObject(riakObject, jsonObject, this.jsonConverter);
							riakObject.addUsermeta("«table.revisionField»", data.getRevision());
							connection.store(riakObject); 
						} else { // create new object

							
							// Check constraints
							«IF !table.left.list && !table.right.list»
							boolean check1 = fetchCounter("«table.name»", "«table.left.parentTable.name»", leftRiakKey) < 1;
							boolean check2 = fetchCounter("«table.name»", "«table.right.parentTable.name»", rightRiakKey) < 1;
							if(!check1 || !check2) {
								throw new «type(commonDbExceptionsPckg, "OneToOneConstraintException")»(data.toString());
							}
							«ENDIF»
							«IF !table.left.list && table.right.list»
							if(fetchCounter("«table.name»", "«table.left.parentTable.name»", leftRiakKey) >= 1) {
								throw new «type(commonDbExceptionsPckg, "OneToManyConstraintException")»(data.toString());
							}
							«ENDIF»
							«IF table.left.list && !table.right.list»
							if(fetchCounter("«table.name»", "«table.right.parentTable.name»", rightRiakKey) >= 1) {
								throw new «type(commonDbExceptionsPckg, "OneToManyConstraintException")»(data.toString());
							}
							«ENDIF»
							
							riakObject = RiakUtils.newRiakObject("«table.name»", riakKey, jsonObject, this.jsonConverter);
							riakObject.addUsermeta("«table.revisionField»", data.getRevision());
							
							// Store object
							connection.store(riakObject);
							
							// Store cross references
							«IF !table.left.list && !table.right.list»
							setLink(this, this.jsonConverter, "«table.left.parentTable.name»", leftRiakKey, "«table.left.name»", "«table.right.parentTable.name»", rightRiakKey);
							setLink(this, this.jsonConverter, "«table.right.parentTable.name»", rightRiakKey, "«table.right.name»", "«table.left.parentTable.name»", leftRiakKey);
							«ENDIF»
							«IF table.left.list && !table.right.list»
							setLink(this, this.jsonConverter, "«table.right.parentTable.name»", rightRiakKey, "«table.right.name»", "«table.left.parentTable.name»", leftRiakKey);
							«ENDIF»
							«IF !table.left.list && table.right.list»
							setLink(this, this.jsonConverter, "«table.left.parentTable.name»", leftRiakKey, "«table.left.name»", "«table.right.parentTable.name»", rightRiakKey);
							«ENDIF»
							
							// Increment counters
							increment("«table.name»", "«table.left.parentTable.name»", leftRiakKey);
							increment("«table.name»", "«table.right.parentTable.name»", rightRiakKey);
							
						}
					});
					
					
				}
				«ENDFOR»
				«FOR table : tables.filter(SubTable).filter[!it.containment.list]»
				public void delete«table.name»(String oldRevision, «type(commonDbDataPckg, "ResourceIdentifier")» identifier) {
					connectAndConsumeSafely(connection -> {
						«FOR parent : table.parentTables»
						String keyFor«parent.name» = getKey(«FOR int i : (0..parent.keys.size) SEPARATOR ', '»identifier.getSegment(«i»)«ENDFOR»);
						if(this.transactionStarted) lock("«parent.name»", keyFor«parent.name»);
						«ENDFOR»
						String riakKey = getKey(identifier);
						if(this.transactionStarted) lock("«table.name»", riakKey);
						IRiakObject riakObject = fetch("«table.actualTable.name»", riakKey);
						if(riakObject == null) {
							throw new DataNotFoundException(identifier.toString());
						}
						JSONObject jsonObject = RiakUtils.fetchJSON(riakObject, this.jsonConverter);
						if(jsonObject == null) {
							throw new DataNotFoundException(identifier.toString());
						}
						String parentExistsField = "«table.containment.parentTable.revisionField»";
						if(!RiakUtils.contains(jsonObject, parentExistsField)) {
							throw new DataNotFoundException(identifier.toString());
						}
						
						boolean exists = RiakUtils.contains(jsonObject, "«table.revisionField»");
						if(exists) { // delete existing object
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							
							// delete table
							jsonObject.put("«table.baseField»", org.json.JSONObject.NULL);
							jsonObject.put("«table.revisionField»", org.json.JSONObject.NULL);
							«FOR attr : table.actualAttributes»
							jsonObject.put("«attr»", org.json.JSONObject.NULL);
							«ENDFOR»
							
							// delete containing 1:1 tables
							«FOR child : table.containedNonListTables»
							jsonObject.put("«child.baseField»", org.json.JSONObject.NULL);
							jsonObject.put("«child.revisionField»", org.json.JSONObject.NULL);
							«FOR attr : child.actualAttributes»
							jsonObject.put("«attr»", org.json.JSONObject.NULL);
							«ENDFOR»
							«ENDFOR»
							
							// delete containing 1:n tables
							«FOR sub : table.containedListChildren»
							{
								«type("java.util.List")»<String> query = new «type("java.util.ArrayList")»<String>();
								«FOR int i : (0..table.keys.size-1)»
								query.add("«table.keys.get(i)»:\"" + identifier.getSegment(«i») + "\""); 
								«ENDFOR»								
								connection.deleteByQuery("«sub.name»", Joiner.on(" AND ").join(query));
							}							
							«ENDFOR»
							riakObject = RiakUtils.updateRiakObject(riakObject, jsonObject, this.jsonConverter);
							riakObject.removeUsermeta("«table.revisionField»");
							connection.store(riakObject);
						} else {
							throw new DataNotFoundException(identifier.toString());
						}
					});
				}
				
				public void update«table.name»(String oldRevision, «type(commonDbDataPckg, table.name + "Data")» data) {
					connectAndConsumeSafely(connection -> {
						«FOR parent : table.parentTables»
						String keyFor«parent.name» = getKey(«FOR int i : (0..parent.keys.size) SEPARATOR ', '»data.getIdentifier().getSegment(«i»)«ENDFOR»);
						if(this.transactionStarted) lock("«parent.name»", keyFor«parent.name»);
						«ENDFOR»
						String riakKey = getKey(data.getIdentifier());
						if(this.transactionStarted) lock("«table.name»", riakKey);
						IRiakObject riakObject = fetch("«table.actualTable.name»", riakKey);
						if(riakObject == null) {
							throw new DataNotFoundException(data.toString());
						}
						JSONObject jsonObject = RiakUtils.fetchJSON(riakObject, this.jsonConverter);
						if(jsonObject == null) {
							throw new DataNotFoundException(data.toString());
						}
						String parentExistsField = "«table.containment.parentTable.revisionField»";
						if(!RiakUtils.contains(jsonObject, parentExistsField)) {
							throw new DataNotFoundException(data.toString());
						}
						
						boolean exists = RiakUtils.contains(jsonObject, "«table.revisionField»");
						if(exists) { // update existing object
							checkRevision(riakObject, "«table.revisionField»", oldRevision);
							jsonObject = new  «type(dbRiakConvertersPckg, "From" + table.name + "Converter")»(jsonObject).convert(data);							
						} else { // create new object
							jsonObject = new «type(dbRiakConvertersPckg, "From" + table.name + "Converter")»(jsonObject).convert(data);							
						}
						riakObject = RiakUtils.updateRiakObject(riakObject, jsonObject, this.jsonConverter);
						riakObject.addUsermeta("«table.revisionField»", data.getRevision());
						connection.store(riakObject);
					});
				}
				
				public «type(commonDbDataPckg, table.name + "Data")» load«table.name»(«type(commonDbDataPckg, "ResourceIdentifier")» identifier, int lock) {
					return connectAndReturnSafely(connection -> {
						«FOR parent : table.parentTables»
						String keyFor«parent.name» = getKey(«FOR int i : (0..parent.keys.size) SEPARATOR ', '»identifier.getSegment(«i»)«ENDFOR»);
						if(lock == Locks.TRANSACTION) lock("«parent.name»", keyFor«parent.name»);
						«ENDFOR»
						String riakKey = getKey(identifier);
						if(lock == Locks.TRANSACTION) lock("«table.name»", riakKey);
						JSONObject jsonObject = fetchJSON(this, "«table.actualTable.name»", riakKey, this.jsonConverter);
						if(jsonObject == null) {
							throw new DataNotFoundException(identifier.toString());
						}
						String parentExistsField = "«table.containment.parentTable.revisionField»";
						if(!RiakUtils.contains(jsonObject, parentExistsField)) {
							throw new DataNotFoundException(identifier.toString());
						}
						boolean exists = RiakUtils.contains(jsonObject, "«table.revisionField»");
						if(!exists) {
							throw new DataNotFoundException(identifier.toString());
						}
						return new «type(dbRiakConvertersPckg, "To" + table.name + "Converter")»().convert(jsonObject);
					});
				}
				«ENDFOR»
				
				
				
			}
			
			
			
			'''
			
		]
	}
	
	def getParentTables(SubTable table) {
		val path = table.actualTablePath
		return path.subList(0, path.size-1);
	}

}
