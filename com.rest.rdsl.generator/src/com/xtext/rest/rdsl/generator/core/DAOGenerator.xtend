package com.xtext.rest.rdsl.generator.core

import com.xtext.rest.rdsl.generator.RESTResourceCollection
import com.xtext.rest.rdsl.restDsl.RESTConfiguration
import java.util.HashMap
import java.util.Map
import org.eclipse.xtext.generator.IFileSystemAccess
import com.xtext.rest.rdsl.generator.resources.internal.ExceptionMapper
import com.xtext.rest.rdsl.management.ExtensionMethods
import com.xtext.rest.rdsl.management.PackageManager
import com.xtext.rest.rdsl.management.Constants
import com.xtext.rest.rdsl.management.Naming
import com.xtext.rest.rdsl.restDsl.JavaType
import com.xtext.rest.rdsl.restDsl.ResourceType

class DAOGenerator {
	val IFileSystemAccess fsa;
	val RESTConfiguration config;
	val ExceptionMapper mapper;
	val RESTResourceCollection resourceCol;
	val String idDataType;
	
	//Use extension methods from the given class
	extension ExtensionMethods e = new ExtensionMethods();
	
	new(IFileSystemAccess fsa,  RESTResourceCollection resourceCol, RESTConfiguration config) {
		this.fsa = fsa;
		this.config = config;
		this.resourceCol = resourceCol;
		mapper = new ExceptionMapper(config);
		idDataType = config.IDDataTyp;
	}
	
		
	def generateInterface() {
		for(res: resourceCol.resources){
			fsa.generateFile(Constants.mainPackage + Constants.DAOPACKAGE + "/"  + "I"+ res.name + "DAO" + Constants.JAVA, 
			'''
			package «PackageManager.databasePackage»;
			
			import «PackageManager.objectPackage».*;
			import «Naming.CLASS_DB_QUERY.classImport»;
			import java.util.List;
			
			public interface I«res.name»DAO{
				
				public boolean save(«res.name» «res.name.toLowerCase») throws Exception;
				public boolean update(«res.name» «res.name.toLowerCase», «idDataType» id) throws Exception;
				public «res.name» load(«idDataType» id) throws Exception;
				public boolean delete(«idDataType» id) throws Exception;
				public List<«res.name»> list(«Naming.CLASS_DB_QUERY» query) throws Exception;
				public int count(DBQuery dbquery) throws Exception;
			}
			''');
		}
	}
	
