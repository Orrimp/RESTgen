package examples;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.junit.Test;

import de.fhws.rdsl.riak.RiakSource;

public class JNDIExample {

	@Test
	public void testMySQL() throws NamingException {
		// Get DataSource for MySQL via JNDI
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource dataSource = (DataSource) envCtx.lookup("jdbc/DataSource");
		System.out.println(dataSource);
	}

	@Test
	public void testRiak() throws NamingException {
		// Get RiakSource for Riak via JNDI
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		RiakSource source = (RiakSource) envCtx.lookup("bean/RiakSourceFactory");
		System.out.println(source);
	}

}
