package com.ggm.goguma.mapper;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JdbcTests {
	static {
		try {
			Class.forName("net.sf.log4jdbc.DriverSpy");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con = DriverManager.getConnection("jdbc:log4jdbc:oracle:thin:@localhost:5151/xe", "goguma", "1234")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}