	def generateDAOs() {
		//TODO EINE SCHLEIFE
		for(res: resourceCol.resources){
			
			val objectName = res.name.toLowerCase
			var String updateString = "id = '\"" + "+" + objectName + "." + Naming.METHOD_NAME_ID_GET + "()"+ "+" + "\"'\"";
			var String createString = ""
			for(attrib : res.attributes.filter[!it.list]){
				if( attrib.type instanceof JavaType){
					createString  = createString + " + " +  "\",'\"" + " + " + objectName + "." + "get" +  attrib.name.toFirstUpper + "()" + " + " + "\"'\""
					updateString = updateString + " + " + "\", " + attrib.name + " = \"" + " + " + "\"'\"" + "+" + objectName + ".get" + attrib.name.toFirstUpper + "() " + "+" + "\"'\""
				}
				if( attrib.type instanceof ResourceType){
					val String nullcheck = "(" + objectName + ".get" + attrib.name.toFirstUpper + "() != null ? " +  objectName + ".get" + attrib.name.toFirstUpper + "()"+"." +Naming.METHOD_NAME_ID_GET +"() : null)"
					createString  = createString + " + " +  "\",'\"" + " + " + nullcheck + " + " + "\"'\""
					
					val String nullcheckExt = "(" + objectName + ".get" + attrib.name.toFirstUpper + "() != null ? " + "\"'\"" + " + " + objectName + ".get" + attrib.name.toFirstUpper + "()." + Naming.METHOD_NAME_ID_GET + "()" + " + " + "\"'\"" +  " : null)"
					updateString = updateString + " + " + "\", " + attrib.name + "_id" + " = \"" + " + " +  nullcheckExt			
				}
			}	
						
			fsa.generateFile(Constants.mainPackage + Constants.DAOPACKAGE + "/"  + res.name + "DAO" + Constants.JAVA, 
			'''
			package «PackageManager.databasePackage»;
			
			import «PackageManager.objectPackage».*;
			import java.util.ArrayList;
			import java.util.List;
			import java.sql.Statement;
			import java.sql.SQLException;
			import java.sql.ResultSet;
			import java.sql.Connection;
			import org.apache.log4j.Logger;
			import «Naming.CLASS_JSONCOL_QUERY.classImport»;
			«IF resourceCol.userResource != null»
			import «Naming.CLASS_USER_AUTH_DATA.classImport»;
			import «PackageManager.exceptionPackage».«mapper.get(401).name»;
			import «PackageManager.exceptionPackage».«mapper.get(403).name»;
			«ENDIF»

			
			public class «res.name»DAO implements I«res.name»DAO{
				
				private final «Naming.CLASS_SQLITE» sqlite;
				private static final Logger LOGGER = Logger.getLogger( «res.name.toFirstUpper»DAO.class );
				
				public «res.name»DAO(){
					sqlite = «Naming.CLASS_SQLITE».getInstance();
				}
				
				public boolean save(«res.name» «objectName») throws Exception{
					
					Connection con = null;
					try{
						con = sqlite.getConnection();
						Statement stmt = con.createStatement();
						String insert = "INSERT INTO «res.name.toLowerCase» VALUES('" + «objectName».«Naming.METHOD_NAME_ID_GET»() + "'" «createString» + ")";
						stmt.executeUpdate(insert);
						return true;
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage());
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
							
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				}
				public boolean update(«res.name» «objectName», «config.getIDDataTyp» id) throws Exception{
					
					Connection con = null;
					try{
						con = sqlite.getConnection();
						Statement stmt = con.createStatement();	
			
						String sql = "UPDATE «res.name.toLowerCase» SET «updateString» + " WHERE ID ='" + id + "'";
						stmt.executeUpdate(sql);
						
						return true;
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage()); 
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
						
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				}
				public «res.name» load(«config.getIDDataTyp» id) throws Exception{
				
					Connection con = null;
					try{
						«res.name» «objectName» = null; 
						con = sqlite.getConnection();
						Statement stmt = con.createStatement();
						
						String sqlQuery = "SELECT * FROM «res.name.toLowerCase» WHERE ID = '" +  id + "'";
						
						ResultSet rs = stmt.executeQuery(sqlQuery);
						
							if(rs.next()){
								«objectName» = getObject(rs);
							}
				
						return «objectName»;
						
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage()); 
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				}
				
				public boolean delete(«config.getIDDataTyp» id) throws Exception{
					
					Connection con = null;
					try{
						con = sqlite.getConnection();
						Statement stmt = con.createStatement();
						
						String sqlDelete = "DELETE FROM «res.name.toLowerCase» WHERE ID = '" +  id + "'";
						stmt.executeUpdate(sqlDelete);
						
						return true;
						
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage()); 
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				}
				
				public List<«res.name»> list(«Naming.CLASS_DB_QUERY» query) throws Exception{
					
					Connection con = null;
					try{
						List<«res.name»> list = new ArrayList<«res.name»>(); 
						«res.name» «objectName»; 
						con = sqlite.getConnection();
						Statement stmt = con.createStatement();
						
						String sqlQuery = "SELECT * FROM " + query.getTable() + " "  + query.getWhere(null) + " LIMIT " + query.getLimit() + " OFFSET " + query.getOffset();
						
						ResultSet rs = stmt.executeQuery(sqlQuery);
						while (rs.next()) {
							«objectName» = getObject(rs);
							list.add(«objectName»);
						}
						return list;
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage()); 
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
							
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				}
				
				public int count(DBQuery dbquery) throws Exception{
					
					Connection con = null;
					try{
						con = sqlite.getConnection();
						Statement s = con.createStatement();
						ResultSet r = s.executeQuery("SELECT COUNT(*) AS rowcount FROM «res.name.toLowerCase» " +  dbquery.getWhere(null));
						r.next();
						int count = r.getInt("rowcount") ;
						return count;
					}catch(SQLException ex){
						LOGGER.error("SQLException: " + ex.getMessage()); 
						throw ex;
					}finally{
						if (con != null){
							try { con.close( );  }
							
							catch ( Exception ex ) {
								LOGGER.error("SQLException: " + ex.getMessage()); 
								throw ex;
							}
						}
					}
				
				}

				private «res.name» getObject(ResultSet rs){
					«res.name» «objectName» = null;
					try{
						«objectName» = new «res.name»( rs.get«idDataType.toFirstUpper»("id") ) ;
						«FOR attrib: res.attributes.filter[!it.list]»
						«IF attrib.type instanceof JavaType»
						«objectName».set«attrib.name.toFirstUpper»( rs.get«attrib.type.simpleNameOfType»("«attrib.name»") );
						«ELSEIF attrib.type instanceof ResourceType»
						«idDataType» id«attrib.name.toLowerCase» = rs.get«idDataType.toFirstUpper»("«attrib.name»");
						«var String resource = (attrib.type as ResourceType).resourceRef.name»
						«resource.toFirstUpper» «resource.toLowerCase»  = new «resource.toFirstUpper»(id«attrib.name.toLowerCase»);
						«objectName».set«attrib.name.toFirstUpper»(«resource.toLowerCase»);
						«ENDIF»
						«ENDFOR»
					} catch (SQLException ex) {
						LOGGER.error("SQLException: " + ex.getMessage()); 
					}
					return «objectName»;
				}
					
			«IF resourceCol.userResource != null»
				public boolean authenticate(«Naming.CLASS_USER_AUTH_DATA» authClass) throws «mapper.get(401).name», «mapper.get(403).name»{
					return true;
				}
			«ENDIF»
			}
			''');
		}
	}

	
	def generateDAOAbstract(){
		fsa.generateFile(Naming.ABSTRACT_CLASS_DAO.generationLocation + Constants.JAVA, 
		'''
		package «PackageManager.databasePackage»;
		
			
		public abstract class «Naming.ABSTRACT_CLASS_DAO»{
			
			private static final «Naming.ABSTRACT_CLASS_DAO» instance = «Naming.CLASS_SQLITEDAO».getInstance();
			
			public static «Naming.ABSTRACT_CLASS_DAO» getInstance()
			{
				return instance;
			}
			«FOR res: resourceCol.resources»
			
			public «res.name»DAO create«res.name»DAO(){
				
				return instance.create«res.name»DAO();
			}
			«ENDFOR»
		}
		''')
	}
	
	def generateSQLiteDAO(){
		
		fsa.generateFile(Naming.CLASS_SQLITEDAO.generationLocation + Constants.JAVA, 
		'''
		package «PackageManager.databasePackage»;
		 
		public class «Naming.CLASS_SQLITEDAO» extends «Naming.ABSTRACT_CLASS_DAO» {
		
			private static «Naming.ABSTRACT_CLASS_DAO» instance;
			
			public static «Naming.ABSTRACT_CLASS_DAO» getInstance()
			{
				if(instance == null){
					instance = new «Naming.CLASS_SQLITEDAO»();
				}
				return instance;
			}
			
			«FOR res: resourceCol.resources»
			@Override
			public «res.name»DAO create«res.name»DAO(){
				
				return new «res.name»DAO();
			}
			«ENDFOR»
		}
		''');
	}
	
	def generateSQLite(){
		val Map<String, String> map = new HashMap<String, String>();
		
		for(res: resourceCol.resources){
			var String value = "id " + idDataType + " NOT NULL," ; 
			for(attrib: res.attributes){
				if(attrib.type instanceof JavaType){
					value = value + " " + attrib.name +  " " + attrib.type.simpleNameOfType.toLowerCase + ",";
				}else if(attrib.type instanceof ResourceType){
					value = value + " " + attrib.name + "_id " + idDataType.toLowerCase + ","
				}		
			}
			if(!value.nullOrEmpty){
				value = value.substring(0, value.length-1);
				map.put(res.name, value);
			}
		}
		
		fsa.generateFile(Naming.CLASS_SQLITE.generationLocation + Constants.JAVA,
		'''
		package «PackageManager.databasePackage»;
		
		«FOR imp: Naming.CLASS_SQLITE.baseImports»
		import «imp»;
		«ENDFOR»
		 
		public class «Naming.CLASS_SQLITE»{
			
			private Connection connection;
			private final StringBuffer sb = new StringBuffer();
			
			private static «Naming.CLASS_SQLITE» instance;
			public static «Naming.CLASS_SQLITE» getInstance(){
				if(instance == null)
					instance = new «Naming.CLASS_SQLITE»();
				
				return instance;
			}
			
			private «Naming.CLASS_SQLITE»(){
				connect();
				createAllTables();
			}
			
			public Connection getConnection(){
				connect();
				return connection;
			}
						
			private void connect(){
				try{
					Class.forName("«config.jdbcCon»");
					connection = DriverManager.getConnection("«config.jdbcFile»");
					
				}catch(SQLException ex){
					ex.printStackTrace();
				}catch(ClassNotFoundException e){
					e.printStackTrace();
				}
			}
			
			protected void createAllTables(){
				
				if(connection != null){
				«FOR res: resourceCol.resources»
					createTables«res.name»();
				«ENDFOR»
				}
			}
			
			«FOR res: resourceCol.resources»
			protected void createTables«res.name»(){

				try{
					Statement stmt = connection.createStatement();
					sb.setLength(0);
					sb.append("DROP TABLE IF EXISTS «res.name.toLowerCase»;"); 
					sb.append("CREATE TABLE «res.name.toLowerCase» («map.get(res.name)» );"); 
					sb.append("PRIMARY KEY (`id`)");
					
					stmt.executeUpdate(sb.toString());
				}catch(Exception ex){
					//Log4j
				}
			}
			«ENDFOR»
			
			public void close(){
				if(connection !=null)
					try {
						connection.close();
					}catch (SQLException e) {
						//Log4j
					}
			}
		}
		''');
		}
		
		def generateDBQuery(){
			
		fsa.generateFile(Naming.CLASS_DB_QUERY.generationLocation + Constants.JAVA,
		'''
		package «Naming.CLASS_DB_QUERY.packageName»;

		import java.util.HashMap;
		import java.util.Map;
		
		public class «Naming.CLASS_DB_QUERY» extends HashMap<String, Object> {
		
			/**
			 * 
			 */
			private static final long serialVersionUID = 1L;
			private String where;
			private String table;
			private int offset;
			private int limit;
		
			@Override
			public Object put(String name, Object value) {
				if(value != null)
					return super.put(name, value);
				else
					return null;
			}
			
			public void setTable(String resource){
				this.table = resource;			
			} 
			
			public String getTable(){
				return this.table;
			}
			
			public String getWhere(«config.IDDataTyp» id){
				String returnValue = "WHERE ";
				if(id != null){
					returnValue += ("ID =" + id) + " and "; 
				}
				
				for (Map.Entry<String, Object> entry : this.entrySet()){
			    	String key = entry.getKey();
			    	Object value = entry.getValue();
			   		returnValue += (key + "='" + value + "'" + " and ");
			  	}
			  
			  if(returnValue.endsWith(" and ")){
				returnValue = returnValue.substring(0, returnValue.length() - 4); //Remove last "and "
				return  returnValue;
			  }else{
				return "";
			  }
			}
			
			public void setOffset(int offset){
				this.offset = offset;
			}
			
			public void setLimit(int limit){
				this.limit = limit;
			}	
			
			public int getOffset(){
				return this.offset;
			}
			
			public int getLimit(){
				return this.limit;
			}
		}
		'''	)
		}
}